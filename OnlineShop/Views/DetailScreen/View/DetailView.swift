//
//  DetailView.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 24.07.2025.
//

import SwiftUI

struct DetailView: View {
    let product: Product
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                VStack {
                    CardImageView(
                        image: product.image,
                        width: geometry.size.width,
                        height: geometry.size.height / 1.7
                    )
                    .ignoresSafeArea()
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 8)
                    
                    DetailInfoView(product: product)
                }
                .background(Color.secondary.opacity(0.23))
                .navigationBarBackButtonHidden()
                
                BackButtonView()
                    .padding(.leading)
            }
        }
    }
}

#Preview {
    DetailView(product: Product(id: "d", name: "Dior Backstage Rosy Glow Stick", description: "Complete your glow routine with an exclusive Glow Makeup Trio by clicking here, designed for a radiant, rosy pink glow. The Dior blush stick offers 12 hours¹ of custom colour and a dewy-glow finish that reflects light, for cheekbones that appear enhanced and plumped. Powered by a unique technology², each shade reacts to the skin's pH and takes on cool pink or warm coral undertones. Moisturising and comfortable, the creamy texture of the Rosy Glow blush stick blends seamlessly with the skin for a bare-skin effect for a clean look. - SHADES: 7 shades that adapt to skin's pH for a custom makeup result - FINISHES: 2 dewy-glow finishes, radiant and pearlescent - COVERAGE: buildable, for natural to intense looks - TEXTURE: smooth and easy to blend - CARE: 12 hours of hydration³ and comfortable wear powered by a formula infused with cherry oil ¹ Instrumental test on 25 women. ² At Dior. ³ Instrumental test on 30 subjects.", image: "https://www.dior.com/dw/image/v2/BGXS_PRD/on/demandware.static/-/Sites-master_dior/default/dw939ef2ef/Y0000048/Y0000048_E000000453_E01_ZHC.jpg", price: 37, isFavorite: true, quanlityInCart: 1))
}

