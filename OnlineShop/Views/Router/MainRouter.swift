//
//  MainRouter.swift
//  OnlineShop
//
//  Created by Anastasia N. on 27.07.2025.
//

import Foundation
import SwiftUI

final class MainRouter: ObservableObject {
    
    @Published var currentTab: AppTab = .catalog
    @Published var navPath = NavigationPath()
    @Published var isShowAuth: Bool = false
    
    func navigate(to path: NavigationLinkType) {
        navPath.append(path)
    }
}

enum NavigationLinkType: Hashable {
    case productDetails(Product), createOrder, favoriteProducts, ordersHistory
}

enum AppTab: Int {
    
    case catalog, cart, profile
    
    var title: String {
        switch self {
        case .catalog:
            return "Catalog"
        case .cart:
            return "Cart"
        case .profile:
            return "Profile"
        }
    }
    
    var imageSysName: String {
        switch self {
        case .catalog:
            return "house"
        case .cart:
            return "cart"
        case .profile:
            return "person.circle"
        }
    }
}
