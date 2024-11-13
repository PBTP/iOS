//
//  MapWebView.swift
//  ProfileFeature
//
//  Created by bulmang on 7/14/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import UI
import WebKit

struct ChatWebView: View {
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    
    @State private var webUIView: ChatWebUIView?
    
    var body: some View {
        VStack {
            if let webUiView = webUIView {
                webUiView
                    .ignoresSafeArea()
            } else {
                // TODO: 오류 표시 페이지 추가
                ProgressView()
            }
        }
        .onAppear {
            let request = URLRequest(url: URL(string: Web.url(for: "chat-list"))!)
            self.webUIView = ChatWebUIView(request: request, kakaoAuthCore: kakaoAuth)
        }
    }
}

#Preview {
    ChatWebView()
        .environmentObject(KaKaoAuthCore())
}
