//
//  ChatApp.swift
//  ChatFeature
//
//  Created by bulmang on 9/11/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import KakaoSDKCommon
import ChatFeature

@main
struct ChatApp: App {
    @StateObject var kakaoAuth = KaKaoAuthCore()
    
    init() {
        KakaoSDK.initSDK(appKey: APPKey.kakaoAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            ChatView()
                .environmentObject(kakaoAuth)
        }
    }
}
