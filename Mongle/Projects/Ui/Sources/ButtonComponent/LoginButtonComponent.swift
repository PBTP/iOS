//
//  LoginButtonComponent.swift
//  LoginButtonComponent
//
//  Created by bulmang on 4/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public func KaKaoLoginButton(action: @escaping () -> Void) -> some View {
    Button {
        print("카카오 로그인 버튼 클릭")
        action()
    } label: {
        RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(Color.kakaoLoginBackGround)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .overlay {
                HStack {
                    Image.kakoLogo
                    
                    Text("카카오로 시작하기")
                        .font(.mgTitle2)
                        .foregroundStyle(Color.black)
                }
            }
    }
}

public func AppleLoginButton(action: @escaping () -> Void) -> some View {
    Button {
        print("애플 로그인 버튼 클릭")
        action()
    } label: {
        Image.appleLogin
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
    }
}

public func SkipLoginButton(action: @escaping () -> Void) -> some View {
    Button {
        print("로그인 없이 이용하기 버튼 클릭")
        action()
    } label: {
        Text("로그인 없이 둘러보기")
            .font(.mgBody4)
            .foregroundStyle(Color.mongleGrayScale400)
            .frame(maxWidth: .infinity)
    }
}


#Preview {
    VStack(spacing: 50) {
        KaKaoLoginButton {}
        AppleLoginButton {}
        SkipLoginButton {}
    }
}

