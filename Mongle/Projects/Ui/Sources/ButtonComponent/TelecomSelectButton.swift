//
//  TelecomrSelectionButton.swift
//  Ui
//
//  Created by bulmang on 4/16/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

@Reducer
public struct PhoneNumberStore {
    public init() {
    
    }
    
    @ObservableState
    public struct State: Equatable {
        public init(isPressed: Bool = false, data: [String], selectedText: String? = nil) {
            self.isPressed = isPressed
            self.data = data
            self.selectedText = selectedText
        }
        var isPressed = false
        var data: [String] = ["SKT", "KT", "LG U+", "SKT 알뜰폰", "KT 알뜰폰", "LG U+ 알뜰폰"]
        var selectedText: String?
    }
    
    public enum Action {
        case toggleChanged(isOn: Bool)
        case selectText(index: Int)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .toggleChanged(isOn):
                state.isPressed = isOn
                return .none
            
            case let .selectText(index):
                state.selectedText = state.data[index]
                return .none
            }
        }
    }
}

public struct TelecomSelectButton: View {
    let store: Store<PhoneNumberStore.State, PhoneNumberStore.Action>
    let action: () -> Void
    
    public init(store: Store<PhoneNumberStore.State, PhoneNumberStore.Action>, action: @escaping () -> Void) {
        self.store = store
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            print("통신사 선택 버튼 클릭")
            self.store.send(.toggleChanged(isOn: true))
            action()
        }, label: {
            Text("\(store.selectedText ?? "통신사 선택")")
                .font(.mgBody1)
                .foregroundColor(store.selectedText == nil ? Color.mongleGrayScale300 : Color.black)
                .padding(.leading, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.mongleGrayScale100)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        })
        .sheet(isPresented: Binding(get: { self.store.state.isPressed }, set: { _ in })) {
            NavigationView {
                List {
                    ForEach(store.state.data, id: \.self) { text in
                        Button(action: {
                            // 버튼을 눌렀을 때 할 일을 여기에 구현합니다.
                            print("\(text) 통신사 선택")
                            if let index = store.state.data.firstIndex(of: text) {
                                self.store.send(.selectText(index: index))
                                self.store.send(.toggleChanged(isOn: false))
                            }
                        }) {
                            Text(text)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarTitle(Text("통신사 선택"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.store.send(.toggleChanged(isOn: false))
                }) {
                    Image.xCloseIcon
                })
            }
            .presentationDetents([.height(374)])
        }
    }
}



#Preview {
    TelecomSelectButton(
        store: Store(initialState: PhoneNumberStore.State(data: ["test"])) {PhoneNumberStore()}
    ) {}
}

    

