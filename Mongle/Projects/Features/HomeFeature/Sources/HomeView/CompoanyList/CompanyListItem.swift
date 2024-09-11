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
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 15) {
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
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text("목욕 회사 이름")
                    .font(.mgTitle1)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(alignment: .trailing) {
                        Button {
                            
                        } label: {
                            Image.heartEmptyIcon
                        }
                    }
                
                mongleButton("리스트 종류", buttonColor: Color.mongleGrayScale100, textColor: Color.mongleGrayScale800, textFont: .mgCaption1, verticalPadding: 2, horizontalPadding: 8, radius: 30) {
                    
                }
                .disabled(true)
                
                Text("180,000원부터")
                    .font(.mgTitle1)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 16)
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
    
    CompanyListItem()
        .border(Color.green)
    
}
