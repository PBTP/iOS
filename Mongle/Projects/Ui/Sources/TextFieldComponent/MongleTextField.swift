//
//  MongleTextField.swift
//  Ui
//
//  Created by bulmang on 7/31/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public struct MongleTextField: View {
    @State var text = ""
    var placeHolder: String
    var numberKeyBoardActive: Bool
    var timerActive: Bool
    var requestButtonActive: Bool
    var leadingPadding: Double
    var verticalPadding: Double
    
    public init(text: String = "", placeHolder: String = "", numberKeyBoardActive: Bool = false, timerActive: Bool = false, requestButtonActive: Bool = false, leadingPadding: Double = 16, verticalPadding: Double = 12) {
        self.text = text
        self.placeHolder = placeHolder
        self.numberKeyBoardActive = numberKeyBoardActive
        self.timerActive = timerActive
        self.requestButtonActive = requestButtonActive
        self.leadingPadding = leadingPadding
        self.verticalPadding = verticalPadding
    }
    
    public var body: some View {
        TextField(placeHolder, text: $text)
            .keyboardType(numberKeyBoardActive ? .numberPad : .default)
            .font(.mgBody1)
            .foregroundColor(Color.black)
            .padding(.leading, leadingPadding)
            .padding(.vertical, verticalPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.mongleGrayScale100, lineWidth: 1)
            }
    }
}

#Preview {
    MongleTextField(placeHolder: "닉네임 입력")
}
