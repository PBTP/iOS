//
//  NetworkImp.swift
//  Core
//
//  Created by Bokyung on 12/30/24.
//  Copyright © 2024 Mongle. All rights reserved.
//

import Combine
import Network
import SwiftUI

public protocol Network {
    func request<T: Request>(_ request: T) -> AnyPublisher<Response<T.Output>, Error>
    func put(key: HeaderKey, value: String?)
    func get(key: HeaderKey) -> String?
}

public final class NetworkImp: Network {
    private let session: URLSession
    private var defaultHeader: HTTPHeader = [:]

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func request<T: Request>(_ request: T) -> AnyPublisher<Response<T.Output>, Error> {
        do {
            var urlRequest = try RequestFactory(request: request).buildRequest()
            defaultHeader.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }

            return session.dataTaskPublisher(for: urlRequest)
                .handleEvents(receiveOutput: logNetworkData(for: urlRequest))
                .tryMap { data, response in
                    try self.handleResponse(data: data, response: response, outputType: T.Output.self)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

    public func put(key: HeaderKey, value: String?) {
        defaultHeader[key.rawValue] = value
    }

    public func get(key: HeaderKey) -> String? {
        return defaultHeader[key.rawValue]
    }

    private func logNetworkData(for request: URLRequest) -> ((Data, URLResponse) -> Void) {
        return { data, response in
            guard let urlString = request.url?.absoluteString,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  let responseString = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }

            let log = """
            \(statusCode / 100 == 2 ? "200" : "Error") \(request.httpMethod ?? "") \(urlString) (\(statusCode))
            [Default Header]: \(self.defaultHeader)
            [Request Header]: \(request.allHTTPHeaderFields ?? [:])
            [Response]: \(responseString)
            ==========================================================
            """
            print(log)
        }
    }

    private func handleResponse<T: Decodable>(data: Data, response: URLResponse, outputType: T.Type) throws -> Response<T> {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknownError
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(ServerError(rawValue: httpResponse.statusCode) ?? .unknown)
        }

        do {
            let output = try JSONDecoder().decode(T.self, from: data)
            return Response(data: output, message: "Success", statusCode: httpResponse.statusCode, secretMessage: nil)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

private final class RequestFactory<T: Request> {
    private let request: T
    private var urlComponents: URLComponents?

    init(request: T) {
        self.request = request
        self.urlComponents = URLComponents(url: request.endpoint, resolvingAgainstBaseURL: true)
    }

    func buildRequest() throws -> URLRequest {
        switch request.method {
        case .get, .delete:
            return try buildQueryRequest()
        case .post, .put, .patch:
            return try buildBodyRequest()
        }
    }

    private func buildQueryRequest() throws -> URLRequest {
        urlComponents?.queryItems = request.query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        return try buildURLRequest()
    }

    private func buildBodyRequest() throws -> URLRequest {
        let bodyData = try JSONSerialization.data(withJSONObject: request.query, options: [])
        return try buildURLRequest(httpBody: bodyData)
    }

    private func buildURLRequest(httpBody: Data? = nil) throws -> URLRequest {
        guard let url = urlComponents?.url else {
            throw NetworkError.urlRequestError(URLError(.badURL))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.header
        urlRequest.httpBody = httpBody

        if httpBody != nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }
}
