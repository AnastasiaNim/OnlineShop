//
//  FirestoreConstants.swift
//  OnlineShop
//
//  Created by Anastasia N. on 25.07.2025.
//

import FirebaseFirestore

enum FB {
    
    static let db = Firestore.firestore()
    
    static let productsCollectionName = "products"
    static let usersCollectionName = "users"
    static let basketsCollectionName = "baskets"
    
    static let productsCollection = db.collection(productsCollectionName)
    static let usersCollection = db.collection(usersCollectionName)
    static let basketsCollection = db.collection(basketsCollectionName)
}
