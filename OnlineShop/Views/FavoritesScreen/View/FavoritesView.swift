//
//  FavoritesView.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 10.07.2025.
//

import SwiftUI
import FirebaseFirestore

struct FavoritesView: View {
    private var columns: [GridItem] = Array(repeating: GridItem(), count: 2)
    @FirestoreQuery(collectionPath: "shop", predicates: [.isEqualTo("isFavorite", true)]) private var favoritesItems: [Product]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(favoritesItems) {item in
                    NavigationLink(destination: EmptyView()) {
                        ProductCardView(product: item)
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}

#Preview {
    FavoritesView()
}
