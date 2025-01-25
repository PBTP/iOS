//
//  NetworkManager.swift
//  Core
//
//  Created by bulmang on 6/19/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

// TODO: 제거 필요
class NetworkManager {
    static let shared = NetworkManager()
    private let config: ConfigImp

    init(config: ConfigImp = ConfigImp()) {
        self.config = config
    }

    func sendUserData(customer: Customer, completion: @escaping (Result<CustomerData, Error>) -> Void) {
        guard let url = URL(string: "\(config.baseURL)/v1/auth/login") else {
            print("Error creating URL")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error creating URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let userData: [String: String?] = [
            "uuid": customer.uuid,
            "userType": customer.userType,
            "customerName": customer.customerName,
            "authProvider": customer.authProvider
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: userData, options: [])
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error sending user data: \(error)")
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Response Status Code: \(httpResponse.statusCode)")
                    
                    if (200...299).contains(httpResponse.statusCode) {
                        if let data = data, let responseString = String(data: data, encoding: .utf8) {
                            print("Response Data: \(responseString)")
                            
                            if let updatedCustomer = JsonDecoder.shared.decodeCustomerResponse(from: responseString) {
                                print("Customer UUID: \(updatedCustomer.data.userId)")
                                print("Customer Name: \(updatedCustomer.data.userType)")
                                print("Auth Provider: \(updatedCustomer.data.authProvider)")
                                print("Access Token: \(updatedCustomer.data.accessToken)")
                                print("Refresh Token: \(updatedCustomer.data.refreshToken)")

                                DispatchQueue.main.async {
                                    completion(.success(updatedCustomer.data))
                                }
                            } else {
                                print("Failed to decode customer")
                                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode customer"])))
                            }
                        } else {
                            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
                        }
                    } else {
                        print("Failed to send user data")
                        completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP error"])))
                    }
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                }
            }
            task.resume()
        } catch {
            print("Error creating JSON data: \(error)")
            completion(.failure(error))
        }
    }
}

