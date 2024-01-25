//
//  SignInEmailViewModel.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/22/24.
//

// SignInEmailViewModel.swift

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

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

    // Add properties for grade, school, and major
    var grade: String = ""
    var school: String = ""
    var major: String = ""
    
    // Add an initializer
        init(grade: String = "", school: String = "", major: String = "") {
            self.grade = grade
            self.school = school
            self.major = major
        }
    
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
        
        // After successful sign-up, store additional user info
        if signUpSuccess {
            await storeUserInfo()
        }

    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }

        do {
            let returnedUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)

            // If the signInUser method succeeds, the user is authenticated.
            // You can still inform the user if their email is not verified.
            isEmailVerified = returnedUserData.isEmailVerified
            if !returnedUserData.isEmailVerified {
                loginError = "Your email address is not verified. Please check your email."
                emailVerificationError = true
            }
        } catch let error as NSError {
            // Handle specific or general errors
            loginError = error.localizedDescription
            emailVerificationError = false
        }
    }
    
    private func storeUserInfo() async {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            let db = Firestore.firestore()

            let userInfo = ["grade": grade, "school": school, "major": major]
            do {
                try await db.collection("Users").document(userId).setData(userInfo)
                print("User info stored successfully")
            } catch {
                print("Error storing user info: \(error)")
            }
        }

}
