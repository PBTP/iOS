//
//  TermsRow.swift
//  OnBoardingFeature
//
//  Created by Bokyung on 1/25/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import SwiftUI

struct TermsRow: View {
    @Binding var isAgreed: Bool
    @State private var isShowingTermDescription: Bool = false
    let text: String
    let termDescription: String
    let onToggle: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Button(action: {
                    isAgreed.toggle()
                    onToggle()
                }) {
                    if isAgreed {
                        Image.checkBoxFillIcon
                    } else {
                        Image.checkBoxEmptyIcon
                    }
                }
                Text(text)
                    .font(.mgBody4)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Button(action: {
                    isShowingTermDescription.toggle()
                }) {
                    Image.chevronDownIcon
                        .rotationEffect(.degrees(isShowingTermDescription ? -180 : 0))
                }
            }
            .padding(.vertical, 8)

            if isShowingTermDescription {
                Text(termDescription)
                    .font(.mgCaption1)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 30)
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    TermsRow(
        isAgreed: .constant(true),
        text: "만 14세 이상 이용, 서비스 이용약관, 개인정보 수집 및 이용 동의 (필수)",
        termDescription: "해당 약관에 동의하시면 서비스 이용이 가능합니다.",
        onToggle: {
            print("약관 동의 상태가 변경되었습니다.")
        }
    )
    .padding(16)
}
