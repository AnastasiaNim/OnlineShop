//
//  ProfileScreen.swift
//  OnlineShop
//
//  Created by Anastasia N. on 27.07.2025.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var accountManager: UserAccountManager
    @EnvironmentObject var router: MainRouter
    @EnvironmentObject var basketManager: BasketManager
    var body: some View {
        VStack {
            if accountManager.isLoggedIn {
                Text(accountManager.user?.firstName ?? "")
                Button {
                    basketManager.resetBasketState()
                    accountManager.logout()
                } label: {
                    Text("logout")
                }

            } else {
                Button("Login") {
                    router.isShowAuth.toggle()
                }
            }
        }

    }
}

#Preview {
    ProfileScreen()
        .environmentObject(UserAccountManager())
        .environmentObject(MainRouter())
        .environmentObject(BasketManager())
}
