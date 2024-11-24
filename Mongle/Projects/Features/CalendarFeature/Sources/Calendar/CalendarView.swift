//
//  CalendarView.swift
//  CalendarFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI

public struct CalendarView: View {
    public init() {}
    
    public var body: some View {
            VStack(spacing: 0) {
                TabHeaderComponent(
                    headerText: "예약",
                    firstIconImageName: Image.searchGrayIcon,
                    firstDestination: Text("찾기"),
                    secondIconName: Image.bellIcon,
                    secondDestination: Text("알림")
                )
                OnComingReservationArea()
                PreviousReservationArea()
                Spacer()
            } // VStack
            .padding(.horizontal, 20)

    }
}

#Preview {
    CalendarView()
}
