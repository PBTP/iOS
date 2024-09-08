//
//  MongleInfoArea.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI

struct MongleInfoArea: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 12) {
                Text("몽글몽글")
                    .font(.mgBody3)
                
                HStack(spacing: 8) {
                    strokeButton("업체 입점 문의", buttonColor: Color.white, textColor: Color.mongleGrayScale800, strokeColor: Color.mongleGrayScale300, textFont: .mgBody4, verticalPadding: 6, horizontalPadding: 8, radius: 4, lineWidth: 1) {
                        
                    }
                    
                    strokeButton("마케팅/광고 제휴", buttonColor: Color.white, textColor: Color.mongleGrayScale800, strokeColor: Color.mongleGrayScale300, textFont: .mgBody4, verticalPadding: 6, horizontalPadding: 8, radius: 4, lineWidth: 1) {
                        
                    }
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text("대표이사: 홍길동")
                    
                    Text("사업자등록번호: 123-45-67890")
                }
                
                Text("주소: 123-45-67890")
                
                Text("help@mongle.com")
                
                Text("몽글몽글은 통신판매중개자로서 통신판매의 당사자가 아니며\n상품 거래정보 및 거래 등에 대해 책임을 지지 않습니다.")
                
                HStack(spacing: 16) {
                    Text("이용약관")
                    
                    Text("전자금융거래 이용약관")
                    
                    Text("개인정보 처리방침")
                }
                .font(.mgCaption1)
                .foregroundStyle(Color.black)
                .padding(.top, 16)
            }
        }
        .font(.mgCaption1)
        .foregroundStyle(Color.mongleGrayScale800)
        .padding(.vertical, 24)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.mongleGrayScale100)
        
    }
}

#Preview {
    MongleInfoArea()
}
