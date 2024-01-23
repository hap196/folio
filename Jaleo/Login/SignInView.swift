//
//  SignInView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/22/24.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)

            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)

            // Sign In Button
            Button(action: {
                Task {
                    do {
                        try await viewModel.signIn()
                       // showSignInView = false
                        print("Signed in successfully")
                    } catch {
                        print("Sign in error \(error)")
                    }
                }
            }) {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            // Error Messages
            if viewModel.emailVerificationError {
                Text("Email not verified")
                    .foregroundColor(.red)
            } else if let loginError = viewModel.loginError, !viewModel.emailVerificationError {
                Text(loginError)
                    .foregroundColor(.red)
            }

            Spacer()
        }
        .navigationTitle("Sign in")
        .padding()
        .alert("Login Error", isPresented: Binding<Bool>.init(get: { viewModel.loginError != nil }, set: { _ in viewModel.loginError = nil })) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.loginError ?? "")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(showSignInView: .constant(true))
    }
}
