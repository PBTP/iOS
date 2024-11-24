//
//  NotificationListItem.swift
//  HomeFeature
//
//  Created by Bokyung on 11/24/24.
//  Copyright © 2024 Mongle. All rights reserved.
//

import SwiftUI

struct Notification: Hashable {
    var title: String
    var content: String
    var timeAgo: String
}

struct NotificationListItem: View {
    var notificationDate: String
    var notifications: [Notification]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(notificationDate)
                .font(.mgBody4)
                .foregroundStyle(Color.mongleGrayScale500)
            ForEach(notifications, id: \.self) { notification in
                HStack {
                    Text(notification.title)
                        .font(.mgTitle1)
                        .foregroundStyle(Color.black)
                    Spacer()
                    Text(notification.timeAgo)
                        .font(.mgCaption1)
                        .foregroundStyle(Color.mongleGrayScale500)
                } // HStack
                Text(notification.content)
                    .font(.mgBody4)
                    .foregroundStyle(Color.mongleGrayScale500)
                    .lineLimit(2)
                    .truncationMode(.tail)
            } // ForEach
        } // VStack
    }
}

#Preview {
    VStack {
        ForEach(notificationsData.keys.sorted(), id: \.self) { date in
            NotificationListItem(notificationDate: date, notifications: notificationsData[date] ?? [])
        }
    }
}
