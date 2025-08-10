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
    @StateObject private var authFormManager = AuthValidationManager()
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
        .onAppear {
            authFormManager.startValidation(true)
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
                    authFormManager.startValidation(true)
                    withAnimation(.easeInOut) {
                        isHaveAccount = false
                    }
                }
            } else {
                Text("Already have an account?")
                    .foregroundStyle(.primaryFont)
                Button("Sign in") {
                    authFormManager.startValidation(false)
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
            emailForm
            passwordForm
            mainButton
            haveAccountButton
        }
    }
    
    private var newAccountForm: some View {
        VStack(alignment: .leading, spacing: 30) {
            primaryText
            nameForm
            emailForm
            VStack(alignment: .leading, spacing: 20) {
                passwordForm
                Text("By continuing you agree to our [Terms of Service](https://google.com) and [Privacy Policy](https://google.com)")
                    .font(.appFont(14))
                    .foregroundStyle(.secondaryFont)
                    .fixedSize(horizontal: false, vertical: true)
            }
            mainButton
            haveAccountButton
        }
    }
    
    private var emailForm: some View {
        VStack(alignment: .leading, spacing: 10) {
            PrimaryTextFieldView(text: $authFormManager.email, isSecured: false, placeholder: "Enter email", label: "Email", textContentType: .emailAddress)
                .textInputAutocapitalization(.never)
            validText(authFormManager.emailValidStr)
        }
    }
    
    private var passwordForm: some View {
        VStack(alignment: .leading, spacing: 10) {
            PrimaryTextFieldView(text: $authFormManager.password, isSecured: true, placeholder: "Enter pass", label: "Password")
                .textInputAutocapitalization(.never)
            validText(authFormManager.passwordValidStr)
        }
    }
    
    private var nameForm: some View {
        VStack(alignment: .leading, spacing: 10) {
            PrimaryTextFieldView(text: $authFormManager.name, isSecured: false, placeholder: "Enter username", label: "Username", textContentType: .name)
                .textInputAutocapitalization(.never)
            validText(authFormManager.nameValidStr)
        }
    }
    
    @ViewBuilder
    func validText(_ str: String?) -> some View {
        if let str {
            Text(str)
                .font(.appFont(12))
                .foregroundStyle(.red)
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
            guard authFormManager.isValid else { return }
            if isHaveAccount {
                vm.signIn(email: authFormManager.email,
                          password: authFormManager.password)
            } else {
                vm.singUp(email: authFormManager.email,
                          password: authFormManager.password, name: authFormManager.name)
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
