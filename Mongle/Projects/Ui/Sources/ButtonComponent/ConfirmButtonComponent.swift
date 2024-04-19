//
//  ConfirmButton.swift
//  Ui
//
//  Created by bulmang on 4/16/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public func ConfirmButton(_ buttonText: String, isDisabeld: Bool = false, action: @escaping () -> Void) -> some View {
    Button {
        print("\(buttonText) 버튼 클릭")
        action()
    } label: {
        Text(buttonText)
            .font(.mgTitle2)
            .foregroundStyle(Color.mongleGrayScale0)
            .padding(.vertical, 17)
            .frame(maxWidth: .infinity)
            .background(isDisabeld ? Color.mongleGrayScale300 : Color.mongleColorPrimary300)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    .disabled(isDisabeld)
}

public func RequestButton(_ buttonText: String, action: @escaping () -> Void) -> some View {
    Button {
        print("\(buttonText) 버튼 클릭")
        action()
    } label: {
        Text(buttonText)
            .font(.mgBody4)
            .foregroundColor(Color.mongleColorPrimary300)
            .padding(.vertical, 6)
            .padding(.horizontal, 16)
            .background(Color.mongleGrayScale0)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    ZStack {
        Color.mongleGrayScale200
            .ignoresSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        VStack(spacing: 20) {
            ConfirmButton("인증번호 전송", isDisabeld: false) {}
            
            RequestButton("재요청") {}
        }
    }
}
