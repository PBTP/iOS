//
//  NetworkError.swift
//  Core
//
//  Created by Bokyung on 12/30/24.
//  Copyright © 2024 Mongle. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case unknownError
    case componentsError
    case urlRequestError(Error)
    case serverError(ServerError)
    case emptyData
    case parsingError
    case decodingError(Error)
}

enum ServerError: Int {
    case unknown = 0
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case internalServerError = 500
    case serviceUnavailable = 503
}
