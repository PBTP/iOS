//
//  PetEditView.swift
//  ProfileFeature
//
//  Created by bulmang on 7/14/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import Ui

struct PetEditView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var isParkButtonActive = false
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderComponent(headerText: "반려동물", iconImageName: Image.arrowLeftIcon) {
                dismiss()
            }
            
            Spacer()
            
            ProfileImageButton()
            
            Spacer()
            
            VStack(spacing: 32) {
                InfoBox(
                    title: "이름",
                    text: "사용자", 
                    subtext: nil,
                    verificationText: nil
                )
                
                InfoBox(
                    title: "연락처",
                    text: "SKT",
                    subtext: "010-0000-0000",
                    verificationText: "인증 완료"
                )
                
                AddressArea(isParkButtonActive: $isParkButtonActive)
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("저장")
            }
            .buttonStyle(ConfirmButtonStyle(isDisabled: !isParkButtonActive))
            .padding(.bottom, 26)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    EditView()
}

#Preview {
    PetEditView()
}
