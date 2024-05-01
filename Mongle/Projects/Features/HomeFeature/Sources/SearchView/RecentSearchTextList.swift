//
//  RecentSearchList.swift
//  HomeFeature
//
//  Created by bulmang on 5/2/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import Ui

struct RecentSearchTextList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("최근 검색")
                    .font(.mgTitle2)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("전체 삭제")
                        .font(.mgCaption1)
                        .foregroundStyle(Color.mongleGrayScale600)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<5) { _ in
                        iconHorizontalButton("개신남", buttonColor: Color.mongleGrayScale100, textColor: Color.mongleGrayScale600, textFont: .mgBody3, verticalPadding: 8, horizontalPadding: 12, radius: 8, iconImage: Image.xCircleIcon, spacing: 4, iconLeft: false) {
                        }
                    }
                }
            }
        }
        .padding(.top, 16)
    }
}

#Preview {
    RecentSearchTextList()
}
