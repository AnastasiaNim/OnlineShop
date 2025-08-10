//
//  AuthScreen.swift
//  OnlineShop
//
//  Created by Anastasia N. on 26.07.2025.
//

import SwiftUI

struct AuthScreen: View {
    @Environment(\.dismiss) var dismiss
    @State var isHaveAccount: Bool = false
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @StateObject private var vm = AuthViewModel()
    var body: some View {
        GeometryReader { proxy in
            Color.primaryBg.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                
                iconView(proxy.size.height)

                VStack(alignment: .leading, spacing: 0) {
                    if isHaveAccount {
                        haveAccountForm
                            .transition(.move(edge: .leading))
                            .padding(.horizontal, 24)
                    } else {
                        newAccountForm
                            .transition(.move(edge: .trailing))
                            .padding(.horizontal, 24)
                    }
                }
                .vTop()
            }
        }
        .ignoresSafeArea(.keyboard)
        .tapOnHideKeyboard()
        .alert("Error", isPresented: $vm.showError) {
            Button("Ok", action: {})
        } message: {
            Text(vm.error?.localizedDescription ?? "Something went wrong")
        }
        .onChange(of: vm.completed) { _, newValue in
            if newValue {
                dismiss()
            }
        }
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
            }
            .padding()
        }
    }
}

#Preview {
    AuthScreen()
}

extension AuthScreen {
    
    private func iconView(_ height: CGFloat) -> some View {
        Image(systemName: "icloud.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(.secondaryBrand)
            .hCenter()
            .padding(.top, height * 0.03)
            .padding(.bottom, height * 0.1)
    }
    
    @ViewBuilder
    private var haveAccountButton: some View {
        HStack {
            if isHaveAccount {
                Text("Don't have an account? ")
                    .foregroundStyle(.primaryFont)
                Button("Sign up") {
                    withAnimation(.easeInOut) {
                        isHaveAccount = false
                    }
                }
            } else {
                Text("Already have an account?")
                    .foregroundStyle(.primaryFont)
                Button("Sign in") {
                    withAnimation(.easeInOut) {
                        isHaveAccount = true
                    }
                }
              
            }
        }
        .hCenter()
        .tint(.secondaryBrand)
        .font(.system(size: 14).weight(.semibold))
    }
    
    private var haveAccountForm: some View {
        VStack(alignment: .leading, spacing: 30) {
            primaryText
            PrimaryTextFieldView(text: $email, isSecured: false, placeholder: "Enter email", label: "Email", textContentType: .emailAddress)
            PrimaryTextFieldView(text: $password, isSecured: true, placeholder: "Enter pass", label: "Password")
            
            mainButton
            
            haveAccountButton
        }
    }
    
    private var newAccountForm: some View {
        VStack(alignment: .leading, spacing: 30) {
            primaryText
            
            PrimaryTextFieldView(text: $name, isSecured: false, placeholder: "Enter username", label: "Username", textContentType: .name)
            PrimaryTextFieldView(text: $email, isSecured: false, placeholder: "Enter email", label: "Email", textContentType: .emailAddress)
            VStack(alignment: .leading, spacing: 20) {
                PrimaryTextFieldView(text: $password, isSecured: true, placeholder: "Enter pass", label: "Password")
                Text("By continuing you agree to our Terms of Service and Privacy Policy")
                    .font(.appFont(14))
                    .foregroundStyle(.secondaryFont)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            mainButton
            
            haveAccountButton
        }
    }
    
    private var mainButton: some View {
        
        ZStack {
            Text(isHaveAccount ? "Log in" : "Sign up")
                .opacity(vm.isLoading ? 0 : 1)
            if vm.isLoading {
                ProgressView()
                    .tint(.white)
            }
        }
        .asMainButton {
            if isHaveAccount {
                vm.signIn(email: email, password: password)
            } else {
                vm.singUp(email: email, password: password, name: name)
            }
        }

    }
    
    private var primaryText: some View {
        VStack (alignment: .leading, spacing: 15) {
            Text(isHaveAccount ? "Loging" : "Sign Up")
                .font(.appFont(26, .semibold))
                .foregroundStyle(.primaryFont)
            Text(isHaveAccount ? "Enter your emails and password" : "Enter your credentials to continue")
                .font(.appFont(16))
                .foregroundStyle(.secondaryFont)
        }
    }
    

}
