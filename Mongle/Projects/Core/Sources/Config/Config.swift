//
//  Config.swift
//  Mongle
//
//  Created by Bokyung on 9/18/24.
//  Copyright © 2024 Mongle. All rights reserved.
//

import Foundation

public protocol Config {
    var baseURL: String { get }
    var webBaseURL: String { get }
}
