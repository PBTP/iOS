//
//  HeaderComponent.swift
//  Ui
//
//  Created by bulmang on 4/13/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public struct HeaderComponent: View {
    let headerText: String
    let iconImageName: Image
    let action: () -> Void
    
    public init(headerText: String, iconImageName: Image, action: @escaping() -> Void)  {
        self.headerText = headerText
        self.iconImageName = iconImageName
        self.action = action
    }
    
    public var body: some View {
        Text(headerText)
            .font(.mgTitle2)
            .foregroundStyle(Color.mongleGrayScale1000)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .leading) {
                Button {
                    action()
                } label: {
                    iconImageName
                }
                .padding(.leading, 2)
            }
            .padding(.vertical, 20)
    }
}

#Preview {
    HeaderComponent(headerText: "로그인", iconImageName: Image.xCloseIcon) { }
}
