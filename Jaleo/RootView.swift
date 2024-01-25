import SwiftUI

struct RootView: View {
    @State private var isAuthenticated = false
    @StateObject private var signInViewModel = SignInEmailViewModel()

    var body: some View {
        Group {  // Use Group to ensure correct context for modifiers
            if isAuthenticated || signInViewModel.isEmailVerified {
//                SettingsView(isAuthenticated: $isAuthenticated)
                HomeView()
            } else {
                StartingView(isAuthenticated: $isAuthenticated)
            }
        }
        .onAppear {
            Task {
                do {
                    let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
                    signInViewModel.isEmailVerified = authUser.isEmailVerified
                    isAuthenticated = authUser != nil && authUser.isEmailVerified
                } catch {
                    isAuthenticated = false
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
