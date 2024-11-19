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
    let firstIconImageName: Image?
    let firstAction: (() -> Void)?
    let secondIconName: Image?
    let secondAction: (() -> Void)?

    public init(headerText: String, firstIconImageName: Image? = nil, firstAction: (() -> Void)? = nil, secondIconName: Image? = nil, secondAction: (() -> Void)? = nil) {
        self.headerText = headerText
        self.firstIconImageName = firstIconImageName
        self.firstAction = firstAction
        self.secondIconName = secondIconName
        self.secondAction = secondAction
    }

    public var body: some View {
        HStack(spacing: 19) {
            Text(headerText)
                .font(.mgHeading1)
                .foregroundStyle(.black)
            Spacer()
            if let firstIconImageName = firstIconImageName {
                Button(action: firstAction ?? {}) {
                    firstIconImageName
                }
            }
            if let secondIconName = secondIconName {
                Button(action: secondAction ?? {}) {
                    secondIconName
                }
            }
        } // HStack
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
    }
}

#Preview {
    TabHeaderComponent(
        headerText: "마이",
        firstIconImageName: Image.xCloseIcon,
        firstAction: { }
    )
}
