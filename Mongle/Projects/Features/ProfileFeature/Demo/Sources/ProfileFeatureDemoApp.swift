//
//  ProfileFeatureDemoApp.swift
//  ProfileFeatureDemo
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import ProfileFeature

@main
struct ProfileFeatureDemoApp: App {
    @StateObject var kakaoAuth = KaKaoAuthCore()
    
    var body: some Scene {
        WindowGroup {
            ProfileView()
                .environmentObject(kakaoAuth)
        }
    }
}

