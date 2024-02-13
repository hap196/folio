//
//  SignInEmailViewModel.swift
//  Folio
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
    

    var grade: String = ""
    var school: String = ""
    var major: String = ""
    
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
        emailVerificationError = false // Reset the email verification error state
        loginError = nil // Reset the login error

        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }

        do {
            let returnedUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
            isEmailVerified = returnedUserData.isEmailVerified
            if !isEmailVerified {
                // Email is not verified
                emailVerificationError = true
                return // Return early to avoid checking other errors
            }
        } catch let error as NSError {

                loginError = error.localizedDescription
            
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
    
    func sendVerificationMail() async {
        guard let user = Auth.auth().currentUser, !user.isEmailVerified else { return }
        
        do {
            try await user.sendEmailVerification()
            DispatchQueue.main.async {
                // Handle the confirmation of email sent
                self.verificationEmailSent = true
            }
        } catch {
            DispatchQueue.main.async {
                // Handle the error case
                self.loginError = "Unable to send verification email: \(error.localizedDescription)"
            }
        }
    }

    func checkEmailVerification() async {
        guard let user = Auth.auth().currentUser else { return }
        
        do {
            try await user.reload()
            DispatchQueue.main.async {
                self.isEmailVerified = user.isEmailVerified
            }
        } catch {
            DispatchQueue.main.async {
                // Handle the error, maybe set an error message to show to the user
                self.loginError = "Error reloading user: \(error.localizedDescription)"
            }
        }
    }

}
