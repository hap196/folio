//
//  SignInEmailViewModel.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/22/24.
//

// SignInEmailViewModel.swift

import SwiftUI

// Handles both sign in and sign up
@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var signUpSuccess = false
    @Published var loginError: String?
    @Published var verificationEmailSent = false
    @Published var isEmailVerified = false
    @Published var showVerificationAlert = false
    @Published var emailVerificationError = false
    @Published var weakPasswordError = false
    @Published var invalidEmailError = false

    func signUp() async throws {
        // Reset error states
        weakPasswordError = false
        invalidEmailError = false

        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }

        do {
            let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
            // Handle success
            signUpSuccess = true
            verificationEmailSent = true
            showVerificationAlert = true
        } catch let error as NSError {
            if error.domain == "FIRAuthErrorDomain" {
                switch error.code {
                case 17026:
                    // Weak password error
                    weakPasswordError = true
                case 17008:
                    // Invalid email error
                    invalidEmailError = true
                default:
                    // Handle other errors
                    loginError = error.localizedDescription
                }
            }
        }
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }

        do {
                let returnedUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)

                guard returnedUserData.isEmailVerified else {
                    loginError = "Your email address is not verified. Please check your email."
                    emailVerificationError = true
                    return
                }
                // Additional code for successful sign in
            } catch let error as NSError {
                if error.domain == "AuthError" && error.code == 1001 {
                    loginError = "Please verify your email address."
                    emailVerificationError = true
                } else {
                    loginError = "Account doesn't exist."
                    emailVerificationError = false
                }
            }
            
    }
    
    

}
