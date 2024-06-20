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
import SwiftUI
import Ui
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

public struct LoginView: View {
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    
    public init() {
        if let appKey = ProcessInfo.processInfo.environment["KAKAO_APP_KEY"] {
            KakaoSDK.initSDK(appKey: appKey)
        }
    }
    
    public var body: some View {
        
        VStack(spacing: 12) {
            HeaderComponent(headerText: "로그인", iconImageName: Image.xCloseIcon) {}
            
            Spacer()
            
            KaKaoLoginButton {
                kakaoAuth.loginKakaoAccount()
            }
            
            AppleSigninButton()
            
            SkipLoginButton {}
                .padding(.top, 24)
                .padding(.bottom, 50)
        }
        .padding(.horizontal, 20)
        .onOpenURL(perform: { url in
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        })
    }
}

struct AppleSigninButton : View {
    let store = Store(initialState: AppleAuthCore.State()) {
        AppleAuthCore().body._printChanges()
    }
    
    var body: some View{
        VStack {
            SignInWithAppleButton(
                .continue,
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        print("Apple Login Successful")
                        switch authResults.credential{
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            store.send(.appleButtonTapped(appleIDCredential))
                            
                        default:
                            break
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        print("error")
                    }
                }
            )
            .frame(maxWidth: .infinity)
            .frame(height:46)
            .cornerRadius(8)
        }
    }
}

#Preview {
    LoginView()
}
