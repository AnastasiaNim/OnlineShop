//
//  BackButtonView.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 25.07.2025.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            ZStack {
                Circle()
                    .frame(width: 34)
                    .foregroundStyle(Color.blue).opacity(0.3)
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.white).opacity(0.8)
            }
        }

    }
}

#Preview {
    BackButtonView()
}
