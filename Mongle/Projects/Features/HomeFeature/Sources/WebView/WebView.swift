//
//  WebView.swift
//  HomeFeature
//
//  Created by bulmang on 6/25/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import UI

public struct WebView: View {
    public init() {}
    
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    @State private var webUiView: WebUiView?

    public var body: some View {
        VStack {
            if let webUiView = webUiView {
                webUiView
                    .ignoresSafeArea()
            }

            Button("Send AccessToken to JavaScript") {
                print("자바 스크립트 데이터 보내기 클릭: \(String(describing: kakaoAuth.customer.accessToken))")
                if let accessToken = kakaoAuth.customer.accessToken {
                    webUiView?.sendJS(accessToken)
                }
            }
            .buttonStyle(ConfirmButtonStyle(isDisabled: false))
            
            Button("Send refresgToken to JavaScript") {
                print("자바 스크립트 데이터 보내기 클릭: \(String(describing: kakaoAuth.customer.refreshToken))")
                if let refreshToken = kakaoAuth.customer.refreshToken {
                    webUiView?.sendJS(refreshToken)
                }
            }
            .buttonStyle(ConfirmButtonStyle(isDisabled: false))
        }
        .onAppear {
            let request = URLRequest(url: URL(string: Web.url(for: "reservation"))!)
            self.webUiView = WebUiView(request: request, kakaoAuthCore: kakaoAuth)
        }
        .padding()
    }
}

#Preview {
    WebView()
        .environmentObject(KaKaoAuthCore())
}
