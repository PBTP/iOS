//
//  Customer.swift
//  Core
//
//  Created by bulmang on 6/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Foundation

public struct Customer: Codable, Equatable {
    var customerId: String?
    var uuid: String?
    var customerName: String?
    var customerPhoneNumber: String?
    var authProvider: String?
    var accessToken: String?
    var refreshToken: String?
    
    public init(
        customerId: String? = nil,
        uuid: String? = nil,
        customerName: String? = nil,
        customerPhoneNumber: String? = nil,
        authProvider: String? = nil,
        accessToken: String? = nil,
        refreshToken: String? = nil
    ) {
        self.customerId = customerId
        self.uuid = uuid
        self.customerName = customerName
        self.customerPhoneNumber = customerPhoneNumber
        self.authProvider = authProvider
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
