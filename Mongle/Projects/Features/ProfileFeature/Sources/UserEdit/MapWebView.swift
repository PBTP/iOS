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

struct MapWebView: View {
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    
    @State private var webUiView: MapWebUiView?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            if let webUiView = webUiView {
                HeaderComponent(headerText: "위치 선택", iconImageName: Image.arrowLeftIcon) {
                    dismiss()
                }
                .padding(.horizontal, 20)
                
                webUiView
                    .ignoresSafeArea()
            }
        }
        .onChange(of: kakaoAuth.tempLocation) { _ in
            dismiss()
        }
        .onAppear {
            let request = URLRequest(url: URL(string: Web.url(for: "location"))!)
            self.webUiView = MapWebUiView(request: request, kakaoAuthCore: kakaoAuth)
        }
    }
}

class ContentController: NSObject, WKScriptMessageHandler, WKNavigationDelegate {
    var kakaoAuthCore: KaKaoAuthCore

    init(kakaoAuthCore: KaKaoAuthCore) {
        self.kakaoAuthCore = kakaoAuthCore
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let token = kakaoAuthCore.customer.accessToken else {
            return
        }
        
        webView.evaluateJavaScript("iOSToJavaScript('\(token)')") { result, error in
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
        if message.name == "getAddressWebview", let messageBody = message.body as? String {
            print("location: \(String(describing: kakaoAuthCore.customer.location))")
            
            kakaoAuthCore.tempLocation = JsonDecoder().formatAddress(from: messageBody)
            print("location: \(String(describing: kakaoAuthCore.tempLocation))")
        }
    }
}

struct MapWebUiView: UIViewRepresentable {
    let request: URLRequest
    private var webView: WKWebView
    private var contentController: ContentController

    init(request: URLRequest, kakaoAuthCore: KaKaoAuthCore) {
        let contentController = ContentController(kakaoAuthCore: kakaoAuthCore)
        let config = WKWebViewConfiguration()
        config.userContentController.add(contentController, name: "getAddressWebview")

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
    MapWebView()
        .environmentObject(KaKaoAuthCore())
}