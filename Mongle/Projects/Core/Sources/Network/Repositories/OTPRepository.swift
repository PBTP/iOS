//
//  OTPRepository.swift
//  Core
//
//  Created by Bokyung on 1/26/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import Combine
import Foundation

public protocol OTPRepository {
    func postAuthOTP(secret: String) -> AnyPublisher<OTPDTO, Error>
    func postAuthOTPVerification(verifyCode: String) -> AnyPublisher<OTPVerificationDTO, Error>
}

public class OTPRepositoryImp: OTPRepository {
    private let baseURL: URL
    private let network: Network

    public init(
        baseURL: URL,
        network: Network
    ) {
        self.baseURL = baseURL
        self.network = network
    }
}

public extension OTPRepositoryImp {
    func postAuthOTP(secret: String) -> AnyPublisher<OTPDTO, Error> {
        let request = OTPRequest(baseURL, secret: secret, otp: "sms")
        return network.request(request)
            .compactMap(\.data)
            .eraseToAnyPublisher()
    }

    func postAuthOTPVerification(verifyCode: String) -> AnyPublisher<OTPVerificationDTO, Error> {
        let request = OTPVerificationRequest(baseURL, verifyCode: verifyCode, otp: "sms")
        return network.request(request)
            .compactMap(\.data)
            .eraseToAnyPublisher()
    }
}
