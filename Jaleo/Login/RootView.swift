//
//  RootView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/12/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    @StateObject private var signInViewModel = SignInEmailViewModel() // Add this line
    
    var body: some View {
        
        ZStack {
            NavigationStack {
                SettingsView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                LoginView(showSignInView: $showSignInView, viewModel: signInViewModel)
            }
        }
    }
    
}
    
struct RootView_previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
