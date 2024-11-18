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
    private var webEventController: WebEventController
    
    init(request: URLRequest, kakaoAuthCore: KaKaoAuthCore) {
        self.webEventController = WebEventController(kakaoAuthCore: kakaoAuthCore)
        self.request = request
        self.webView = ChatWebUIView.createWebView(webEventController, kakaoAuthCore: kakaoAuthCore)
        
        setupCookies(for: kakaoAuthCore)
    }
    
    /// 웹뷰 생성 함수
    private static func createWebView(_ webEventController: WebEventController, kakaoAuthCore: KaKaoAuthCore) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.userContentController.add(webEventController, name: "webviewInit")
        config.userContentController.add(webEventController, name: "showInfo")
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = webEventController
        return webView
    }
    
    /// 쿠키 설정 함수(도메인 주소, 경로, 이름, AccessToken, 보안 설정)
    private func setupCookies(for kakaoAuthCore: KaKaoAuthCore) {
        guard let cookie = HTTPCookie(properties: [
            .domain: "web-view.mgmg.life",
            .path: "/",
            .name: "AUTH",
            .value: kakaoAuthCore.customer.accessToken ?? "no access token(iOS Problem)",
            .secure: "TRUE"
        ]) else {
            print("쿠키 생성 실패")
            return
        }
        
        let dataStore = webView.configuration.websiteDataStore
        dataStore.httpCookieStore.setCookie(cookie) {
#if DEBUG
            self.checkCookieValue()
#endif
        }
    }
    
    /// 쿠키 값 확인 함수(디버깅용)
    private func checkCookieValue() {
        let dataStore = webView.configuration.websiteDataStore
        dataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                print("쿠키 이름: \(cookie.name)")
                print("쿠키 값: \(cookie.value)")
                print("쿠키 도메인: \(cookie.domain)")
                print("쿠키 경로: \(cookie.path)")
            }
        }
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    		
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
