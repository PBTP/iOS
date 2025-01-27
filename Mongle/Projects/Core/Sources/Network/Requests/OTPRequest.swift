//
//  OTPRequest.swift
//  Core
//
//  Created by Bokyung on 1/26/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import Foundation

public struct OTPRequest: Request {
    public typealias Output = OTPDTO

    public let endpoint: URL
    public let method: HTTPMethod
    public let query: [String: Any]
    public let header: HTTPHeader

    public init(_ baseURL: URL, secret: String, otp: String) {
        self.endpoint = baseURL.appendingPath("/v1/auth/otp")
        self.method = .post
        self.query = [
            "secret": secret,
            "otp": otp
        ]
        self.header = ["Authorization": "Bearer \(UserSettings.accessToken)"]
    }
}
