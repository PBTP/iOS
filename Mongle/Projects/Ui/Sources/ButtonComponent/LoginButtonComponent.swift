//
//  LoginButtonComponent.swift
//  LoginButtonComponent
//
//  Created by bulmang on 4/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public func kakaoLoginButton(action: @escaping () -> Void) -> some View {
    Button {
        print("카카오 로그인 버튼 클릭")
        action()
    } label: {
        RoundedRectangle(cornerRadius: 8)
            .foregroundStyle(Color.kakaoLoginBackGround)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .overlay {
                HStack(spacing: 12) {
                    Image.kakaoLogo
                    Text("카카오로 시작하기")
                        .font(.mgTitle2)
                        .foregroundStyle(Color.black)
                }
            }
    }
}

public func appleLoginButton(action: @escaping () -> Void) -> some View {
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

public func gray400WithLineButton(_ buttonText: String, action: @escaping () -> Void) -> some View {
    Button {
        print("그레이 버튼 클릭")
        action()
    } label: {
        Text(buttonText)
            .font(.mgBody4)
            .foregroundStyle(Color.mongleGrayScale400)
    }
}

#Preview("로그인 뷰 컴포넌트") {
    VStack(spacing: 50) {
        kakaoLoginButton {}
        appleLoginButton {}
        gray400WithLineButton("둘러보기") {}
        gray400WithLineButton("문의하기") {}
    }
}

