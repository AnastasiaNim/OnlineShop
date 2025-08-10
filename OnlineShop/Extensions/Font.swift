//
//  Font.swift
//  OnlineShop
//
//  Created by Anastasia N. on 09.08.2025.
//

import SwiftUI

extension Font {
    static func appFont(_ size: CGFloat, _ weight: Weight? = nil) -> Font {
        Font.system(size: size, weight: weight)
    }
}
