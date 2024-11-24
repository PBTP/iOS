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
            ForEach(0..<6) { _ in
                NavigationLink(destination: CompanyDetailView()) {
                    CompanyListItem(isLikedCompany: false)
                }
            }
        }
        .padding(.top, 6)
    }
}

#Preview {
    CompanyList()
}
