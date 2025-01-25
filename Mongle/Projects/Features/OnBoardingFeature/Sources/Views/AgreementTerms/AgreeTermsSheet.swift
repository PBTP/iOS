//
//  AgreeTermsView.swift
//  OnBoardingFeature
//
//  Created by bulmang on 4/19/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI

struct AgreeTermsSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedIndices: Set<Int> = []
    @State private var showAlert: Bool = false
    @Binding var isRequiredTermsAgreed: Bool

    private let data: [(text: String, description: String, isRequired: Bool)] = [
        ("만 14세 이상 이용, 서비스 이용약관, 개인정보 수집 및 이용 동의 (필수)", "해당 약관에 동의하시면 서비스 이용이 가능합니다.", true),
        ("개인정보 수집 및 이용 동의 (선택)", "해당 약관은 선택사항으로 동의하지 않아도 서비스 이용이 가능합니다.", false),
        ("특가, 쿠폰 등 마케팅 정보 수신 동의 (선택)", "마케팅 정보 수신에 동의하시면 관련 혜택을 제공받을 수 있습니다.", false),
        ("위치 정보 이용 약관 동의 (선택)", "위치 정보 이용에 동의하시면 맞춤형 서비스를 받을 수 있습니다.", false)
    ]

    private var isAllRequiredTermsAgreed: Bool {
        let requiredIndices = data.indices.filter { data[$0].isRequired }
        return Set(requiredIndices).isSubset(of: selectedIndices)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("약관동의")
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay(alignment: .trailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image.xCloseIcon
                    }
                }
                .padding(.top, 30)
            Button(action: toggleAll) {
                HStack(spacing: 8) {
                    if selectedIndices.count == data.count {
                        Image.checkBoxFillIcon
                    } else {
                        Image.checkBoxEmptyIcon
                    }
                    Text("전체동의")
                        .font(.mgBody3)
                        .foregroundColor(.black)
                    Text("(선택포함)")
                        .font(.mgCaption1)
                        .foregroundColor(.mongleGrayScale500)
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.mongleGrayScale100, lineWidth: 1)
                )
            }
            ForEach(data.indices, id: \.self) { index in
                TermsRow(
                    isAgreed: Binding(
                        get: { selectedIndices.contains(index) },
                        set: { newValue in
                            toggleSelection(at: index, isSelected: newValue)
                        }
                    ),
                    text: data[index].text,
                    termDescription: data[index].description,
                    onToggle: {
                        print("\(data[index].text) 상태가 변경되었습니다.")
                    }
                )
            }
            confirmButton("동의하고 계속하기", isDisabeld: !isAllRequiredTermsAgreed) {
                dismiss()
                isRequiredTermsAgreed = true
            }.onTapGesture {
                if !isAllRequiredTermsAgreed {
                    showAlert = true
                }
            }
        }
        .padding(.horizontal, 20)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("필수 약관에 동의해주세요."),
                primaryButton: .default(Text("확인")),
                secondaryButton: .cancel(Text("취소"))
            )
        }
    }

    private func toggleAll() {
        if selectedIndices.count == data.count {
            selectedIndices.removeAll()
        } else {
            selectedIndices = Set(data.indices)
        }
    }

    private func toggleSelection(at index: Int, isSelected: Bool) {
        if isSelected {
            selectedIndices.insert(index)
        } else {
            selectedIndices.remove(index)
        }
    }

    private func resetSelections() {
        selectedIndices.removeAll()
    }
}


#Preview {
    Text("약관 동의")
        .sheet(isPresented: .constant(true)) {
            AgreeTermsSheet(isRequiredTermsAgreed: .constant(false))
                .presentationDetents([.medium])
        }
}

