//
//  JsonDecoder.swift
//  Core
//
//  Created by bulmang on 6/19/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Foundation

public class JsonDecoder {
    
    public init() {}
    
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
    
    public func formatAddress(from jsonString: String) -> String {
        let jsonData = Data(jsonString.utf8)
        
        do {
            let address = try JSONDecoder().decode(Address.self, from: jsonData)
            return "\(address.address) \(address.detailAddress)"
        } catch {
            print("Failed to decode JSON: \(error)")
            return "Error decoding JSON"
        }
    }
}
