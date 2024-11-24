//
//  NotificationList.swift
//  HomeFeature
//
//  Created by bulmang on 5/2/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI

struct NotificationList: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("오늘")
                    .font(.mgBody4)
                    .foregroundStyle(Color.mongleGrayScale500)
                
                ForEach(0..<5) { _ in
                    NotificationListItem()
                }
            }
        }
    }
}

struct NotificationListItem: View {
    var body: some View {

        HStack(alignment: .top, spacing: 15) {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("목욕 회사 이름")
                    .font(.mgTitle1)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(alignment: .trailing) {
                        Text("1시간 전")
                            .font(.mgCaption1)
                            .foregroundStyle(Color.mongleGrayScale500)
                    }
                
                Text("내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용")
                    .font(.mgBody4)
                    .foregroundStyle(Color.mongleGrayScale500)
                    .tracking(0)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 18)
        .background(Color.mongleGrayScale100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    NotificationList()
}
