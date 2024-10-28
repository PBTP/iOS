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

class ContentController: NSObject, WKScriptMessageHandler, WKNavigationDelegate {
    private var isUserDataRequest = false
    private var kakaoAuthCore: KaKaoAuthCore

    init(kakaoAuthCore: KaKaoAuthCore) {
        self.kakaoAuthCore = kakaoAuthCore
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "showInfo", let messageBody = message.body as? String {
            print("Message from JavaScript: \(messageBody)")
            showAlert(messageBody)
        }
        
        if message.name == "webviewInit", let messageBody = message.body as? String {
            print("Message from JavaScript: \(messageBody)")
            isUserDataRequest = true
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if isUserDataRequest {
            guard let token = kakaoAuthCore.customer.accessToken,
                  let uuid = kakaoAuthCore.customer.uuid else {
                return
            }
            
            webView.evaluateJavaScript("handleIosWebviewToken(\"\(token)\",\"\(uuid)\")") { result, error in
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
            isUserDataRequest = false
        }
    }
    
    private func showAlert(_ message: String) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        
        let alertController = UIAlertController(title: "Message from WebView", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))

        rootViewController.present(alertController, animated: true, completion: nil)
    }
}

struct ChatWebUIView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView
    private var contentController: ContentController

    init(request: URLRequest, kakaoAuthCore: KaKaoAuthCore) {
        self.contentController = ContentController(kakaoAuthCore: kakaoAuthCore)
        self.request = request
        self.webView = ChatWebUIView.createWebView(contentController)
    }
    
    private static func createWebView(_ contentController: ContentController) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.userContentController.add(contentController, name: "webviewInit")
        config.userContentController.add(contentController, name: "showInfo")
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = contentController
        return webView
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
