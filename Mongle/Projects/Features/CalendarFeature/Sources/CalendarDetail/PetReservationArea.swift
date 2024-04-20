//
//  PetReservationArea.swift
//  CalendarFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import Ui

struct PetReservationArea: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                iconHorizontalButton("개신남 3호점", buttonColor: Color.clear, textColor: Color.black, textFont: .mgHeading1, verticalPadding: 4, horizontalPadding: 0, radius: 0, iconImage: Image.chevronRightIcon, spacing: 8, iconLeft: false) {
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("김뽀삐 | 중형견 | 장모종")
                .font(.mgBody2)
                .foregroundStyle(Color.mongleGrayScale400)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("2024.04.06(토) 오후 1:00")
                .font(.mgTitle2)
                .foregroundStyle(Color.mongleColorPrimary300)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 14)
        }
    }
}

#Preview {
    PetReservationArea()
}
