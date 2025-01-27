//
//  URL+Extension.swift
//  Core
//
//  Created by Bokyung on 1/26/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import Foundation

public extension URL {
    func appendingPath(_ path: String) -> URL {
        return appendingPathComponent(path)
    }

    func appendingQuery(key: String, value: String) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return self }
        var queryItems = components.queryItems ?? []
        queryItems.append(.init(name: key, value: value))
        components.queryItems = queryItems
        guard let url = components.url else { return self }
        return url
    }
}
