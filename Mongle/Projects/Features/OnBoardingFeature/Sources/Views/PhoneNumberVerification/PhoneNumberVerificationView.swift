//
//  PhoneNumberVerificationView.swift
//  OnBoardingFeature
//
//  Created by bulmang on 4/15/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI
import Core

public struct PhoneNumberVerificationView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: PhoneNumberVerificationViewModel
    @State private var isRequestVerifyNumber = false
    @State private var phoneNumber: String = ""
    @State private var verifyCode: String = ""

    public init(viewModel: PhoneNumberVerificationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: 8) {
            HeaderComponent(
                headerText: "휴대폰 번호 인증",
                iconImageName: Image.arrowLeftIcon
            ) {
                presentationMode.wrappedValue.dismiss()
            }
            if isRequestVerifyNumber {
                Text("인증번호")
                    .font(.mgBody3)
                    .foregroundStyle(Color.mongleGrayScale700)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 50)
                MongleNumberTextField(
                    text: $verifyCode,
                    placeHolder: "인증번호",
                    timerActive: isRequestVerifyNumber,
                    requestButtonActive: false
                )
            }
            Text("연락처")
                .font(.mgBody3)
                .foregroundStyle(Color.mongleGrayScale700)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
            MongleNumberTextField(
                text: $phoneNumber,
                placeHolder: "010-0000-0000",
                timerActive: false,
                requestButtonActive: isRequestVerifyNumber
            )
            if isRequestVerifyNumber {
                confirmButton("인증번호 확인", isDisabeld: false) {
                    viewModel.requestOTPVerification(verifyCode: verifyCode)
                }
                .padding(.top, 16)
            } else {
                confirmButton("인증번호 전송", isDisabeld: false) {
                    withAnimation {
                        isRequestVerifyNumber = true
                    }
                    viewModel.requestOTP(secret: phoneNumber)
                }
                .padding(.top, 16)
            }
            VStack(alignment: .leading, spacing:0) {
                Text("인증번호 발송에는 시간이 소요됩니다.")
                Text("인증번호는 문자메시지로 발송되며, 수신하지 못했다면 차단된 메시지를 확인")
                Text("해주세요.")
            }
            .font(.mgCaption1)
            .foregroundStyle(Color.mongleGrayScale500)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    PhoneNumberVerificationView(viewModel: PhoneNumberVerificationViewModel(otpRepository: OTPRepositoryImp(baseURL: ConfigImp().baseURL.toURL(), network: NetworkImp())))
}
