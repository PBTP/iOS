//
//  AgreeTermsView.swift
//  OnBoardingFeature
//
//  Created by bulmang on 4/19/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import UI

public struct AgreeTermsSheet: View {
    let store: Store<AgreeStore.State, AgreeStore.Action>
    
    public init(store: Store<AgreeStore.State, AgreeStore.Action>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
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
                
                ConfirmButton("동의하고 계속하기", isDisabeld: false) {
                    //                self.store.send(.child(.presented(AuthenticationReducer.Action.loginKakaoAccount)))
                }
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
}

#Preview {
    AgreeTermsSheet(
        store: Store(initialState: AgreeStore.State()) {AgreeStore()}
    )
}
