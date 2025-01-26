//
//  Request.swift
//  Core
//
//  Created by Bokyung on 12/30/24.
//  Copyright © 2024 Mongle. All rights reserved.
//

import Foundation

public typealias QueryItems = [String: Any]
public typealias HTTPHeader = [String: String]

public protocol Request {
    associatedtype Output: Decodable

    var endpoint: URL { get }
    var method: HTTPMethod { get }
    var query: QueryItems { get }
    var header: HTTPHeader { get }
}
