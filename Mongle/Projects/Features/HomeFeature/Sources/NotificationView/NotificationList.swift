//
//  NotificationList.swift
//  HomeFeature
//
//  Created by bulmang on 5/2/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI

// MARK: DUMMY DATA
let notificationsData: [String: [Notification]] = [
    "2024-05-01": [
        Notification(title: "알림 제목 1", content: "알림 내용 1", timeAgo: "1시간 전"),
        Notification(title: "알림 제목 2", content: "알림 내용 2", timeAgo: "2시간 전")
    ],
    "2024-05-02": [
        Notification(title: "알림 제목 3", content: "알림 내용 3", timeAgo: "3시간 전")
    ]
]

struct NotificationList: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(notificationsData.keys.sorted(), id: \.self) { date in
                    NotificationListItem(notificationDate: date, notifications: notificationsData[date] ?? [])
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    NotificationList()
}
