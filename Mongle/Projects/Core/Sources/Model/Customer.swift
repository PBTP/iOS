//
//  Customer.swift
//  Core
//
//  Created by bulmang on 6/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Foundation

public struct Customer: Codable {
    public var uuid: String?
    public var customerName: String?
    public var authProvider: String?
    public var userType: String = "customer"
    public var accessToken: String?
    public var refreshToken: String?
    
    public init(
        uuid: String? = nil,
        customerName: String? = nil,
        authProvider: String? = nil,
        accessToken: String? = nil,
        refreshToken: String? = nil
    ) {
        self.uuid = uuid
        self.customerName = customerName
        self.authProvider = authProvider
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
