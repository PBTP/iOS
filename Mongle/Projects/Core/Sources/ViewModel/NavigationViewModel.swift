//
//  NavigationViewModel.swift
//  Core
//
//  Created by Bokyung on 11/19/24.
//  Copyright © 2024 Mongle. All rights reserved.
//

import SwiftUI

public class NavigationViewModel: ObservableObject {
    @Published public var path: [Screen] = []

    public init(path: [Screen] = []) {
        self.path = path
    }

    public func handleDeeplink(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let route = components.host else { return }

        switch route {
        case Screen.home.rawValue:
            path.append(.home)
        case Screen.searchCompany.rawValue:
            path.append(.searchCompany)
        case Screen.notification.rawValue:
            path.append(.notification)
        case Screen.storeDetail.rawValue:
            path.append(.storeDetail)
        default:
            break
        }
    }
}

