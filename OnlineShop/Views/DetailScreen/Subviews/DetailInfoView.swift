//
//  DetailInfoView.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 25.07.2025.
//

import SwiftUI

struct DetailInfoView: View {
    @EnvironmentObject var basketManager: BasketManager
    let product: Product
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(product.name)
                    .titleFont()
                Spacer()
                Text("£ \(product.price)")
                    .titleFont()
            }
            Text(product.description)
                .subtitle()
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(6)
            
            Spacer()
            let isAdded = basketManager.isAddedToBasket(product)
            Button {
                if isAdded {
                    basketManager.removeProduct(product)
                } else {
                    basketManager.addProductToBasket(product)
                }
            } label: {
                Text(isAdded ? "Remove" : "Add to cart")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 8)
            }
            .padding()
        }
        .padding(.horizontal, 30)
    }
}

