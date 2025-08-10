//
//  CartView.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 10.07.2025.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject private var basketManager: BasketManager
    var body: some View {
        VStack {
            ForEach(basketManager.basket.items) { item in
                HStack {
                    Text(item.product?.name ?? "")
                        .font(.headline)
                    Spacer()
                    Text("\(item.quantity)")
                    Text("\(item.product?.price ?? 0)")
                }
            }
            
        }
        .padding()
        .navigationTitle("Cart")
    }
}

#Preview {
    CartView()
        .environmentObject(BasketManager())
}
