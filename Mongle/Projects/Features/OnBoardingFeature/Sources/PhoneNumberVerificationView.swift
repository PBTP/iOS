//
//  PhoneNumberVerificationView.swift
//  OnBoardingFeature
//
//  Created by bulmang on 4/15/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import Ui

public struct PhoneNumberVerificationView: View {
    // TEST CODE
    @State private var isButtonClicked = false
    
    let store: Store<phoneNumberStore.State, phoneNumberStore.Action>
    
    public init(store: Store<phoneNumberStore.State, phoneNumberStore.Action>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            
            HeaderComponent(headerText: "휴대폰 번호 인증", iconImageName: Image.arrowLeftIcon) {}
            
            if isButtonClicked {
                Text("인증번호")
                    .font(.mgBody3)
                    .foregroundStyle(Color.mongleGrayScale700)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 50)
                
                MongleNumberTextField(placeHolder: "인증번호", timerActive: isButtonClicked, requestButtonActive: false)
            }
            
            
            Text("연락처")
                .font(.mgBody3)
                .foregroundStyle(Color.mongleGrayScale700)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
            
            
            TelecomSelectButton(store: store) {}
            
            MongleNumberTextField(placeHolder: "010-0000-0000", timerActive: false, requestButtonActive: isButtonClicked)
        
            ConfirmButton("인증번호 전송", isDisabeld: false) {
                withAnimation {
                    isButtonClicked.toggle()
                }
            }
            .padding(.top, 16)
            
            VStack(alignment: .leading, spacing:0) {
                Text("인증번호 발송에는 시간이 소요됩니다.")
                Text("인증번호는 문자메시지로 발송되며, 수신하지 못했다면 차단된 메시지를 확인")
                Text("해주세요.")
            }
            .font(.mgCaption1)
            .foregroundStyle(Color.mongleGrayScale500)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    PhoneNumberVerificationView(
        store: Store(initialState: phoneNumberStore.State(data: ["SKT", "KT", "LG U+", "SKT 알뜰폰", "KT 알뜰폰", "LG U+ 알뜰폰"])) {phoneNumberStore()}
    )
}
