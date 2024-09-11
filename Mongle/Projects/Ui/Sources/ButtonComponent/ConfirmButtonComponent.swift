//
//  ConfirmButton.swift
//  Ui
//
//  Created by bulmang on 4/16/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public func confirmButton(_ buttonText: String, isDisabeld: Bool = false, action: @escaping () -> Void) -> some View {
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

public func requestButton(_ buttonText: String, action: @escaping () -> Void) -> some View {
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

public func mongleButton(_ buttonText: String, buttonColor: Color, textColor: Color, textFont: Font, verticalPadding: Double, horizontalPadding: Double, radius: Double, action: @escaping () -> Void) -> some View {
    Button {
        print("\(buttonText) 버튼 클릭")
        action()
    } label: {
            Text(buttonText)
                .font(textFont)
                .foregroundColor(textColor)
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .background(buttonColor)
                .clipShape(RoundedRectangle(cornerRadius: radius))
    }
}

public func iconHorizontalButton(_ buttonText: String, buttonColor: Color, textColor: Color, textFont: Font, verticalPadding: Double, horizontalPadding: Double, radius: Double, iconImage: Image, spacing: Double, iconLeft: Bool, action: @escaping () -> Void) -> some View {
    Button {
        print("\(buttonText) 버튼 클릭")
        action()
    } label: {
            HStack(spacing: spacing) {
                
                if iconLeft {
                    iconImage
                }
                
                Text(buttonText)
                    .font(textFont)
                    .foregroundColor(textColor)
                
                if !iconLeft {
                    iconImage
                }
            }
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background(buttonColor)
            .clipShape(RoundedRectangle(cornerRadius: radius))
    }
}

public func infinityStrokeButton(_ buttonText: String, buttonColor: Color, textColor: Color, strokeColor: Color,textFont: Font, verticalPadding: Double, radius: Double, lineWidth: Double, action: @escaping () -> Void) -> some View {
    Button {
        print("\(buttonText) 버튼 클릭")
        action()
    } label: {
            Text(buttonText)
                .font(textFont)
                .foregroundColor(textColor)
                .padding(.vertical, verticalPadding)
                .frame(maxWidth: .infinity)
                .background(buttonColor)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(strokeColor, lineWidth: lineWidth)
                )
    }
}

public func strokeButton(_ buttonText: String, buttonColor: Color, textColor: Color, strokeColor: Color,textFont: Font, verticalPadding: Double, horizontalPadding: Double, radius: Double, lineWidth: Double, action: @escaping () -> Void) -> some View {
    Button {
        print("\(buttonText) 버튼 클릭")
        action()
    } label: {
            Text(buttonText)
                .font(textFont)
                .foregroundColor(textColor)
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .background(buttonColor)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(strokeColor, lineWidth: lineWidth)
                )
    }
}

#Preview {
    ZStack {
        Color.mongleGrayScale200
            .ignoresSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        VStack(spacing: 20) {
            confirmButton("인증번호 전송", isDisabeld: false) {}
            
            requestButton("재요청") {}
            
            iconHorizontalButton("목욕 업체 둘러보기", buttonColor: Color.mongleGrayScale500, textColor: Color.mongleGrayScale0, textFont: .mgBody4, verticalPadding: 11, horizontalPadding: 12, radius: 8, iconImage: Image.searchIcon, spacing: 8, iconLeft: true) {
            }
            
            infinityStrokeButton("취소", buttonColor: Color.clear, textColor: Color.mongleGrayScale800, strokeColor: Color.mongleGrayScale300, textFont: .mgTitle2, verticalPadding: 17, radius: 8, lineWidth: 1) {
            }
        }
    }
}
