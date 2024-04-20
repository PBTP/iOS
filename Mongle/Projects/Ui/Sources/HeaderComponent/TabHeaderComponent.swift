//
//  TabHeaderComponent.swift
//  Ui
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public struct TabHeaderComponent: View {
    let headerText: String
    let iconImageName: Image?
    let action: (() -> Void)?
    
    public init(headerText: String, iconImageName: Image? = nil, action: (() -> Void)? = nil)  {
        self.headerText = headerText
        self.iconImageName = iconImageName
        self.action = action
    }
    
    public var body: some View {
        Text(headerText)
            .font(.mgHeading1)
            .foregroundStyle(.black)
            .padding(.vertical, 15.5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .trailing) {
                if let action = action {
                    Button(action: action) {
                        if let iconImageName = iconImageName {
                            iconImageName
                        }
                    }
                }
            }
    }
}


#Preview {
    TabHeaderComponent(headerText: "마이", iconImageName: Image.xCloseIcon) { }
}
