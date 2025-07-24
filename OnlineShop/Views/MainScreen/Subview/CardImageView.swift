//
//  CardImageView.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 11.07.2025.
//

import SwiftUI

struct CardImageView: View {
    
    let image: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ImageLoader(urlString: image)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

