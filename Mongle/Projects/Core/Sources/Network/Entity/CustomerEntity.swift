//
//  CustomerEntity.swift
//  Core
//
//  Created by Bokyung on 1/25/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import Foundation

public struct CustomerEntity: Codable {
    public let uuid: String
    public let userType: String
    public let customerName: String
    public let authProvider: String
    public let accessToken: String
    public let refreshToken: String
}
