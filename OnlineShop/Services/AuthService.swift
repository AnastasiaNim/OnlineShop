//
//  AuthService.swift
//  OnlineShop
//
//  Created by Anastasia N.on 26.07.2025.
//

import FirebaseAuth
import FirebaseFirestore

protocol AuthServiceProtocol {
    func signIn(email: String, password: String) async throws
    func singUp(email: String, password: String, name: String) async throws
    func signOut() throws
}

struct AuthService: AuthServiceProtocol {
    
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func singUp(email: String, password: String, name: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let id = result.user.uid
        try await UserService().createUserIfNeeded(user: .init(id: id, email: result.user.email ?? "", firstName: name))
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
