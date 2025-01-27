//
//  String+Extension.swift
//  Core
//
//  Created by Bokyung on 1/27/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import Foundation

public extension String {
    // 문자열의 처음 `size`개의 문자로 이루어진 부분 문자열을 반환
    func take(_ size: Int) -> String {
        return String(prefix(size))
    }

    // 문자열의 앞뒤 공백 및 줄 바꿈 문자를 제거한 문자열 반환
    func trimmed() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // 문자열을 URL로 변환
    func toURL() -> URL {
        let trimmedText = self.trimmed()
        if let url = URL(string: trimmedText) {
            return url
        }
        if let encodedText = trimmedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encodedText) {
            return url
        }
        return NSURLComponents().url!
    }
}
