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
        ZStack {
            Color.mongleGrayScale100
                .ignoresSafeArea()
            VStack(spacing: 16) {
                TabHeaderComponent(headerText: "예약")
                
                OnComingReservationArea()
                
                PreviousReservationArea()
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    CalendarView()
}
