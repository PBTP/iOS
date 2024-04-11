//
//  FontExtension.swift
//  DesignSystem
//
//  Created by bulmang on 4/11/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public extension Font {
    /// Mongle 서비스의 Pretendard 폰트를 반환하는 함수 입니다.
    ///
    /// - Parameters:
    ///     - size: Mongle 폰트 사이즈
    ///
    /// - Returns: Mongle의 Pretendard Font
    static func pretendard(size: Font.MongleFontSize) -> Font {
        return mongleFont(library: .pretendard, size: size)
    }
    
    /// Mongle 서비스의 Custom Font를 반환하는 함수 입니다.
    ///
    /// - Parameters:
    ///     - library: Mongle 폰트 패밀리
    ///     - size: Mongle 폰트 사이즈
    ///
    /// - Returns: Mongle의 Custom Font
    static private func mongleFont(
        library: Font.MongleFontLibrary = .pretendard,
        size: Font.MongleFontSize) -> Font {
            let weight = mongleFontWeight(library: library, size: size)
            let fileName = mongleFontFileName(library: library, weight: weight)
            let width = size.width(library: library)
            
            return .custom(fileName, size: width)
    }
    
    /// Mongle 서비스의 Custom Font의 File Name를 반환하는 함수 입니다.
    ///
    /// - Parameters:
    ///     - library: Mongle 폰트 모임
    ///     - weight: Mongle 폰트 굵기
    ///
    /// - Returns: Mongle의 Custom Font의 FIle Name
    static private func mongleFontFileName(library: Font.MongleFontLibrary, weight: Font.MongleFontWeight) -> String {
        switch library {
        case .pretendard:
            switch weight {
            case .black: return "Pretendard-Black"
            case .bold: return "Pretendard-Bold"
            case .extraBold: return "Pretendard-ExtraBold"
            case .extraLight: return "Pretendard-ExtraLight"
            case .light: return "Pretendard-Light"
            case .medium: return "Pretendard-Medium"
            case .semiBold: return "Pretendard-SemiBold"
            case .thin: return "Pretendard-Thin"
            }
        }
    }
    
    /// Mongle 서비스의 Custom Font의 Weight를 반환하는 함수 입니다.
    ///
    /// - Parameters:
    ///     - library: Mongle 폰트 패밀리
    ///     - size: Mongle 폰트 사이즈
    ///
    /// - Returns: Mongle의 Custom Font의 Weight
    static private func mongleFontWeight(library: Font.MongleFontLibrary, size: Font.MongleFontSize) -> MongleFontWeight {
        switch library {
        case .pretendard:
            switch size {
            case .heading1, .heading2, .title1, .title2, .title3:
                return .bold
                
            case .body1, .body2, .body3, .body4:
                return .medium
                
            case .caption1:
                return .semiBold
            }
        }
    }
}

public extension Font {
    /// Mongle 서비스의 Font Weight 목록입니다.
    ///
    ///   - pretendard
    ///   - tenada
    enum MongleFontLibrary {
        case pretendard
    }
    
    /// Mongle 서비스의 Font Weight 목록입니다.
    ///
    ///   - black
    ///   - bold
    ///   - extraBold
    ///   - extraLight
    ///   - light
    ///   - medium
    ///   - semiBold
    ///   - thin
    enum MongleFontWeight {
        case black
        case bold
        case extraBold
        case extraLight
        case light
        case medium
        case semiBold
        case thin
    }
    
    /// Mongle 서비스의 Font Size의 목록입니다.
    ///
    ///   - heading1
    ///   - h1
    ///   - h2
    ///   - h3
    ///   - h4
    ///   - h5
    ///   - body1
    ///   - body2
    ///   - body3
    ///   - body4
    ///   - caption1
    ///   - caption2
    enum MongleFontSize {
        case heading1
        case heading2
        case title1
        case title2
        case title3
        case body1
        case body2
        case body3
        case body4
        case caption1
        
        func width(library: MongleFontLibrary) -> CGFloat {
            switch library {
            case .pretendard:
                switch self {
                case .heading1: return 24
                case .heading2: return 22
                case .title1: return 17
                case .title2: return 16
                case .title3: return 15
                case .body1: return 18
                case .body2: return 16
                case .body3: return 14
                case .body4: return 13
                case .caption1: return 11
                }
            }
        }
    }
}
