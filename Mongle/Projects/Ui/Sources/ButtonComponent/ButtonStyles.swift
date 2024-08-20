//
//  ButtonStyles.swift
//  Ui
//
//  Created by bulmang on 6/26/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

// ConfirmButtonStyle
public struct ConfirmButtonStyle: ButtonStyle {
    var isDisabled: Bool

    public init(isDisabled: Bool) {
        self.isDisabled = isDisabled
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.mgTitle2)
            .foregroundColor(Color.mongleGrayScale0)
            .padding(.vertical, 17)
            .frame(maxWidth: .infinity)
            .background(isDisabled ? Color.mongleGrayScale300 : Color.mongleColorPrimary300)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

// RequestButtonStyle
public struct RequestButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.mgBody4)
            .foregroundColor(Color.mongleColorPrimary300)
            .padding(.vertical, 6)
            .padding(.horizontal, 16)
            .background(Color.mongleGrayScale0)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

// MongleButtonStyle
public struct MongleButtonStyle: ButtonStyle {
    var buttonColor: Color
    var textColor: Color
    var textFont: Font
    var verticalPadding: Double
    var horizontalPadding: Double
    var radius: Double

    public init(buttonColor: Color, textColor: Color, textFont: Font, verticalPadding: Double, horizontalPadding: Double, radius: Double) {
        self.buttonColor = buttonColor
        self.textColor = textColor
        self.textFont = textFont
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.radius = radius
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(textFont)
            .foregroundColor(textColor)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background(buttonColor)
            .clipShape(RoundedRectangle(cornerRadius: radius))
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

// IconHorizontalButtonStyle
public struct IconHorizontalButtonStyle: ButtonStyle {
    var buttonColor: Color
    var textColor: Color
    var textFont: Font
    var verticalPadding: Double
    var horizontalPadding: Double
    var radius: Double
    var iconImage: Image
    var spacing: Double
    var iconLeft: Bool

    public init(buttonColor: Color, textColor: Color, textFont: Font, verticalPadding: Double, horizontalPadding: Double, radius: Double, iconImage: Image, spacing: Double, iconLeft: Bool) {
        self.buttonColor = buttonColor
        self.textColor = textColor
        self.textFont = textFont
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.radius = radius
        self.iconImage = iconImage
        self.spacing = spacing
        self.iconLeft = iconLeft
    }

    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: spacing) {
            if iconLeft {
                iconImage
            }

            configuration.label
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
        .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

// InfinityStrokeButtonStyle
public struct InfinityStrokeButtonStyle: ButtonStyle {
    var buttonColor: Color
    var textColor: Color
    var strokeColor: Color
    var textFont: Font
    var verticalPadding: Double
    var radius: Double
    var lineWidth: Double

    public init(buttonColor: Color, textColor: Color, strokeColor: Color, textFont: Font, verticalPadding: Double, radius: Double, lineWidth: Double) {
        self.buttonColor = buttonColor
        self.textColor = textColor
        self.strokeColor = strokeColor
        self.textFont = textFont
        self.verticalPadding = verticalPadding
        self.radius = radius
        self.lineWidth = lineWidth
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(textFont)
            .foregroundColor(textColor)
            .padding(.vertical, verticalPadding)
            .frame(maxWidth: .infinity)
            .background(buttonColor)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(strokeColor, lineWidth: lineWidth)
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

// StrokeButtonStyle
public struct StrokeButtonStyle: ButtonStyle {
    var buttonColor: Color
    var textColor: Color
    var strokeColor: Color
    var textFont: Font
    var verticalPadding: Double
    var horizontalPadding: Double
    var radius: Double
    var lineWidth: Double

    public init(buttonColor: Color, textColor: Color, strokeColor: Color, textFont: Font, verticalPadding: Double, horizontalPadding: Double, radius: Double, lineWidth: Double) {
        self.buttonColor = buttonColor
        self.textColor = textColor
        self.strokeColor = strokeColor
        self.textFont = textFont
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.radius = radius
        self.lineWidth = lineWidth
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(textFont)
            .foregroundColor(textColor)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background(buttonColor)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(strokeColor, lineWidth: lineWidth)
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

#Preview {
    ZStack {
        Color.mongleGrayScale200
            .ignoresSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        VStack(spacing: 20) {
            Button {
                print("Button pressed")
            } label: {
                Text("Button")
            }
            .buttonStyle(MongleButtonStyle(buttonColor: Color.mongleColorPrimary300, textColor: Color.mongleGrayScale0, textFont: .mgTitle2, verticalPadding: 17, horizontalPadding: 0, radius: 8))
            
            Button {
                print("Button pressed")
            } label: {
                Text("Button")
            }
            .buttonStyle(IconHorizontalButtonStyle(buttonColor: Color.mongleColorPrimary300, textColor: Color.mongleGrayScale0, textFont: .mgTitle2, verticalPadding: 17, horizontalPadding: 10, radius: 8, iconImage: Image.searchIcon, spacing: 10, iconLeft: true))
            
            Button {
                print("Button pressed")
            } label: {
                Text("Button")
            }
            .buttonStyle(InfinityStrokeButtonStyle(buttonColor: Color.mongleColorPrimary300, textColor: Color.mongleGrayScale0, strokeColor: Color.green, textFont: .mgTitle2, verticalPadding: 17, radius: 8, lineWidth: 10))
        
            Button {
                print("Button pressed")
            } label: {
                Text("Button")
            }
            .buttonStyle(StrokeButtonStyle(buttonColor: Color.clear, textColor: Color.mongleGrayScale0, strokeColor: Color.mongleColorPrimary300, textFont: .mgTitle2, verticalPadding: 17, horizontalPadding: 0, radius: 8, lineWidth: 1))
        }
    }
}
