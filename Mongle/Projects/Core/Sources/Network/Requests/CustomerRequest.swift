//
//  CustomerRequest.swift
//  Core
//
//  Created by Bokyung on 1/25/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import Foundation

public struct CustomerRequest: Request {
    public typealias Output = CustomerDTO

    public let endpoint: URL
    public let method: HTTPMethod
    public let query: [String: Any]
    public let header: HTTPHeader

    public init(_ baseURL: String, uuid: String, userType: String, customerName: String, authProvider: String) {
        self.endpoint = URL(string: "\(baseURL)/v1/auth/login")!
        self.method = .post
        self.query = [
            "uuid": uuid,
            "userType": userType,
            "customerName": customerName,
            "authProvider": authProvider
        ]
        self.header = ["Authorization" : "Bearer \(UserSettings.accessToken)"]
    }
}
