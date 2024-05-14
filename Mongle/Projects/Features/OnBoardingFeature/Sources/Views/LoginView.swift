//
//  LoginView.swift
//  OnBoardingFeature
//
//  Created by bulmang on 4/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import Ui
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

public struct LoginView: View {
    public init() {
        if let appKey = ProcessInfo.processInfo.environment["KAKAO_APP_KEY"] {
                  KakaoSDK.initSDK(appKey: appKey)
        }
    }
    
    let store = Store(initialState: OnBoardingReducer.State.authentication(.init())) {
        OnBoardingReducer.body._printChanges()
    }
    
    public var body: some View {
        
            VStack(spacing: 12) {
                HeaderComponent(headerText: "로그인", iconImageName: Image.xCloseIcon) {}
                
                Spacer()
                
                KaKaoLoginButton {
                    store.send(.authentication(.loginKakaoAccount))
                }
                
                AppleLoginButton {}
                
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

#Preview {
    LoginView()
}
