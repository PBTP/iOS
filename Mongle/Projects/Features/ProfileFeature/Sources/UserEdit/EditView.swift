//
//  ProfileEditView.swift
//  ProfileFeature
//
//  Created by bulmang on 7/11/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import ComposableArchitecture
import SwiftUI
import Ui

struct EditView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    
    @State private var isParkButtonActive = false
    @State private var tempName = ""
    @State private var tempLocation: String?
    
    @Binding var image: UIImage?
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderComponent(headerText: "보호자 정보", iconImageName: Image.arrowLeftIcon) {
                dismiss()
            }
            
            Spacer()
            
            ProfileImageButton(image: $image)
            
            Spacer()
            
            VStack(spacing: 32) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("닉네임 입력 *")
                        .font(.mgBody3)
                        .foregroundStyle(Color.mongleGrayScale700)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(alignment: .trailing) {
                            Text("\(tempName.count)/8자")
                                .font(.mgBody3)
                                .foregroundStyle(tempName.count > 8 ? Color.red :Color.mongleGrayScale500)
                        }
                    
                    MongleTextField(tempName: $tempName, placeHolder: "닉네임 입력")
                }
                
                InfoBox(
                    title: "연락처 *",
                    text: "010-0000-0000",
                    subtext: "010-0000-0000",
                    verificationText: "인증 완료"
                )
                
                AddressArea(isParkButtonActive: $isParkButtonActive)
            }
            
            Spacer()
            
            Button {
                if let token = kakaoAuth.customer.accessToken {
                    let customer = Customer(customerName: tempName)
                    NetworkManager().updateCustomer(customer: customer, token: token)
                }
                dismiss()
            } label: {
                Text("저장")
            }
            .buttonStyle(ConfirmButtonStyle(isDisabled: !isActive()))
            .disabled(!isActive())
            .padding(.bottom, 26)
        }
        .padding(.horizontal, 20)
    }
    
    private func isActive() -> Bool {
        return  tempName.count <= 8 &&
                tempName.count >= 1 &&
                kakaoAuth.tempLocation != nil &&
                isParkButtonActive
    }

}

#Preview {
    EditView(image: .constant(nil))
        .environmentObject(KaKaoAuthCore())
}

struct MongleTextField: View {
    @Binding var tempName: String
    var placeHolder: String

    var body: some View {
        TextField(placeHolder, text: $tempName)
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
}
