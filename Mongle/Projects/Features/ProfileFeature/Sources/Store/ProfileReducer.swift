//
//  ProfileReducer.swift
//  ProfileFeature
//
//  Created by bulmang on 7/31/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import ComposableArchitecture
import SwiftUI

@Reducer
struct BindingBasics {
    @ObservableState
    struct State: Equatable {
      var sliderValue = 5.0
      var stepCount = 10
      var text = ""
      var toggleIsOn = false
    }

  enum Action {
    case textChanged(String)
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case let .textChanged(text):
          state.text = text
        return .none
      }
    }
  }
}
