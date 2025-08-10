//
//  ExtensionText.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 23.07.2025.
//

import SwiftUI

extension Text {
    func titleFont() -> some View {
        self
            .foregroundStyle(.primary)
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .opacity(0.8)
    }
    func subtitle() -> some View {
        self
            .foregroundStyle(.primary)
            .font(.system(size: 15, weight: .regular, design: .rounded))
            .opacity(0.8)
    }
}


#Preview {
    VStack {
        Text("Title")
            .titleFont()
        
        Text("Subtitle")
            .subtitle()
    }
}
