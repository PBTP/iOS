//
//  AgreeTermsView.swift
//  OnBoardingFeature
//
//  Created by bulmang on 4/19/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import Ui

@Reducer
public struct AgreeStore {
    public init() {
        
    }
    
    @ObservableState
    public struct State: Equatable {
        public init(isPressed: Bool = false, data: [String], selectedText: String? = nil, selectedIndices: Set<Int> = []) {
            self.isPressed = isPressed
            self.data = data
            self.selectedText = selectedText
            self.selectedIndices = selectedIndices
        }
        var isPressed = false
        var data: [String] = ["전체동의 (선택포함)","만 14세 이상 이용, 서비스 이용약관, 개인정보 수집 및 이용 동의 (필수)", "개인정보 수집 및 이용 동의 (선택)", "특가, 쿠폰 등 마케팅 정보 수신 동의 (선택)", "위치 정보 이용 약관 동의 (선택)"]
        var selectedText: String?
        var selectedIndices: Set<Int>
    }
    
    public enum Action {
        case toggleChanged(isOn: Bool)
        case selectText(index: Int)
        case initSelectedIndices
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .toggleChanged(isOn):
                state.isPressed = isOn
                return .none
                
            case let .selectText(index):
                if state.selectedIndices.contains(index) {
                    if index == 0 {
                        state.selectedIndices.removeAll()
                    } else {
                        state.selectedIndices.remove(index)
                    }
                } else {
                    if index == 0 {
                        for i in 0..<state.data.count {
                            state.selectedIndices.insert(i)
                        }
                    } else {
                        state.selectedIndices.insert(index)
                    }
                }
                state.selectedText = state.data[index]
                return .none
            case .initSelectedIndices:
                state.selectedIndices.removeAll()
                return .none
            }
        }
    }
}

public struct AgreeTermsSheet: View {
    let store: Store<AgreeStore.State, AgreeStore.Action>
    
    public init(store: Store<AgreeStore.State, AgreeStore.Action>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(store.state.data.indices, id: \.self) { index in
                Button(action: {
                    self.store.send(.selectText(index: index))
                    print("\(store.state.selectedIndices)")
                }) {
                    if index == 0 {
                        HStack(spacing: 8) {
                            if store.state.selectedIndices.contains(index) {
                                Image.checkBoxFillIcon
                            } else {
                                Image.checkBoxEmptyIcon
                            }
                            
                            
                            Text(store.state.data[index])
                                .font(index == 0 ? .mgBody3 : .mgBody4)
                                .foregroundStyle(Color.black)
                            
                            Text("(선택포함)")
                                .font(.mgCaption1)
                                .foregroundStyle(Color.mongleGrayScale500)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.mongleGrayScale100, lineWidth: 1)
                        )
                    } else {
                        if store.state.selectedIndices.contains(index) {
                            Image.checkBoxFillIcon
                                .padding(.leading, 16)
                        } else {
                            Image.checkBoxEmptyIcon
                                .padding(.leading, 16)
                        }
                        
                        Text(store.state.data[index])
                            .font(.mgBody4)
                            .foregroundStyle(Color.black)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .overlay(alignment: .trailing) {
                                Button {
                                    
                                } label: {
                                    Image.chevronDownIcon
                                }
                            }
                    }
                }
            }
            
            ConfirmButton("동의하고 계속하기", isDisabeld: true) {}
        }
        .padding(.horizontal, 20)
        .navigationBarTitle(Text("약관 동의"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.store.send(.toggleChanged(isOn: false))
            self.store.send(.initSelectedIndices)
        }) {
            Image.xCloseIcon
        })
    }
}

#Preview {
    AgreeTermsSheet(
        store: Store(initialState: AgreeStore.State(data:  ["전체 동의","만 14세 이상 이용, 서비스 이용약관, 개인정보 수집\n 및 이용 동의 (필수)", "개인정보 수집 및 이용 동의 (선택)", "특가, 쿠폰 등 마케팅 정보 수신 동의 (선택)", "위치 정보 이용 약관 동의 (선택)"])) {AgreeStore()}
    )
}
