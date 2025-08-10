//
//  AuthViewModel.swift
//  OnlineShop
//
//  Created by Anastasia N. on 26.07.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published private(set) var isLoading: Bool = false
    @Published var error: Error? = nil
    @Published var showError: Bool = false
    @Published var completed: Bool = false
    
    let service: AuthServiceProtocol
    
    init(service: AuthServiceProtocol = AuthService()) {
        self.service = service
    }
    
    func signIn(email: String, password: String) {
        guard !isLoading else { return }
        Task(priority: .high) {
            isLoading = true
            defer { isLoading = false }
            do {
                try await service.signIn(email: email, password: password)
                completed = true
            } catch {
                handleError(error)
            }
        }
    }
    
    func singUp(email: String, password: String, name: String) {
        guard !isLoading else { return }
        Task(priority: .high) {
            isLoading = true
            defer { isLoading = false }
            do {
                try await service.singUp(email: email, password: password, name: name)
                completed = true
            } catch {
                handleError(error)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        self.error = error
        showError = true
    }
}
