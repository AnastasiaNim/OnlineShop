//
//  ContentView.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 02.07.2025.
//

import SwiftUI
import FirebaseFirestore

struct MainView: View {
    @EnvironmentObject var vm: ViewModel
    @FirestoreQuery(collectionPath: "shop") var items: [Product]
    private var columns: [GridItem] = Array(repeating: GridItem(), count: 2)
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(items) { item in
                        NavigationLink(destination: DetailView(product: item)) {
                            ProductCardView(product: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal, 10)
            .background(Color.secondary.opacity(0.2))
            .shadow(color: .secondary.opacity(0.2), radius: 8, x: 5, y: 8)
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem( placement: .topBarLeading) {
                    NavigationLink(destination: FavoritesView()) {
                        Image(systemName: "heart.fill")
                            .font(.title2)
                        
                    }
                    .buttonStyle(.plain)
                    
                }
                ToolbarItem( placement: .topBarTrailing) {
                    NavigationLink(destination: CartView()) {
                        Image(systemName: "cart.fill")
                            .font(.title2)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(ViewModel())
}
