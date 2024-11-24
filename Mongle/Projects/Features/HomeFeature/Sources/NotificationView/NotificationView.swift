//
//  NotificationView.swift
//  HomeFeature
//
//  Created by bulmang on 5/2/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI

public struct NotificationView: View {
    public init() { }
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HeaderComponent(headerText: "알림", iconImageName: Image.arrowLeftIcon) {}
            NotificationList()
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    NotificationView()
}
