//
//  SignUpView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/22/24.
//

import SwiftUI

struct SignUpView: View {
//    @StateObject private var viewModel = SignInEmailViewModel()
    @ObservedObject var viewModel: SignInEmailViewModel
    @Binding var showSignUpView: Bool
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack(spacing: 5) {
            
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
            .padding(.top, 50)
            
            HStack {
                Text("Sign up")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)
                    .padding(.bottom, 10)
                    .shadow(color: .white, radius: 10, x: 5, y: 5) // Angled glowing shadow
                
                Spacer() // This pushes the Text to the left
            }
            .padding([.leading, .trailing]) // Add padding on the sides if needed

            
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .foregroundColor(.white.opacity(0.7))
                .padding(.bottom, 8)

            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(.bottom, 20)

            Button(action: {
                Task {
                    do {
                        try await viewModel.signUp()
                        print("Signed up successfully")
                        if viewModel.signUpSuccess {
                            isAuthenticated = true
                        }
                    } catch {
                        print("Sign up error: \(error)")
                    }
                }
            }) {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .buttonStyle(BlueButtonStyle())
            .padding(.top, 20) // Added top padding for spacing


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
        .gradientBackground()
        
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
            // Create an instance of SignInEmailViewModel with default values
            SignUpView(viewModel: SignInEmailViewModel(), showSignUpView: .constant(true), isAuthenticated: .constant(false))
        }
    }
}


