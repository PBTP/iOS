//
//  PreviousReservationArea.swift
//  CalendarFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import Ui

struct PreviousReservationArea: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("지난 예약")
                .font(.mgTitle1)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                mongleButton("예약 10", buttonColor: Color.mongleGrayScale0, textColor: Color.mongleGrayScale800, textFont: .mgBody4, verticalPadding: 8, horizontalPadding: 16, radius: 30) {
                    
                }
                
                mongleButton("예약 취소 2", buttonColor: Color.mongleGrayScale0, textColor: Color.mongleGrayScale800, textFont: .mgBody4, verticalPadding: 8, horizontalPadding: 16, radius: 30) {
                    
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("최신순")
                        .font(.mgBody3)
                        .foregroundStyle(Color.mongleGrayScale500)
                }
            }
            
            ScrollView {
                ReservationListArea()
            }
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    PreviousReservationArea()
}
