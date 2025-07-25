//
//  ProductRow.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 25.07.2025.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .trailing) {
                HStack(spacing: 20) {
                    CardImageView(image: product.image, width: 100, height: 100)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text(product.name)
                            .lineLimit(1)
                        Text("£ \(product.price)")
                    }
                    Spacer()
                }
                .padding(10)
                .background(.background)
                .cornerRadius(20)
                
                VStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                    }
                    .buttonStyle(.plain)
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "minus.rectangle.fill")
                                .foregroundStyle(Color.primary)
                                .font(.title)
                        }
                        .buttonStyle(.plain)
                        
                        if let quanlityInCart = product.quanlityInCart{
                            
                            Text("\(quanlityInCart)")
                                .titleFont()
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "plus.rectangle.fill")
                                .foregroundStyle(Color.primary)
                                .font(.title)
                        }

                        .buttonStyle(.plain)


                    }

                }
                
                
                
            }
        }
        .padding(.horizontal, 10)
        .navigationTitle("Cart")
        .background(Color.secondary.opacity(0.23))
    }
}

#Preview {
    ProductRow(product: Product(id: "d", name: "Dior Backstage Rosy Glow Stick", description: "Complete your glow routine with an exclusive Glow Makeup Trio by clicking here, designed for a radiant, rosy pink glow. The Dior blush stick offers 12 hours¹ of custom colour and a dewy-glow finish that reflects light, for cheekbones that appear enhanced and plumped. Powered by a unique technology², each shade reacts to the skin's pH and takes on cool pink or warm coral undertones. Moisturising and comfortable, the creamy texture of the Rosy Glow blush stick blends seamlessly with the skin for a bare-skin effect for a clean look. - SHADES: 7 shades that adapt to skin's pH for a custom makeup result - FINISHES: 2 dewy-glow finishes, radiant and pearlescent - COVERAGE: buildable, for natural to intense looks - TEXTURE: smooth and easy to blend - CARE: 12 hours of hydration³ and comfortable wear powered by a formula infused with cherry oil ¹ Instrumental test on 25 women. ² At Dior. ³ Instrumental test on 30 subjects.", image: "https://www.dior.com/dw/image/v2/BGXS_PRD/on/demandware.static/-/Sites-master_dior/default/dw939ef2ef/Y0000048/Y0000048_E000000453_E01_ZHC.jpg", price: 37, isFavorite: true, quanlityInCart: 1))
}
