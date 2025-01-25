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

    public init(_ baseURL: String, authPrivider: String, userType: String, userId: Int, phoneNumber: String, uuid: String, name: String) {
        self.endpoint = URL(string: "\(baseURL)/v1/auth/login")!
        self.method = .post
        self.query = [
            "authProvider": authPrivider,
            "userType": userType,
            "userId": userId,
            "phoneNumber": phoneNumber,
            "uuid": uuid,
            "name": name
        ]
        self.header = [:]
    }
}
