//
//  OnBoardingApp.swift
//  OnBoardingFeatureDemo
//
//  Created by bulmang on 4/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import ComposableArchitecture
import OnBoardingFeature
import SwiftUI
import KakaoSDKCommon

@main
struct OnBoardingApp: App {
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
