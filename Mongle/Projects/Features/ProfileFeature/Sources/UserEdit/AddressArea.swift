//
//  AddressArea.swift
//  ProfileFeature
//
//  Created by bulmang on 7/14/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import Ui

struct AddressArea: View {
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    
    @Binding var isParkButtonActive: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("방문 주소 *")
                .font(.mgBody3)
                .foregroundStyle(Color.mongleGrayScale700)
            
            NavigationLink {
                MapWebView()
                    .navigationBarHidden(true)
            } label: {
                HStack(spacing: 10) {
                    Image.searchGrayIcon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                    
                    Text(kakaoAuth.tempLocation ?? "주소 검색")
                        .font(kakaoAuth.tempLocation == nil ? .mgBody2 : .mgBody3)
                        .foregroundColor(kakaoAuth.tempLocation == nil ? Color.mongleGrayScale300 : Color.black)
                        .multilineTextAlignment(.leading)
                }
                .font(.mgBody1)
                .foregroundColor(Color.black)
                .padding(.leading, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(alignment: .trailing) {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.mongleGrayScale100, lineWidth: 1)
                }
            }
            
            Button {
                isParkButtonActive.toggle()
            } label: {
                HStack(spacing: 10) {
                    if isParkButtonActive {
                        Image.checkBoxFillIcon
                    } else {
                        Image.checkBoxEmptyIcon
                    }
                    
                    Text("주차 공간이 마련되어 있습니다.")
                        .font(.mgBody4SemiBold)
                        .foregroundColor(Color.black)
                }
            }
            
            Text("위 내용을 사실과 다르게 기재한 경우, 서비스 이용에 제한이 있을 수 있습니다.")
                .font(.mgCaption1)
                .foregroundColor(Color.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AddressArea(isParkButtonActive: .constant(false))
        .environmentObject(KaKaoAuthCore())
}
