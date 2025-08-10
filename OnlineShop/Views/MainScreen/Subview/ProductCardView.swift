//
//  ProductCardView.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 10.07.2025.
//

import SwiftUI

struct ProductCardView: View {
    @EnvironmentObject var vm: ViewModel
    let product: Product
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            ZStack(alignment: .bottom) {
                ZStack(alignment: .topTrailing) {
                    CardImageView(image: product.image, width: size.width, height: size.height)
//                    Button {
//                        vm.toggleFavorites(product: product)
//                    } label: {
//                        Image(systemName: "heart.fill")
//                            .padding(10)
//                            .foregroundStyle(product.isFavorite ? Color.red : .white)
//                            .background(Color.gray.opacity(0.2))
//                            .clipShape(Circle())
//                            .padding()
//                    }
                    
                }
                VStack(alignment: .leading) {
                    Text(product.name)
                        .titleFont()
                        .lineLimit(1)
                    Text("£ \(product.price)")
                        .subtitle()
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.background.opacity(0.5))
                .cornerRadius(10)
                .padding(10)
            }
        }
        .frame(height: UIScreen.main.bounds.width * 0.7)
    }
}

#Preview {
    CartView()
        .environmentObject(ViewModel())
}
