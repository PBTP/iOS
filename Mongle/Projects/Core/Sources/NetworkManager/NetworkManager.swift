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
    
    func sendUserData(customer: Customer) {
        guard let url = URL(string: "https://api.mgmg.life/v1/auth/login") else {
            print("Error creating URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let userData: [String: String?] = [
            "uuid": customer.uuid,
            "customerName": customer.customerName ?? nil,
            "authProvider": customer.authProvider ?? nil,
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: userData, options: [])
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error sending user data: \(error)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Response Status Code: \(httpResponse.statusCode)")
                    
                    if let data = data, let responseString = String(data: data, encoding: .utf8) {
                        print("Response Data: \(responseString)")
                    }
                    
                    if (200...299).contains(httpResponse.statusCode) {
                        print("User data sent successfully")
                    } else {
                        print("Failed to send user data")
                    }
                }
            }
            task.resume()
        } catch {
            print("Error creating JSON data: \(error)")
        }
    }
}
