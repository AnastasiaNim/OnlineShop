//
//  BasketService.swift
//  OnlineShop
//
//  Created by Anastasia N. on 28.07.2025.
//

import Foundation
import FirebaseFirestore

struct BasketService {
   
    func basketDoc(_ id: String) -> DocumentReference {
        FB.basketsCollection.document(id)
    }
    
    func getBasket(for id: String) async throws -> Basket? {
        try await basketDoc(id).getDocument(as: Basket.self)
    }
    
    func createBasket(for id: String, basket: Basket) throws {
        try basketDoc(id).setData(from: basket, merge: false)
    }
}


