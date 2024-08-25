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
    
    var body: some View {
        if kakaoAuth.customer.accessToken != nil {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                ChatView()
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Chat")
                    }
            }
        } else {
            LoginView()
        }
    }
}

#Preview {
    MainView()
}
