//
//  User.swift
//  OnlineShop
//
//  Created by Anastasia N. on 26.07.2025.
//

import Foundation
import FirebaseFirestore

struct User: Codable {
    let id: String
    let email: String
    let firstName: String
    var lastName: String?
    var birthDate: Date?
}
