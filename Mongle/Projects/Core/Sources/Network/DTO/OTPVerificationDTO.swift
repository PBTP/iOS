//
//  OTPVerificationDTO.swift
//  Core
//
//  Created by Bokyung on 1/27/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import Foundation

public struct OTPVerificationDTO: Codable {
    public let otp: String
    public let verified: Bool
}
