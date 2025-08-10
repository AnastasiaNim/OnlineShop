//
//  FBTimestamp.swift
//  OnlineShop
//
//  Created by Anastasia N. on 26.07.2025.
//

import FirebaseFirestore
import Foundation

struct FBTimestamp: Codable, Hashable {
    
    let timestamp: Timestamp

    init(date: Date = .now){
        self.timestamp = Timestamp(date: date)
    }
    
    var date: Date{
        timestamp.dateValue()
    }
}
