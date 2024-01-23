//
//  RootView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/12/24.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    @StateObject private var signInViewModel = SignInEmailViewModel()
    

    var body: some View {
        ZStack {
            if signInViewModel.isEmailVerified {
                // Show the main content of your app here
                SettingsView(showSignInView: $showSignInView)
            } else {
                // Show the login view
                StartingView(showSignInView: $showSignInView, viewModel: signInViewModel)
            }
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                StartingView(showSignInView: $showSignInView, viewModel: signInViewModel)
            }
        }
        .onAppear {
            Task {
                do {
                    let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
                    signInViewModel.isEmailVerified = authUser.isEmailVerified
                    self.showSignInView = !(authUser != nil && authUser.isEmailVerified)
                } catch {
                    self.showSignInView = true
                }
            }
        }

    }
}

struct RootView_previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

