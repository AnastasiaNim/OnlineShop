//
//  AuthValidationManager.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 10.08.2025.
//

import Foundation
import Combine

final class AuthValidationManager: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    
    @Published var emailValidStr: String?
    @Published var passwordValidStr: String?
    @Published var nameValidStr: String?
    
    private var isNewAccount: Bool?
    
    var isValid: Bool {
        if isNewAccount == true {
            return email.isValidEmail() && password.isValidPassword() && name.isValidName()
        } else {
           return email.isValidEmail() && password.isValidPassword()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func startValidation(_ isNewAccount: Bool) {
        self.isNewAccount = isNewAccount
        
        cancellables.forEach { c in
            c.cancel()
        }
        
        $email
            .dropFirst()
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { email in
                self.emailValidStr = email.isValidEmail() ? nil : "Email is not valid"
            }
            .store(in: &cancellables)
        
        $password
            .dropFirst()
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink { password in
                self.passwordValidStr = password.isValidPassword() ? nil : "The password must contain at least 6 characters"
            }
            .store(in: &cancellables)
        if isNewAccount {
            $name
                .dropFirst()
                .debounce(for: 0.1, scheduler: RunLoop.main)
                .sink { name in
                    self.nameValidStr = name.isValidName() ? nil : "The name must be at least 2 characters long"
                }
                .store(in: &cancellables)
        }
    }
  
}

public extension String {

    func isValidName() -> Bool {
        self.count >= 2
    }
    
    func isValidPassword(minLengthMoreThan minLength: Int = 6) -> Bool {
        self.count >= minLength
    }

    func isValidEmail() -> Bool {
        let pattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        guard let regex = regex else { return false }
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}
