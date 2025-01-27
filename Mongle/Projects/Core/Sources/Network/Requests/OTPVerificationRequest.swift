//
//  OTPVerificationRequest.swift.swift
//  Core
//
//  Created by Bokyung on 1/27/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import Foundation

public struct OTPVerificationRequest: Request {
    public typealias Output = OTPVerificationDTO

    public let endpoint: URL
    public let method: HTTPMethod
    public let query: [String: Any]
    public let header: HTTPHeader

    public init(_ baseURL: URL, verifyCode: String, otp: String) {
        self.endpoint = baseURL.appendingPath("/v1/auth/otp/verification")
        self.method = .post
        self.query = [
            "secret": verifyCode,
            "otp": "sms"
        ]
        self.header = ["Authorization": "Bearer \(UserSettings.accessToken)"]
    }
}
