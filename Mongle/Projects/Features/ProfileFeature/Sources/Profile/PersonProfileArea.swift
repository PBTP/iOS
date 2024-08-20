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
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    
    @State private var dogImageUrl: String?
    
    @Binding var image: UIImage?
    
    var body: some View {
        HStack(spacing: 16) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 68, height: 68)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                Image.profileDefaultImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 68, height: 68)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(kakaoAuth.customer.customerName ?? "이름 없음")
                    .font(.mgTitle1)
                    .foregroundColor(Color.black)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 0)
                
                HStack(spacing: 4) {
                    Image.markerPinFillIcon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    
                    Text(kakaoAuth.customer.location ?? "주소 정보가 없습니다.")
                        .font(.mgBody4)
                        .foregroundStyle(Color.mongleGrayScale800)
                }
                
                HStack(spacing: 4) {
                    Image.phoneFillIcon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    
                    Text("010-1234-1234")
                        .font(.mgBody4)
                        .foregroundStyle(Color.mongleGrayScale800)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
        .overlay(alignment: .topTrailing) {
            NavigationLink(
                destination: EditView(image: $image)
                    .navigationBarHidden(true)
            ) {
                HStack(spacing: 4) {
                    Image.pencilLineIcon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                    
                    Text("수정")
                        .font(.mgCaption1)
                        .foregroundStyle(Color.mongleGrayScale900)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .inset(by: 0.5)
                        .stroke(Color.mongleGrayScale300, lineWidth: 1)
                )
                .offset(y: 20)
            }
        }
    }
}

#Preview {
    PersonProfileArea(image: .constant(nil))
        .environmentObject(KaKaoAuthCore())
}
