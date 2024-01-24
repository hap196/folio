import SwiftUI

struct StartingView: View {
    @Binding var isAuthenticated: Bool
    @StateObject private var viewModel = SignInEmailViewModel()
    @State private var showSurveyView = false
    @State private var showSignInView = false

    var body: some View {
        // Use ZStack to place the gradient background behind all content
        ZStack {
            // Apply the gradient to fill the entire background
            LinearGradient(gradient: Gradient(colors: [Color("000000"), Color("333333")]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all) // Ensure it covers the whole screen

            // Your main content
            VStack {
                Spacer() // This will push your buttons to the middle of the screen

                Button("Get started") {
                    showSurveyView = true
                }
                .sheet(isPresented: $showSurveyView) {
                    SurveyView(isAuthenticated: $isAuthenticated, showSignInView: $showSignInView)
                }

                Button("I already have an account") {
                    showSignInView = true
                }
                .sheet(isPresented: $showSignInView) {
                    SignInView(isAuthenticated: $isAuthenticated)
                }

                Spacer() // This will push your buttons to the middle of the screen
            }
            .padding()
            .alert("Login Error", isPresented: Binding<Bool>(get: { viewModel.loginError != nil }, set: { _ in viewModel.loginError = nil })) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.loginError ?? "")
            }
        }
        .navigationTitle("Sign in")
        .gradientBackground()
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView(isAuthenticated: .constant(false))
    }
}
