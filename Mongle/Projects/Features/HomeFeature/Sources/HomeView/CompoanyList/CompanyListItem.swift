//
//  CompanyList.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import UI

struct CompanyListItem: View {
    @State var dogImageUrl: String?
    @State var isLikedCompany: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let imageUrl = dogImageUrl {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            } else {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text("#청결한 트럭")
                    Text("#좋은 제품 사용")
                    Spacer()
                    Button {
                        isLikedCompany.toggle()
                    } label: {
                        isLikedCompany ? Image.likedTrueIcon : Image.likedFalseIcon
                    }
                } // HStack
                .font(.mgCaption1)
                .foregroundStyle(Color.mongleGrayScale600)
                Text("몽글몽글 1호점")
                    .font(.mgTitle3)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("₩180,000~")
                    .font(.mgBody3)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 16)
            } // VStack
        } // HStack
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
    CompanyListItem(isLikedCompany: false)
        .border(Color.green)
    
}
