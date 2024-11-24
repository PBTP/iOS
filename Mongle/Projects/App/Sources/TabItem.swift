//
//  TabItem.swift
//  Core
//
//  Created by Bokyung on 11/24/24.
//  Copyright © 2024 Mongle. All rights reserved.
//

import CalendarFeature
import ChatFeature
import HomeFeature
import ProfileFeature
import SwiftUI

enum TabItem: Int, CaseIterable {
    case home
    case calendar
    case chat
    case profile

    var view: some View {
        switch self {
        case .home:
            return AnyView(HomeView())
        case .calendar:
            return AnyView(CalendarView())
        case .chat:
            return AnyView(ChatView())
        case .profile:
            return AnyView(ProfileView())
        }
    }

    var title: String {
        switch self {
        case .home: return "홈"
        case .calendar: return "예약내역"
        case .chat: return "채팅"
        case .profile: return "마이"
        }
    }

    var defaultImage: String {
        switch self {
        case .home: return "HomeTabItem"
        case .calendar: return "ReservationTabItem"
        case .chat: return "ChatTabItem"
        case .profile: return "MyTabItem"
        }
    }

    var selectedImage: String {
        switch self {
        case .home: return "HomeTabItemSelected"
        case .calendar: return "ReservationTabItemSelected"
        case .chat: return "ChatTabItemSelected"
        case .profile: return "MyTabItemSelected"
        }
    }
}
