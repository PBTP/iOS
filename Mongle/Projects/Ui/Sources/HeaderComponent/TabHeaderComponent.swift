//
//  TabHeaderComponent.swift
//  Ui
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public struct TabHeaderComponent<FirstDestination: View, SecondDestination: View>: View {
    let headerText: String
    let firstIconImageName: Image?
    let firstDestination: FirstDestination
    let secondIconName: Image?
    let secondDestination: SecondDestination

    public init(
        headerText: String,
        firstIconImageName: Image? = nil,
        firstDestination: FirstDestination,
        secondIconName: Image? = nil,
        secondDestination: SecondDestination
    ) {
        self.headerText = headerText
        self.firstIconImageName = firstIconImageName
        self.firstDestination = firstDestination
        self.secondIconName = secondIconName
        self.secondDestination = secondDestination
    }

    public init(
        headerText: String,
        firstIconImageName: Image? = nil,
        firstDestination: FirstDestination
    ) where SecondDestination == EmptyView {
        self.headerText = headerText
        self.firstIconImageName = firstIconImageName
        self.firstDestination = firstDestination
        self.secondIconName = nil
        self.secondDestination = EmptyView()
    }

    public init(headerText: String) where FirstDestination == EmptyView, SecondDestination == EmptyView {
        self.headerText = headerText
        self.firstIconImageName = nil
        self.firstDestination = EmptyView()
        self.secondIconName = nil
        self.secondDestination = EmptyView()
    }

    public var body: some View {
        HStack(spacing: 19) {
            Text(headerText)
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
            if let firstIconImageName = firstIconImageName {
                NavigationLink(destination: firstDestination) {
                    firstIconImageName
                }
            }
            if let secondIconName = secondIconName {
                NavigationLink(destination: secondDestination) {
                    secondIconName
                }
            }
        } // HStack
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
    }
}

#Preview("아이콘 2개 다 있는 Header") {
    TabHeaderComponent(
        headerText: "홈",
        firstIconImageName: Image.searchGrayIcon,
        firstDestination: Text("첫 번째 화면"),
        secondIconName: Image.bellIcon,
        secondDestination: Text("두 번째 화면")
    )
}

#Preview("아이콘 1개만 있는 Header") {
    TabHeaderComponent(
        headerText: "홈",
        firstIconImageName: Image.searchGrayIcon,
        firstDestination: Text("첫번째 화면")
    )
}

#Preview("Text만 있는 Header") {
    TabHeaderComponent(headerText: "홈")
}
