//
//  ContentView.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 02.07.2025.
//

import SwiftUI
import FirebaseFirestore

struct MainView: View {
    @FirestoreQuery(collectionPath: "shop") var items: [Product]
    private var columns: [GridItem] = Array(repeating: GridItem(), count: 2)
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.pink.opacity(0.6),Color.white, Color.pink.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Color.white
                .opacity(0.3)
                .blur(radius: 50)
                .blendMode(.plusLighter)
                .ignoresSafeArea()
            
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(items) { item in
                            ProductCardView(product: item)
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
                        NavigationLink(destination: CardView()) {
                            Image(systemName: "cart.fill")
                                .font(.title2)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
