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

    func decodeCustomerResponse(from responseString: String) -> CustomerResponse? {
        let decoder = JSONDecoder()
        if let data = responseString.data(using: .utf8) {
            do {
                let customerResponse = try decoder.decode(CustomerResponse.self, from: data)
                return customerResponse
            } catch {
                print("Error decoding JSON: \(error)")
                return nil
            }
        }
        return nil
    }
}
