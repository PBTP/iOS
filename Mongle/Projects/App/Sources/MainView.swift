//
//  MainView.swift
//  App
//
//  Created by bulmang on 4/9/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import OnBoardingFeature
import HomeFeature
import ProfileFeature

struct MainView: View {
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    
    var body: some View {
        if kakaoAuth.hasToken {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
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
