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
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderComponent(
                headerText: "알림",
                iconImageName: Image.arrowLeftIcon
            ) {
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.horizontal, 20)
            NotificationList()
                .padding(.vertical, 8)
            Spacer()
        } // VStack
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NotificationView()
}
