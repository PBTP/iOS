//
//  LoginView.swift
//  OnBoardingFeature
//
//  Created by bulmang on 4/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Ui
import SwiftUI

public struct LoginView: View {
    public init() {}
    
    public var body: some View {
            VStack(spacing: 12) {
                HeaderComponent(headerText: "로그인", iconImageName: Image.xCloseIcon) {}
                
                Spacer()
                
                KaKaoLoginButton {}
                
                AppleLoginButton {}
                
                SkipLoginButton {}
                .padding(.top, 24)
                .padding(.bottom, 50)
            }
            .padding(.horizontal, 20)
    }
}

#Preview {
    LoginView()
}
