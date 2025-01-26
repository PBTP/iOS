//
//  LoginView.swift
//  OnBoardingFeature
//
//  Created by bulmang on 4/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import AuthenticationServices
import ComposableArchitecture
import Core
import HomeFeature
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import SwiftUI
import UI

public struct LoginView: View {
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore

    @State private var hasAccessToken = false
    @State private var isShowTermsAgreeSheet = false
    @State var isRequiredTermsAgreed = false

    public init() {
        KakaoSDK.initSDK(appKey: APPKey.kakaoAppKey)
    }

    public var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Spacer()
                Image.petLogo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:229, height: 202)
                Text("반가워요!")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.mongleColorPrimary300)
                Text("행복한 대형견 목욕의 시작, 몽글입니다")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.mongleGrayScale900)
                Spacer()
                kakaoLoginButton {
                    kakaoAuth.loginKakaoAccount() { success in
                        if success {
                            print("카카오 로그인 성공")
                            //hasAccessToken = true
                            isShowTermsAgreeSheet = true
                        } else {
                            print("카카오 로그인 실패")
                            hasAccessToken = false
                        }
                    }
                }
                appleLoginButton {
                    // TODO: Apple Login
                }
                HStack(spacing: 8) {
                    gray400WithLineButton("둘러보기") {
                        //  TODO: 둘러보기
                    }
                    Divider()
                        .frame(width: 1.5, height: 16)
                        .foregroundStyle(Color.mongleGrayScale400)
                    gray400WithLineButton("문의하기") {
                        // TODO: 문의하기
                    }
                }
                .padding(.top, 24)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 60)
            .onOpenURL(perform: { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            })
            .onReceive(kakaoAuth.$customer) { customer in
                if customer.accessToken != nil {
                    hasAccessToken = true
                }
            }
            .sheet(isPresented: $isShowTermsAgreeSheet) {
                AgreeTermsSheet(isRequiredTermsAgreed: $isRequiredTermsAgreed)
                    .presentationDetents([.medium])
            }
            .navigationDestination(isPresented: $isRequiredTermsAgreed) {
                PhoneNumberVerificationView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(KaKaoAuthCore())
    }
}
