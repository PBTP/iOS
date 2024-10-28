//
//  ChatView.swift
//  ChatFeature
//
//  Created by bulmang on 8/24/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import Core

public struct ChatView: View {
    public init() {}
    
    public var body: some View {
        ChatWebView()
    }
}

#Preview {
    ChatView()
        .environmentObject(KaKaoAuthCore())
}
