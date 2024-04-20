//
//  FavoriteStoreArea.swift
//  ProfileFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import Ui

struct FavoriteStoreArea: View {
    @State private var dogImageUrl: String?
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 6) {
                Text("찜한 업체")
                    .font(.mgTitle1)
                    .foregroundStyle(.black)
                
                Text("4")
                    .font(.mgTitle3)
                    .foregroundStyle(Color.mongleGrayScale500)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                VStack(spacing: 8) {
                    if let imageUrl = dogImageUrl {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                    
                    Text("개신남 3호점")
                        .font(.mgTitle3)
                        .foregroundStyle(.black)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            fetchDogImage { imageUrl in
                DispatchQueue.main.async {
                    self.dogImageUrl = imageUrl
                }
            }
        }
    }
}

#Preview {
    FavoriteStoreArea()
}
