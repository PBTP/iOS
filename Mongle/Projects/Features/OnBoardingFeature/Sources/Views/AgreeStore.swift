//
//  AgreeStore.swift
//  OnBoardingFeature
//
//  Created by bulmang on 5/14/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import ComposableArchitecture

@Reducer
public struct AgreeStore: Sendable {
    
    @ObservableState
    public struct State: Equatable {
        public var isPressed = false
        public var data: [String] = ["전체동의 (선택포함)","만 14세 이상 이용, 서비스 이용약관, 개인정보 수집 및 이용 동의 (필수)", "개인정보 수집 및 이용 동의 (선택)", "특가, 쿠폰 등 마케팅 정보 수신 동의 (선택)", "위치 정보 이용 약관 동의 (선택)"]
        @Presents public var selectedText: String?
        public var selectedIndices: Set<Int> = []
        
        public init() {}
    }
    
    public enum Action: Sendable {
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
