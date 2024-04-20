//
//  CustomerRequestArea.swift
//  CalendarFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

struct CustomerRequestArea: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("요청 사항")
                .font(.mgTitle3)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("요청사항")
                .font(.mgBody3)
                .foregroundStyle(Color.black)
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.mongleGrayScale100)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    CustomerRequestArea()
}
