//
//  UserAccountManager.swift
//  OnlineShop
//
//  Created by Anastasia N. on 27.07.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

final class UserAccountManager: ObservableObject {
    
    @Published private(set) var user: User?
    private var cancellable: AnyCancellable?
    private var fbListener: ListenerRegistration?
    
    let userService = UserService()
        
    init() {
        startUserListenerIfNeeded()
    }
    
    deinit {
        cancellable?.cancel()
        fbListener?.remove()
    }
    
    var isLoggedIn: Bool {
        user != nil
    }
    
    func startUserListenerIfNeeded() {
        
        guard let userId = userService.getCurrentFbUserId() else { return }
        
        let (pub, listener) = userService.addUserListener(for: userId)
        fbListener = listener
        
        cancellable = pub
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] user in
                guard let self = self else { return }
                self.user = user
            }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            print(error.localizedDescription)
        }
    }
}
