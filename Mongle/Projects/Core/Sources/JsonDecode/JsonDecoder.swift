//
//  JsonDecoder.swift
//  Core
//
//  Created by bulmang on 6/19/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Foundation

class JsonDecoder {
    static let shared = JsonDecoder()
    
    private init() {}
    
    func decodeCustomer(from jsonString: String) -> Customer? {
        let jsonData = jsonString.data(using: .utf8)!
        
        do {
            let customer = try JSONDecoder().decode(Customer.self, from: jsonData)
            return customer
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
