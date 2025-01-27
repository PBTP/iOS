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
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    @StateObject var navigationVM = NavigationViewModel()
    @State var selectedTabItem = 0

    var body: some View {
        if !UserSettings.accessToken.isEmpty && UserSettings.isLoggedIn {
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
                }
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
                }
                .environmentObject(navigationVM)
                .onOpenURL { url in
                    navigationVM.handleDeeplink(url: url)
                }
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
