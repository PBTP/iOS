//
//  OnBoardingReducer.swift
//  OnBoardingFeature
//
//  Created by bulmang on 5/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import ComposableArchitecture

@Reducer(state: .equatable)
public enum OnBoardingReducer {
    case agree(AgreeStore)
    case authentication(KaKaoAuthCore)
    
    public static var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .agree:
                state = .agree(AgreeStore.State())
                return .none
            case .authentication:
                state = .authentication(KaKaoAuthCore.State())
                return .none
            }
        }
        .ifCaseLet(\.agree, action: \.agree) {
            AgreeStore()
        }
        .ifCaseLet(\.authentication, action: \.authentication) {
            KaKaoAuthCore()
        }
    }
}
