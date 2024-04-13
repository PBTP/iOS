//
//  HeaderComponent.swift
//  Ui
//
//  Created by bulmang on 4/13/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public struct HeaderComponent: View {
    public init() {}
    
    public var body: some View {
        Text("로그인")
            .font(.mgTitle2)
            .foregroundStyle(Color.mongleGrayScale1000)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .leading) {
                Image.xCloseIcon.swiftUIImage
            }
            .padding(.vertical, 19)
    }
}

#Preview {
    HeaderComponent()
}
