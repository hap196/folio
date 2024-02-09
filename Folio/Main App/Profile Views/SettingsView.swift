//
//  SettingsView.swift
//  Folio
//
//  Created by Hailey Pan on 1/12/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
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
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        VStack {
            List {
                Button(action: {
                    Task {
                        do {
                            try viewModel.signOut()
                            isAuthenticated = false
                            print("signed out")
                        } catch {
                            print("Error signing out.")
                        }
                    }
                }) {
                    HStack {
                        Text("Logout")
                        Spacer()
                        Image(systemName: "pencil")
                    }
                }
                .foregroundColor(.customTurquoise)
                
                Button(action: {
                    Task {
                        do {
                            try await viewModel.resetPassword()
                        } catch {
                            print("Error resetting password.")
                        }
                    }
                }) {
                    HStack {
                        Text("Reset Password")
                        Spacer()
                        Image(systemName: "pencil")
                    }
                }
                .foregroundColor(.customTurquoise)
                
                Button(action: {
                    Task {
                        do {
                            try await viewModel.updatePassword()
                        } catch {
                            print("Error updating password.")
                        }
                    }
                }) {
                    HStack {
                        Text("Update Password")
                        Spacer()
                        Image(systemName: "pencil")
                    }
                }
                .foregroundColor(.customTurquoise)
                
                Button(action: {
                    Task {
                        do {
                            try await viewModel.updateEmail()
                        } catch {
                            print("Error updating email.")
                        }
                    }
                }) {
                    HStack {
                        Text("Update Email")
                        Spacer()
                        Image(systemName: "pencil")
                    }
                }
                .foregroundColor(.customTurquoise)
                
                NavigationLink(destination: SavedOpportunitiesView()) {
                    Text("Saved Opportunities")
                }
                .foregroundColor(.customTurquoise)
            }
            .listStyle(PlainListStyle())
            .background(.white)
        }
        .navigationTitle("Settings")
        .background(.white)
    }
}
