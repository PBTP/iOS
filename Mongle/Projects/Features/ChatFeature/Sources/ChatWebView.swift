//
//  MapWebView.swift
//  ProfileFeature
//
//  Created by bulmang on 7/14/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import Ui
import WebKit

struct ChatWebView: View {
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    
    @State private var webUiView: ChatWebUiView?
    
    var body: some View {
        VStack {
            if let webUiView = webUiView {
                webUiView
                    .ignoresSafeArea()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            let request = URLRequest(url: URL(string: Web.url(for: "chat-list"))!)
            self.webUiView = ChatWebUiView(request: request, kakaoAuthCore: kakaoAuth)
        }
    }
}

class ContentController: NSObject, WKScriptMessageHandler, WKNavigationDelegate {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) { }
    
    var kakaoAuthCore: KaKaoAuthCore

    init(kakaoAuthCore: KaKaoAuthCore) {
        self.kakaoAuthCore = kakaoAuthCore
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let token = kakaoAuthCore.customer.accessToken, let uuid = kakaoAuthCore.customer.uuid else {
            return
        }

        webView.evaluateJavaScript("handleIosWebviewToken('\(token), \(uuid)')") { result, error in
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
}

struct ChatWebUiView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView
    private var contentController: ContentController

    init(request: URLRequest, kakaoAuthCore: KaKaoAuthCore) {
        let contentController = ContentController(kakaoAuthCore: kakaoAuthCore)
        let config = WKWebViewConfiguration()
        config.userContentController.add(contentController, name: "handleIosWebviewToken")

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
}

#Preview {
    ChatWebView()
        .environmentObject(KaKaoAuthCore())
}
