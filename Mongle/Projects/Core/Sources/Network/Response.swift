//
//  Response.swift
//  Core
//
//  Created by Bokyung on 12/30/24.
//  Copyright © 2024 Mongle. All rights reserved.
//

import Foundation

public struct Response<T: Codable>: Codable {
    let data: T?
    let message: String
    let statusCode: Int
    let secretMessage: String?
}
