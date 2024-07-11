//
//  PetList.swift
//  ProfileFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import Ui

struct PetList: View {
    @State private var dogImageUrl: String?
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
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
            
            VStack(spacing: 8) {
                HStack(spacing: 6) {
                    Text("김뽀삐")
                        .font(.mgTitle1)
                        .foregroundStyle(Color.black)
                    
                    Text("♀")
                        .font(.mgTitle3)
                        .foregroundStyle(Color.mongleGrayScale400)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image.pencilIcon
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 3) {
                    Text("시그로자브종")
                        .font(.mgBody4)
                        .foregroundStyle(Color.mongleGrayScale800)
                    
                    Text("|")
                        .font(.mgBody4)
                        .foregroundStyle(Color.mongleGrayScale300)
                    
                    Text("3년 4개월")
                        .font(.mgBody4)
                        .foregroundStyle(Color.mongleGrayScale800)
                    
                    Text("|")
                        .font(.mgBody4)
                        .foregroundStyle(Color.mongleGrayScale300)
                    
                    Text("3kg")
                        .font(.mgBody4)
                        .foregroundStyle(Color.mongleGrayScale800)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.mongleGrayScale100)
                .frame(maxWidth: .infinity)
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
    PetList()
}
