//
//  NetworkManager.swift
//  Core
//
//  Created by bulmang on 6/19/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func sendUserData(customer: Customer, completion: @escaping (Result<Customer, Error>) -> Void) {
        guard let url = URL(string: API.authLogin) else {
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
            "customerName": customer.customerName ?? nil,
            "authProvider": customer.authProvider ?? nil,
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
                            
                            if let updatedCustomer = JsonDecoder.shared.decodeCustomer(from: responseString) {
                                print("Customer UUID: \(updatedCustomer.uuid ?? "nil")")
                                print("Customer Name: \(updatedCustomer.customerName ?? "nil")")
                                print("Auth Provider: \(updatedCustomer.authProvider ?? "nil")")
                                print("Access Token: \(updatedCustomer.accessToken ?? "nil")")
                                print("Refresh Token: \(updatedCustomer.refreshToken ?? "nil")")
                                
                                DispatchQueue.main.async {
                                    completion(.success(updatedCustomer))
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

