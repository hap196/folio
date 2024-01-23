//
//  SignUpView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/22/24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignUpView: Bool
    @Binding var signupSuccessful: Bool


    var body: some View {
        VStack {
            
            HStack {
                // Custom back button
                Button(action: {
                    // Action to dismiss this view
                    showSignUpView = false
                }) {
                    Image(systemName: "arrow.backward") // System icon for back arrow
                        .foregroundColor(.blue)
                        .padding()
                }

                Spacer()
            }
            
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)

            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)

            Button("Sign up") {
                Task {
                    do {
                        try await viewModel.signUp()
                        print("Signed up successfully")
                        if viewModel.signUpSuccess {
                            signupSuccessful = true
                        }
                    } catch {
                        print("Sign up error: \(error)")
                    }
                }
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)

            if viewModel.weakPasswordError {
                Text("The password must be 6 characters long or more.")
                    .foregroundColor(.red)
            }

            if viewModel.invalidEmailError {
                Text("The email address is badly formatted.")
                    .foregroundColor(.red)
            }

            Spacer()
            
            // Navigation link that will be activated on successful sign up
            NavigationLink(destination: HomeView(), isActive: $viewModel.signUpSuccess) {
                EmptyView()
            }
        }
        .navigationTitle("Sign up")
        .navigationBarBackButtonHidden(true) // Hides the default back button
        .padding()
//        .alert("Verification Required", isPresented: $viewModel.showVerificationAlert) {
//            Button("OK", role: .cancel) {}
//        } message: {
//            Text("Please verify your email. Check your inbox for the verification link. You can verify your email later in Settings.")
//        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView(showSignUpView: .constant(true), signupSuccessful: .constant(false))
        }
    }
}
