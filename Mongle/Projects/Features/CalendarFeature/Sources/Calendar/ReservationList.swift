//
//  ReservationListArea.swift
//  CalendarFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI

enum ViewState {
    case possible
    case overDue
    case cancel
}

struct ReservationList: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 15) {
                AsyncImage(url: URL(string: "https://images.dog.ceo/breeds/sheepdog-english/n02105641_6534.jpg")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("03.19. 결제")
                        .font(.mgBody4)
                        .foregroundStyle(Color.mongleGrayScale400)
                    
                    Text("씻고올개")
                        .font(.mgBody4)
                        .foregroundStyle(Color.black)
                    
                    Text("180,000원")
                        .font(.mgTitle1)
                        .foregroundStyle(Color.black)
                    
                    Text("2024.04.06(토) 오후 1:00")
                        .font(.mgTitle3)
                        .foregroundStyle(Color.mongleGrayScale800)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            
            ConfirmButton("리뷰 작성", isDisabeld: true) {
                
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.mongleGrayScale0)
                .frame(maxWidth: .infinity)
                .frame(height: 193)
        }
    }
}

#Preview {
    ReservationList()
}
