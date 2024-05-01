//
//  CalendarDetailView.swift
//  CalendarFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import Ui

public struct CalendarDetailView: View {
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderComponent(headerText: "다가오는 예약", iconImageName: Image.arrowLeftIcon) { }
                .padding(.horizontal, 20)
            
            StoreImageArea()
            
            VStack(spacing: 32) {
                PetReservationArea()
                
                ParkingInformationArea()
                
                CustomerRequestArea()
                
                HStack(spacing: 8) {
                    infinityStrokeButton("취소", buttonColor: Color.clear, textColor: Color.mongleGrayScale800, strokeColor: Color.mongleGrayScale300, textFont: .mgTitle2, verticalPadding: 17, radius: 8, lineWidth: 1) {
                    }
                    
                    infinityStrokeButton("확인", buttonColor: Color.clear, textColor: Color.mongleGrayScale800, strokeColor: Color.mongleGrayScale300, textFont: .mgTitle2, verticalPadding: 17, radius: 8, lineWidth: 1) {
                    }
                }
            }
            .padding(.top, 26)
            .padding(.horizontal, 20)
            
            Spacer()
        }
    }
}

#Preview {
    CalendarDetailView()
}
