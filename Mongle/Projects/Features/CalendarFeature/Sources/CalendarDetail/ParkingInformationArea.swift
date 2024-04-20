//
//  ParkingInformationArea.swift
//  CalendarFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

struct ParkingInformationArea: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("방문 주차 위치")
                .font(.mgTitle3)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing:8) {
                Image.markerPinIcon
                
                Text("서울시 중구 통일로5 어디 건물 앞 주차장")
                    .font(.mgBody3)
                    .foregroundStyle(Color.black)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.mongleGrayScale100)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text("주차 위치 변경이 필요한 경우 채팅으로 예약 일자 하루 전까지 안내해주세요.")
                .font(.mgCaption1)
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ParkingInformationArea()
}
