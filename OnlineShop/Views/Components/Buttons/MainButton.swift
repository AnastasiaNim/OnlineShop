//
//  MainButton.swift
//  OnlineShop
//
//  Created by Anastasia N. on 09.08.2025.
//

import SwiftUI

extension View {
    
    func asMainButton(fontColor: Color = .white,
                      backgroundColor: Color = .accentColor,
                      action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
                .modifier(MainButtonViewModifier(fontColor: fontColor, backgroundColor: backgroundColor))
        }
        .buttonStyle(.plain)
    }
}


fileprivate struct MainButtonViewModifier: ViewModifier {
    
    let fontColor: Color
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(fontColor)
            .font(.appFont(17, .medium))
            .frame(height: MainButtonDrawingConstants.height)
            .hCenter()
            .background(backgroundColor,
                        in: RoundedRectangle(cornerRadius: MainButtonDrawingConstants.cornerRadius))
    }
}

struct MainButtonDrawingConstants {
    static let height: CGFloat = 67
    static let cornerRadius: CGFloat = 19
}


#Preview {
    Text("Button")
        .asMainButton() {
            
        }
        .padding(.horizontal, 10)
}
