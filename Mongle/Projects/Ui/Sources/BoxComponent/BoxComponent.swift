//
//  BoxComponent.swift
//  Ui
//
//  Created by bulmang on 7/11/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

public struct InfoBox: View {
    public init(title: String, text: String, subtext: String?, verificationText: String?) {
        self.title = title
        self.text = text
        self.subtext = subtext
        self.verificationText = verificationText
    }
    let title: String
    let text: String
    let subtext: String?
    let verificationText: String?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.mgBody3)
                .foregroundStyle(Color.mongleGrayScale700)
            
            Text(text)
                .font(.mgBody2)
                .foregroundColor(Color.black)
                .padding(.leading, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.mongleGrayScale100)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            if let subtext = subtext {
                Text(subtext)
                    .font(.mgBody2)
                    .foregroundColor(Color.black)
                    .padding(.leading, 16)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.mongleGrayScale100)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(alignment: .trailing) {
                        if let verificationText = verificationText {
                            Text(verificationText)
                                .font(.mgBody3)
                                .foregroundStyle(Color.mongleColorPrimary300)
                                .offset(x: -16)
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            InfoBox(
                title: "이름",
                text: "사용자",
                subtext: nil,
                verificationText: nil
            )
            
            InfoBox(
                title: "연락처",
                text: "SKT",
                subtext: "010-0000-0000",
                verificationText: "인증 완료"
            )
        }
        .padding()
    }
}
