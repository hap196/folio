//
//  SettingsView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/12/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func signOut() async throws {
        
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "test@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "1234567"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var isAuthenticated: Bool  // Changed from showSignInView
    
    var body: some View {
        
        List {
            Button("Logout") {
                Task {
                    do {
                        try viewModel.signOut()
                        isAuthenticated = false  // Update isAuthenticated on logout
                        
                    } catch {
                        print("Error signing out.")
                    }
                }
            }
            
            emailSection
            
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(isAuthenticated: .constant(true))
        }
    }
}

extension SettingsView {
    
    private var emailSection: some View {
        Section {
            
            Button("Reset Password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password reset!")
                        
                    } catch {
                        print("Error resetting password.")
                    }
                }
            }
            
            Button("Update Password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("Password updated!")
                        
                    } catch {
                        print("Error updating password.")
                    }
                }
            }
            
            Button("Update Email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("Email updated!")
                        
                    } catch {
                        print("Error updating email. There must be a recent sign in.")
                    }
                }
            }
            
        } header: {
                Text("Email functions")
        }
    }
    
}
