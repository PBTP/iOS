//
//  LoginView.swift
//  OnBoardingFeature
//
//  Created by bulmang on 4/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import Ui

public struct LoginView: View {
    let store: Store<AgreeStore.State, AgreeStore.Action>
    
    public init(store: Store<AgreeStore.State, AgreeStore.Action>) {
        self.store = store
    }
    
    public var body: some View {
            VStack(spacing: 12) {
                HeaderComponent(headerText: "로그인", iconImageName: Image.xCloseIcon) {}
                
                Spacer()
                
                KaKaoLoginButton {
                    self.store.send(.toggleChanged(isOn: true))
                }
                
                AppleLoginButton {
                    self.store.send(.toggleChanged(isOn: true))
                }
                
                SkipLoginButton {}
                .padding(.top, 24)
                .padding(.bottom, 50)
            }
            .padding(.horizontal, 20)
            .sheet(isPresented: Binding(get: { self.store.state.isPressed }, set: { _ in })) {
                NavigationView {
                    AgreeTermsSheet(store: store)
                }
                .presentationDetents([.height(374)])
            }
    }
}

#Preview {
        LoginView(
            store: Store(initialState: AgreeStore.State(data:  ["전체 동의","만 14세 이상 이용, 서비스 이용약관, 개인정보 수집\n 및 이용 동의 (필수)", "개인정보 수집 및 이용 동의 (선택)", "특가, 쿠폰 등 마케팅 정보 수신 동의 (선택)", "위치 정보 이용 약관 동의 (선택)"])) {AgreeStore()}
        )
}
