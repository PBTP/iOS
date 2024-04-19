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
    var placeHolder = "010-0000-0000"
    var timerActive = false
    var requestButtonActive = false
    
    public init(text: String = "", placeHolder: String, timerActive: Bool, requestButtonActive: Bool) {
        self.text = text
        self.placeHolder = placeHolder
        self.timerActive = timerActive
        self.requestButtonActive = requestButtonActive
    }
    
    public var body: some View {
        TextField(placeHolder, text: $text)
            .keyboardType(.numberPad)
            .font(.mgBody1)
            .foregroundColor(Color.black)
            .padding(.leading, 16)
            .padding(.vertical, 12)
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
                    RequestButton("재요청") {}
                        .padding(.trailing, 16)
                }
            }
    }
}

#Preview {
    MongleNumberTextField(placeHolder: "010-0000-0000", timerActive: false, requestButtonActive: true)
}
