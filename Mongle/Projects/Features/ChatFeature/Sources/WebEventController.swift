//
//  WebEventController.swift
//  ChatFeature
//
//  Created by bulmang on 11/13/24.
//  Copyright © 2024 Mongle. All rights reserved.
//

import Core
import WebKit

/// 웹뷰 이벤트 컨트롤러(웹뷰와의 통신을 위한 클래스)
class WebEventController: NSObject, WKScriptMessageHandler, WKNavigationDelegate {
    private var kakaoAuthCore: KaKaoAuthCore

    init(kakaoAuthCore: KaKaoAuthCore) {
        self.kakaoAuthCore = kakaoAuthCore
    }
    
    /// 웹뷰에서 메시지 호출시 실행되는 함수
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    if message.name == "showInfo", let messageBody = message.body as? String {
        print("Message from JavaScript: \(messageBody)")
        showAlert(messageBody)
    }
    
    if message.name == "webviewInit" {
        guard let token = kakaoAuthCore.customer.accessToken,
                let uuid = kakaoAuthCore.customer.uuid else {
            return
        }
        
        let webViewFunctionName = "handleIosWebviewToken(\"\(token)\",\"\(uuid)\")"
        
        if let webView = message.webView {
            webView.evaluateJavaScript(webViewFunctionName) { result, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let result = result {
                    print("Received Data: \(result)")
                } else {
                    print("No data received or it's a void function")
                }
            }
        }
    }
}
    
    // TODO: Front용 테스트 알림창(배포때 제거)
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
