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
                Text(LoginText.welcomeText)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.mongleColorPrimary300)
                Text(LoginText.infoText)
                    .font(.system(size: 16))
                    .foregroundStyle(Color.mongleGrayScale900)
                Spacer()
                kakaoLoginButton {
                    kakaoAuth.loginKakaoAccount() { success in
                        if success {
                            print("카카오 로그인 성공")
                            hasAccessToken = true
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
                    gray400WithLineButton(LoginText.browseText) {
                        hasAccessToken = true
                    }
                    Divider()
                        .frame(width: 1.5, height: 16)
                        .foregroundStyle(Color.mongleGrayScale400)
                    gray400WithLineButton(LoginText.contactText) {
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
            .navigationDestination(isPresented: $hasAccessToken) {
                HomeView()
                    .navigationBarBackButtonHidden()
                    .overlay(alignment: .bottom) {
                        NavigationLink {
                            WebView()
                        } label: {
                            Text("WebView 연결")
                                .font(.mgTitle2)
                                .foregroundStyle(Color.mongleGrayScale0)
                                .padding(.vertical, 17)
                                .frame(maxWidth: .infinity)
                                .background(Color.mongleColorPrimary300)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        
                    }
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
