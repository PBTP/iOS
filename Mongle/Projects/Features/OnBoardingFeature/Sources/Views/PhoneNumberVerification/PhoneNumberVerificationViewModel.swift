//
//  PhoneNumberVerificationViewModel.swift
//  OnBoardingFeature
//
//  Created by Bokyung on 1/26/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import Combine
import Core
import Foundation

public class PhoneNumberVerificationViewModel: ObservableObject {
    @Published public var isOtpVerifyNumberSent: Bool = false
    @Published public var isPhoneNumberVerified: Bool = false
    @Published public var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()

    private let otpRepository: OTPRepository

    public init(otpRepository: OTPRepository) {
        self.otpRepository = otpRepository
    }

    func requestOTP(secret: String) {
        otpRepository.postAuthOTP(secret: secret)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "인증번호 요청에 실패했습니다: \(error.localizedDescription)"
                    self.isOtpVerifyNumberSent = false
                case .finished:
                    break
                }
            } receiveValue: { _ in
                self.isOtpVerifyNumberSent = true
            }
            .store(in: &cancellables)
    }

    func requestOTPVerification(verifyCode: String) {
        otpRepository.postAuthOTPVerification(verifyCode: verifyCode)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "인증번호 요청에 실패했습니다: \(error.localizedDescription)"
                case .finished:
                    self.isPhoneNumberVerified = true
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}
