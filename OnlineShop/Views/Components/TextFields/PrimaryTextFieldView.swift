//
//  PrimaryTextFieldView.swift
//  OnlineShop
//
//  Created by Anastasia N. on 09.08.2025.
//

import SwiftUI

struct PrimaryTextFieldView: View {
    @FocusState private var isFocused: Bool
    @State private var showPassword: Bool = false
    @Binding var text: String
    let isSecured: Bool
    let placeholder: String
    let label: String?
    var textContentType: UITextContentType? = nil
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            if let label {
                Text(label)
                    .font(.appFont(16, .medium))
                    .foregroundStyle(.secondaryFont)
                    .lineLimit(1)
            }
            ZStack {
                if isSecured {
                    secureTextField
                } else {
                    commonTextField
                }
            }
            .frame(height: 40)
            .focused($isFocused)
            .overlay(alignment: .bottom) {
                Divider()
                    .background(isFocused ? .secondaryBrand : .secondaryFont)
            }
        }
        .hLeading()
    }
}

#Preview {
    @Previewable @State var text = ""
    VStack(spacing: 30) {
        PrimaryTextFieldView(text: $text, isSecured: false, placeholder: "test", label: "Label2")
        PrimaryTextFieldView(text: $text, isSecured: true, placeholder: "test", label: "Label1")
    }

}

extension PrimaryTextFieldView {
    
    private var commonTextField: some View {
        TextField(text: $text) {
            placeholderView
        }
        .textContentType(textContentType)
    }
    
    private var secureTextField: some View {
        HStack {
            ZStack {
                if showPassword {
                    commonTextField
                } else {
                    SecureField(text: $text) {
                        placeholderView
                    }
                }
            }
            .textContentType(.password)
            
            Spacer()
            
            Button {
                showPassword.toggle()
            } label: {
                Image(systemName:  showPassword ? "eye.slash" : "eye")
                    .font(.appFont(14, .medium))
                    .foregroundStyle(.secondaryFont)
            }
        }
    }
    
    private var placeholderView: some View {
        Text(placeholder)
            .font(.appFont(16, .medium))
            .foregroundStyle(.secondaryFont)
    }
}
