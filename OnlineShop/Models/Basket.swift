//
//  Basket.swift
//  OnlineShop
//
//  Created by Anastasia N. on 28.07.2025.
//

import Foundation
import FirebaseAuth

struct Basket: Codable {
    
    var userId: String
    var items: [BasketItem]
    
    struct BasketItem: Codable, Identifiable {
        var id: String { productId }
        let productId: String
        var quantity: Int
        var product: Product?
    }
    
    var itemsCount: Int {
        items.count
    }
    
    mutating func addProduct(_ product: Product) {
        guard let id = product.id else { return }
        items.append(BasketItem(productId: id, quantity: 1, product: product))
    }
    
    mutating func removeProduct(_ product: Product) {
        guard let id = product.id else { return }
        items.removeAll(where: {$0.productId == id})
    }
    
    mutating func incrementQuantityProduct(_ product: Product) {
        guard let id = product.id,
              let index = items.firstIndex(where: {$0.productId == id}) else { return }
        items[index].quantity += 1
    }
    
    mutating func decrementQuantityProduct(_ product: Product) {
        guard let id = product.id,
              let index = items.firstIndex(where: {$0.productId == id}) else { return }
        if items[index].quantity == 1 {
            removeProduct(product)
        } else {
            items[index].quantity -= 1
        }
    }
}

extension Basket {
    
    static let empty: Basket = .init(userId: "", items: [])
    
    func toJsonData() throws -> Data {
        let basket = basketForSave()
        return try JSONEncoder().encode(basket)
    }
    
    func basketForSave() -> Basket {
        var basket = self
        basket.items.indices.forEach { index in
            basket.items[index].product = nil
        }
        return basket
    }

    static let fileUrl: URL? = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?.appendingPathComponent("basket.json")
    
    static func getBasket() async -> Basket? {
        guard let fileUrl else {
            return nil
        }
        guard let data = try? Data(contentsOf: fileUrl) else { return nil }
        return try? JSONDecoder().decode(Basket.self, from: data)
    }
    
    static func save(_ basket: Basket) throws {
        guard let fileUrl else { return }
        print("saved to \(fileUrl)")
        do {
            let data = try basket.toJsonData()
            try data.write(to: fileUrl)
        } catch {
            print(error)
        }
    }
    
    static func removeFile() throws {
        guard let fileUrl else { return }
        try FileManager.default.removeItem(at: fileUrl)
    }
}



