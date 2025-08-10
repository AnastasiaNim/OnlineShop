//
//  CatalogScreen.swift
//  OnlineShop
//
//  Created by Anastasia N. on 27.07.2025.
//

import SwiftUI
import FirebaseFirestore

struct CatalogScreen: View {
    @FirestoreQuery(collectionPath: FB.usersCollectionName) var users: [User]
    @FirestoreQuery(collectionPath: FB.productsCollectionName) var items: [Product]
    private var columns: [GridItem] = Array(repeating: GridItem(), count: 2)
    @EnvironmentObject var router: MainRouter
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Catalog")
                .font(.title.bold())
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(items) { item in
                        Button {
                            router.navigate(to: .productDetails(item))
                        } label: {
                            ProductCardView(product: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .background(Color.secondary.opacity(0.2))
        .shadow(color: .secondary.opacity(0.2), radius: 8, x: 5, y: 8)

//        .toolbar {
//            ToolbarItem( placement: .topBarLeading) {
//                NavigationLink(destination: AuthScreen()) {
//                    Image(systemName: "heart.fill")
//                        .font(.title2)
//                    
//                }
//                .buttonStyle(.plain)
//                
//            }
//            ToolbarItem( placement: .topBarTrailing) {
//                if let user = users.first {
//                    Text(user.firstName)
//                }
//            }
//        }
    }
}

#Preview {
    CatalogScreen()
        .environmentObject(MainRouter())
}
