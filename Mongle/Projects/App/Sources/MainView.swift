//
//  MainView.swift
//  App
//
//  Created by bulmang on 4/9/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import CalendarFeature
import ChatFeature
import Core
import HomeFeature
import OnBoardingFeature
import ProfileFeature
import SwiftUI

struct MainView: View {
    @StateObject var navigationVM = NavigationViewModel(path: [])
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    @State var selectedTabItem = 0

    var body: some View {
        if kakaoAuth.customer.accessToken != nil {
            NavigationStack(path: $navigationVM.path) {
                TabView(selection: $selectedTabItem) {
                    ForEach(TabItem.allCases, id: \.self) { tab in
                        tab.view
                            .tabItem {
                                Image(selectedTabItem == tab.rawValue ? tab.selectedImage : tab.defaultImage)
                                Text(tab.title)
                            }
                            .tag(tab.rawValue)
                    }
                } // TabView
                .navigationDestination(for: Screen.self) { route in
                    switch route {
                    case .home:
                        HomeView()
                    case .searchCompany:
                        SearchView()
                    case .storeDetail:
                        Text("test")
                    case .notification:
                        NotificationView()
                    }
                } // navigationDestination
                .environmentObject(navigationVM)
                .onOpenURL { url in
                    navigationVM.handleDeeplink(url: url)
                } // openURL
            }
        } else {
            LoginView()
        }
    }
}

#Preview {
    MainView()
        .environmentObject(KaKaoAuthCore())
}
