//
//  ChatWebUIView.swift
//  ChatFeature
//
//  Created by bulmang on 11/13/24.
//  Copyright © 2024 Mongle. All rights reserved.
//

import Core
import SwiftUI
import WebKit

struct ChatWebUIView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView
    
    init(request: URLRequest, kakaoAuthCore: KaKaoAuthCore) {
        self.request = request
        self.webView = ChatWebUIView.createWebView(kakaoAuthCore: kakaoAuthCore)
        
        setupCookies(for: kakaoAuthCore)
    }
    
    /// 웹뷰 생성 함수
    private static func createWebView(kakaoAuthCore: KaKaoAuthCore) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }
    
    /// 쿠키 설정 함수(도메인 주소, 경로, 이름, AccessToken, 보안 설정)
    private func setupCookies(for kakaoAuthCore: KaKaoAuthCore) {
        guard let accessToken = kakaoAuthCore.customer.accessToken, let uuid = kakaoAuthCore.customer.uuid else {
            return
        }
        
        guard let cookie = HTTPCookie(properties: [
            .domain: "web-view.mgmg.life",
            .path: "/",
            .name: "AUTH",
            .value: "\(accessToken),\(uuid)",
            .secure: "TRUE"
        ]) else {
            print("쿠키 생성 실패")
            return
        }
        
        let dataStore = webView.configuration.websiteDataStore
        dataStore.httpCookieStore.setCookie(cookie) {
#if DEBUG
            print("쿠키 이름: \(cookie.name)")
            print("쿠키 값: \(cookie.value)")
            print("쿠키 도메인: \(cookie.domain)")
            print("쿠키 경로: \(cookie.path)")
#endif
        }
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
