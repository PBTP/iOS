//
//  PersonProfileArea.swift
//  ProfileFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import Ui

struct PersonProfileArea: View {
    @State private var dogImageUrl: String?
    
    var body: some View {
        HStack(spacing: 16) {
            if let imageUrl = dogImageUrl {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 68, height: 68)
                .clipShape(Circle())
            } else {
                ProgressView()
                    .frame(width: 68, height: 68)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text("몽글몽글")
                        .font(.mgTitle1)
                        .foregroundColor(Color.black)
                    
                    Image.chevronRightIcon
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 0)

                Text("양천구 목동")
                    .font(.mgBody4)
                    .foregroundStyle(Color.mongleGrayScale800)
                
                Text("010-1234-1234")
                    .font(.mgBody4)
                    .foregroundStyle(Color.mongleGrayScale800)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
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
    PersonProfileArea()
}
