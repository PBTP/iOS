//
//  LocationDateArea.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

struct LocationDateArea: View {
    var body: some View {
        HStack(spacing: 8) {
            Button {
                
            } label: {
                HStack(spacing: 8) {
                    Image.markerPinIcon
                    
                    Text("양천구 목동")
                        .font(.mgBody4)
                        .foregroundStyle(Color.black)
                }
            }
            
            Text("|")
                .font(.mgBody4)
                .foregroundStyle(Color.mongleGrayScale300)
            
            Button {
                
            } label: {
                HStack(spacing: 8) {
                    Image.calendarIcon
                    
                    Text("날짜 선택")
                        .font(.mgBody4)
                        .foregroundStyle(Color.mongleGrayScale400)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.mongleGrayScale100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.top, 18)
    }
}

#Preview {
    LocationDateArea()
}
