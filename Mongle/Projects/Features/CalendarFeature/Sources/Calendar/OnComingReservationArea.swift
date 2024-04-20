//
//  OnComingReservationArea.swift
//  CalendarFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import Ui

struct OnComingReservationArea: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("다가오는 예약")
                .font(.mgTitle1)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 24) {
                Text("다가오는 예약이 없습니다.\n몽글을 통해 편리하게 예약해보세요!")
                    .font(.mgBody4)
                    .foregroundStyle(Color.mongleGrayScale400)
                    .multilineTextAlignment(.center)
                
                iconHorizontalButton("목욕 업체 둘러보기", buttonColor: Color.mongleGrayScale500, textColor: Color.mongleGrayScale0, textFont: .mgBody4, verticalPadding: 11, horizontalPadding: 12, radius: 8, iconImage: Image.searchIcon, spacing: 8, iconLeft: true) {
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
        }
    }
}

#Preview {
    OnComingReservationArea()
}
