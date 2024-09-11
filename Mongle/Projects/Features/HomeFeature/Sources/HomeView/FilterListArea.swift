//
//  FilterListArea.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI

struct FilterListArea: View {
    var body: some View {
        HStack(spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<5) { _ in
                        mongleButton("리스트 종류", buttonColor: Color.mongleGrayScale100, textColor: Color.mongleGrayScale800, textFont: .mgBody4, verticalPadding: 8, horizontalPadding: 16, radius: 30) {
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FilterListArea()
}
