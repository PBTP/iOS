//
//  MongleTextField.swift
//  Ui
//
//  Created by bulmang on 4/18/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public struct MongleNumberTextField: View {
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
            .background(Color.mongleGrayScale100)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(alignment: .trailing) {
                if timerActive {
                    Text("09:59")
                        .font(.mgBody4)
                        .foregroundStyle(Color.mongleColorPrimary300)
                        .padding(.trailing, 16)
                } else if requestButtonActive {
                    requestButton("재요청") {}
                        .padding(.trailing, 16)
                }
            }
    }
}

#Preview {
    VStack {
        MongleNumberTextField(placeHolder: "010-0000-0000", timerActive: false, requestButtonActive: true)
        MongleNumberTextField(placeHolder: "업체명을 입력하세요", leadingPadding: 20, verticalPadding: 15)
    }
}
