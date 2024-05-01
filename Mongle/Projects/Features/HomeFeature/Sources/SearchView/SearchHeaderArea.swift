//
//  SearchHeaderComponent.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import Ui

struct SearchHeaderArea: View {
    var body: some View {
        HStack(spacing: 16) {
            Button {
                
            } label: {
                Image.arrowLeftIcon
            }
            
            MongleNumberTextField(placeHolder: "업체명을 입력하세요", leadingPadding: 20, verticalPadding: 15)
                .padding(.vertical, 16)
        }
    }
}

#Preview {
    SearchHeaderArea()
}
