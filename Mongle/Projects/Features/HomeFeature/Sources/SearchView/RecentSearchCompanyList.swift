//
//  RecentSearchCompanyList.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI

struct RecentSearchCompanyList: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("최근 본 업체")
                .font(.mgTitle1)
                .foregroundStyle(Color.black)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<5) { _ in
                        RecentSearchCompanyListItem()
                    }
                }
            }
        }
    }
}

struct RecentSearchCompanyListItem: View {
    @State private var dogImageUrl: String?
    
    var body: some View {
        if let imageUrl = dogImageUrl {
            VStack(alignment: .leading, spacing: 8) {
                Button {
                    
                } label: {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Text("개신남 10호점")
                    .font(.mgCaption1)
                    .foregroundStyle(Color.mongleGrayScale900)
                    .tracking(-1.0)
            }
        } else {
            ProgressView()
                .frame(width: 64, height: 64)
                .onAppear {
                    fetchDogImage { imageUrl in
                        dogImageUrl = imageUrl
                    }
                }
        }
    }
}

#Preview {
    RecentSearchCompanyList()
}
