//
//  AuthenticationManager.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/12/24.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    
    struct AuthDataResultModel {
        let uid: String
        let email: String?
        let photoUrl: String?
        let isEmailVerified: Bool

        init(user: User) {
            self.uid = user.uid
            self.email = user.email
            self.photoUrl = user.photoURL?.absoluteString
            self.isEmailVerified = user.isEmailVerified
        }
    }

    
    static let shared = AuthenticationManager()
    private init() {}
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        // Send verification email
        try await authDataResult.user.sendEmailVerification()
        
        return AuthDataResultModel(user: authDataResult.user)
    }

    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        
        // Check if email is verified
        guard authDataResult.user.isEmailVerified else {
            // You can throw a custom error or handle it as per your application's flow
            throw NSError(domain: "AuthError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Please verify your email address."])
        }
        
        return AuthDataResultModel(user: authDataResult.user)
    }

    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: password)
        
    }
    
    func updateEmail(email: String) async throws {
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updateEmail(to: email)
        
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
