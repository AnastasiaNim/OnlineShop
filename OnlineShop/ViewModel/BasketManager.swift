//
//  BasketManager.swift
//  OnlineShop
//
//  Created by Anastasia N. on 03.08.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class BasketManager: ObservableObject {
    
    @Published var basket: Basket = .empty
    
    private let productService = ProductService()
    private let basketService = BasketService()
    
    var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    var isLogged: Bool {
        userId != nil
    }
    
    init() {
        initBasket()
    }
    
    var itemsCount: Int {
        basket.itemsCount
    }
    
    func initBasket() {
        Task { @MainActor in
            if let userId {
                basket.userId = userId
                
                let fbBasket = try? await basketService.getBasket(for: userId)
                if let fbBasket {
                    basket = fbBasket
                }
                
            } else {
                if let localBasket = await Basket.getBasket() {
                    basket = localBasket
                }
            }
            
            await updateBasketProducts()
        }
    }
    
    func isAddedToBasket(_ product: Product) -> Bool {
        basket.items.contains(where: {$0.productId == product.id})
    }
    
    func saveBasketIfNeeded() {
        if let userId {
            try? basketService.createBasket(for: userId, basket: basket.basketForSave())
        } else {
            try? Basket.save(basket)
        }
    }
    
    func addProductToBasket(_ product: Product) {
        basket.addProduct(product)
        saveBasketIfNeeded()
    }
    
    func removeProduct(_ product: Product) {
        basket.removeProduct(product)
        saveBasketIfNeeded()
    }
    
    func incrementQuantityProduct(_ product: Product) {
        basket.incrementQuantityProduct(product)
    }
    
    func decrementQuantityProduct(_ product: Product) {
        basket.decrementQuantityProduct(product)
    }
    
    func uploadBasket() {
        Task { @MainActor in
            if let userId, !basket.items.isEmpty {
                let newBasket = await mergeBaskets(userId)
                try basketService.createBasket(for: userId, basket: newBasket)
                try Basket.removeFile()
            }
            initBasket()
        }
    }
    
    func resetBasketState() {
        basket = .empty
    }
    
    func mergeBaskets(_ userId: String) async -> Basket {
        let localItems = self.basket.items
        let remoteItems = (try? await basketService.getBasket(for: userId)?.items) ?? []

        var mergedDict: [String: Int] = [:]

        for item in localItems {
            mergedDict[item.productId, default: 0] += item.quantity
        }

        for item in remoteItems {
            mergedDict[item.productId, default: 0] += item.quantity
        }

        let mergedItems = mergedDict.map { Basket.BasketItem(productId: $0.key, quantity: $0.value) }

        return Basket(userId: userId, items: mergedItems)
    }
        
    @MainActor
    func updateBasketProducts() async {
    
        let ids = basket.items.map({$0.productId})
        
        guard !ids.isEmpty else { return }
        
        let products = (try? await productService.getProducts(for: ids)) ?? []
        
        for product in products {
            guard let index = basket.items.firstIndex(where: {$0.productId == product.id}) else {
                continue
            }
            basket.items[index].product = product
        }
    }
}
