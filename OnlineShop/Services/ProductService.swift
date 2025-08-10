//
//  ProductService.swift
//  OnlineShop
//
//  Created by Anastasia N.on 28.07.2025.
//

import Foundation
import FirebaseFirestore

struct ProductService {
    
    var productsCollections: CollectionReference {
        FB.productsCollection
    }
    
    func getProducts(for ids: [String]) async throws -> [Product] {
        try await withThrowingTaskGroup(of: Product?.self) { group in
            for id in ids {
                group.addTask {
                    try? await productsCollections
                        .document(id)
                        .getDocument(as: Product.self)
                }
            }
            return try await group.reduce(into: [Product]()) { result, product in
                if let product = product {
                    result.append(product)
                }
            }
        }
    }
}
