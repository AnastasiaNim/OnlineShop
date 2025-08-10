//
//  UserService.swift
//  OnlineShop
//
//  Created by Anastasia N. on 26.07.2025.
//

import FirebaseAuth
import FirebaseFirestore
import Combine

protocol UserServiceProtocol {
    func getCurrentFbUserId() -> String?
    func userDoc(_ id: String) -> DocumentReference
    func createUserIfNeeded(user: User) async throws
    func getCurrentUser() async throws -> User?
    func addUserListener(for id: String) -> (AnyPublisher<User?, Error>, ListenerRegistration)
}

struct UserService {
    
    func getCurrentFbUserId() -> String? {
        Auth.auth().currentUser?.uid
    }
    
    func userDoc(_ id: String) -> DocumentReference {
        FB.usersCollection.document(id)
    }
    
    func createUserIfNeeded(user: User) async throws {
        let doc = try await userDoc(user.id).getDocument()
        if !doc.exists {
            try userDoc(user.id).setData(from: user, merge: false)
        }
    }
    
    func getCurrentUser() async throws -> User? {
        
        guard let id = getCurrentFbUserId() else {
            return nil
        }
        
        return try await userDoc(id).getDocument(as: User.self)
    }
    
    func addUserListener(for id: String) -> (AnyPublisher<User?, Error>, ListenerRegistration) {
        userDoc(id).addSnapshotListener(as: User.self)
    }
}
