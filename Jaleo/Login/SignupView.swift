//
//  SignUpView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/22/24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignUpView: Bool  // Assuming you have a mechanism to toggle this view

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

            // Sign Up Button
            Button(action: {
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignUpView = false
                        print("Signed up successfully")
                    } catch {
                        print("Sign up error \(error)")
                    }
                }
            }) {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            // Error Messages
            if viewModel.weakPasswordError {
                Text("The password must be 6 characters long or more.")
                    .foregroundColor(.red)
            }

            if viewModel.invalidEmailError {
                Text("The email address is badly formatted.")
                    .foregroundColor(.red)
            }

            Spacer()
        }
        .navigationTitle("Sign up")
        .padding()
        .alert("Verification Required", isPresented: $viewModel.showVerificationAlert) {
            Button("OK") {
                // Close the alert and maybe toggle to sign-in view
                viewModel.showVerificationAlert = false
                showSignUpView = false
            }
        } message: {
            Text("Please verify your email. Check your inbox for the verification link.")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUpView: .constant(true))
    }
}
