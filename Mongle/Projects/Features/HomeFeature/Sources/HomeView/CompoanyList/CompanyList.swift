//
//  CompanyList.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

struct CompanyList: View {
    var body: some View {
        VStack(spacing: 24) {
            ForEach(0..<5) { _ in
                Button {
                    
                } label: {
                    CompanyListItem()
                }
            }
        }
        .padding(.top, 6)
    }
}

#Preview {
    CompanyList()
}
