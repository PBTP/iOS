//
//  AdBannerArea.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

struct AdBannerArea: View {
    var body: some View {
        Text("광고 배너")
            .font(.mgTitle2)
            .padding(.vertical, 50)
            .frame(maxWidth: .infinity)
            .background(Color.mongleGrayScale100)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(alignment: .bottom) {
                HStack {
                    ForEach(0..<3) { _ in
                        Circle().frame(width: 6, height: 6)
                            .offset(y: 14)
                    }
                }
            }
    }
}

#Preview {
    AdBannerArea()
}
