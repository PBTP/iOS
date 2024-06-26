// WebView.swift
// HomeFeature
//
// Created by bulmang on 6/25/24.
// Copyright © 2024 Mongle-iOS. All rights reserved.

import Core
import SwiftUI
import Ui
import WebKit

class ContentController: NSObject, WKScriptMessageHandler, WKNavigationDelegate {
    var kakaoAuthCore: KaKaoAuthCore

    init(kakaoAuthCore: KaKaoAuthCore) {
        self.kakaoAuthCore = kakaoAuthCore
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let accessToken = kakaoAuthCore.customer.accessToken ?? "Access token 없음"

        webView.evaluateJavaScript("iOSToJavaScript('\(accessToken)')") { result, error in
            if let error = error {
                print("Error \(error.localizedDescription)")
                return
            }

            if let result = result {
                print("Received Data \(result)")
            } else {
                print("No data received or it's void function")
            }
        }
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "buttonClicked", let messageBody = message.body as? String {
            print("Message from JavaScript: \(messageBody)")
        }
    }
}

struct WebUiView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView
    private var contentController: ContentController

    init(request: URLRequest, kakaoAuthCore: KaKaoAuthCore) {
        let contentController = ContentController(kakaoAuthCore: kakaoAuthCore)
        let config = WKWebViewConfiguration()
        config.userContentController.add(contentController, name: "buttonClicked")

        self.webView = WKWebView(frame: .zero, configuration: config)
        self.request = request
        self.contentController = contentController
        self.webView.navigationDelegate = contentController
    }

    func makeUIView(context: Context) -> WKWebView {
        webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func sendJS(_ args: String) {
        webView.evaluateJavaScript("iOSToJavaScript('\(args)')") { result, error in
            if let error = error {
                print("Error \(error.localizedDescription)")
                return
            }
            
            if result == nil {
                print("It's void function")
                return
            }
            
            print("Received Data \(result ?? "")")
        }
    }
}


