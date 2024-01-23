import SwiftUI

struct StartingView: View {
    @Binding var isAuthenticated: Bool
    @StateObject private var viewModel = SignInEmailViewModel()
    @State private var showSurveyView = false
    @State private var showSignInView = false
    

    var body: some View {
        VStack {
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

            Spacer()
        }
        .padding()
        .navigationTitle("Sign in")
        .alert("Login Error", isPresented: Binding<Bool>(get: { viewModel.loginError != nil }, set: { _ in viewModel.loginError = nil })) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.loginError ?? "")
        }
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInEmailViewModel()
        StartingView(isAuthenticated: .constant(false))
    }
}
