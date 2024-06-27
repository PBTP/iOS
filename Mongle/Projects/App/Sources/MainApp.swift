//
//  MainApp.swift
//  App
//
//  Created by bulmang on 4/9/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import KakaoSDKCommon
import OnBoardingFeature

@main
struct Mongle: App {
    @StateObject var kakaoAuth = KaKaoAuthCore()
    
    init() {
        KakaoSDK.initSDK(appKey: APPKey.kakaoAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(kakaoAuth)
        }
    }
}
