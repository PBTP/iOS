//
//  HomeView.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI

public struct HomeView: View {
    public init() {}

    public var body: some View {
        VStack(spacing: 0) {
            TabHeaderComponent(
                headerText: "홈",
                firstIconImageName: Image.searchGrayIcon,
                firstDestination: SearchView(),
                secondIconName: Image.bellIcon,
                secondDestination: NotificationView()
            )
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 18) {
                    Group {
                        AdBannerArea()
                        LocationDateArea()
                        FilterListArea()
                        CompanyList()
                    }
                    .padding(.horizontal, 20)
                    MongleInfoArea()
                }
            } // ScrollView
        } // VStack
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
