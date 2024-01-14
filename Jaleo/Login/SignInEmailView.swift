//
//  SignInEmailView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/12/24.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var signUpSuccess = false
    @Published var loginError: String?

    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
            
            signUpSuccess = true
        }
    
        let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }

        let returnedUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)

        guard returnedUserData.isEmailVerified else {
            loginError = "Your email address is not verified. Please check your email."
            return
        }
    }
    
}

struct SignInEmailView: View {
    
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
            
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    } catch {
                        print("Error")
                    }
                    
                    do {
                        try await viewModel.signIn  ()
                        showSignInView = false
                        return
                    } catch {
                        print("Error")
                    }
                }
                
            } label: {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
             
        }
        .navigationTitle("Sign in with email")
        .padding()
        .alert("Verification Email Sent", isPresented: $viewModel.signUpSuccess) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please check your email to verify your account.")
        }

        
    }
        
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignInEmailView(showSignInView: .constant(false))
    }
}
