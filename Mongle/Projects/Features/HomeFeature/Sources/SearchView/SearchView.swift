//
//  SearchView.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import UI

public struct SearchView: View {
    public init() {}
    @State private var dogImageUrl: String?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SearchHeaderArea()
            RecentSearchCompanyList()
            RecentSearchTextList()
            Spacer()
        } // VStack
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 20)
        .onAppear {
            fetchDogImage { imageUrl in
                dogImageUrl = imageUrl
            }
        }
    }
}

#Preview {
    SearchView()
}
