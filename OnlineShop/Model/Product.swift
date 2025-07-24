//
//  Model.swift
//  OnlineShop
//
//  Created by Anastasia N.  on 02.07.2025.
//

import Foundation
import FirebaseFirestore

struct Product: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var image: String
    var price: Int
    var isFavorite: Bool
    var quanlityInCart: Int?
    
}



