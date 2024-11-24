//
//  MainView.swift
//  App
//
//  Created by bulmang on 4/9/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import ChatFeature
import OnBoardingFeature
import HomeFeature
import SwiftUI

struct MainView: View {
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    @State var selectedTabItem = 0

    var body: some View {
        if kakaoAuth.customer.accessToken != nil {
            TabView(selection: $selectedTabItem) {
                HomeView()
                    .tabItem {
                        Image(selectedTabItem == 0 ? "HomeTabItemSelected" : "HomeTabItem")
                        Text("홈")
                    }
                    .tag(0)
                Text("예약내역")
                    .tabItem {
                        Image(selectedTabItem == 1 ? "ReservationTabItemSelected" : "ReservationTabItem")
                        Text("예약내역")
                    }
                    .tag(1)
                ChatView()
                    .tabItem {
                        Image(selectedTabItem == 2 ? "ChatTabItemSelected" : "ChatTabItem")
                        Text("채팅")
                    }
                    .tag(2)
                Text("마이")
                    .tabItem {
                        Image(selectedTabItem == 3 ? "MyTabItemSelected" : "MyTabItem")
                        Text("마이")
                    }
                    .tag(3)
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
