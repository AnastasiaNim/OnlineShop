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
    @StateObject private var router = MainRouter()
    @StateObject private var accountManager = UserAccountManager()
    @StateObject private var basketManager = BasketManager()
    var body: some View {
        NavigationStack(path: $router.navPath) {
            TabView(selection: $router.currentTab) {
                CatalogScreen()
                    .tag(AppTab.catalog)
                    .tabItem {
                        Label(AppTab.catalog.title, systemImage: AppTab.catalog.imageSysName)
                    }
                
                CartView()
                    .tag(AppTab.cart)
                    .tabItem {
                        Label(AppTab.cart.title, systemImage: AppTab.cart.imageSysName)
                    }
                    .badge(basketManager.itemsCount)
                
                ProfileScreen()
                    .tag(AppTab.profile)
                    .tabItem {
                        Label(AppTab.profile.title, systemImage: AppTab.profile.imageSysName)
                    }
            }
            .navigationDestination(for: NavigationLinkType.self) { type in
                switch type {
                case .productDetails(let item):
                    DetailView(product: item)
                case .createOrder:
                    Text("createOrder")
                case .favoriteProducts:
                    Text("favoriteProducts")
                case .ordersHistory:
                    Text("ordersHistory")
                }
            }
            .fullScreenCover(isPresented: $router.isShowAuth,
                             onDismiss: onDismissAuth) {
                AuthScreen()
            }
        }
        .environmentObject(router)
        .environmentObject(accountManager)
        .environmentObject(basketManager)
    }
}

#Preview {
    MainView()
        .environmentObject(ViewModel())
}

extension MainView {
    
    func onDismissAuth() {
        accountManager.startUserListenerIfNeeded()
        basketManager.uploadBasket()
    }
    
}
