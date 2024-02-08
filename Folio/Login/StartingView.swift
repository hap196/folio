import SwiftUI

struct StartingView: View {
    @Binding var isAuthenticated: Bool
    @StateObject private var viewModel = SignInEmailViewModel()
    @State private var showSurveyView = false
    @State private var showSignInView = false

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Image("folio_logo") // Ensure the image name matches with your assets.
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 200)

                Text("Your AI College Advisor.")
                    .foregroundColor(.customGray)
                    .shadow(color: .black, radius: 10, x: 5, y: 5)
                    .padding()

                Spacer()
                
                VStack(spacing: 20) {
                    Button(action: {
                        showSurveyView = true
                    }) {
                        Text("Get started")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .sheet(isPresented: $showSurveyView) {
                        SurveyView(isAuthenticated: $isAuthenticated, showSignInView: $showSignInView)
                    }
                    .buttonStyle(BlueButtonStyle())

                    Button(action: {
                        showSignInView = true
                    }) {
                        Text("I already have an account")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .sheet(isPresented: $showSignInView) {
                        SignInView(isAuthenticated: $isAuthenticated)
                    }
                    .buttonStyle(GrayButtonStyle())
                }
                .padding(.horizontal)
            }
            .padding(.bottom) // Apply padding to the bottom of the outer VStack
            .alert("Login Error", isPresented: Binding<Bool>(get: { viewModel.loginError != nil }, set: { _ in viewModel.loginError = nil })) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.loginError ?? "")
            }
        }
        .navigationTitle("Sign in")
    }
}

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.customTurquoise)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .shadow(color: .customTurquoise.opacity(0.5), radius: 4, x: 5, y: 5)
    }
}

struct GrayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.customTurquoise)
            .padding()
            .background(Color.gray.opacity(0.15))
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .shadow(color: .black.opacity(0.20), radius: 4, x: 5, y: 5) // Angled glowing shadow
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView(isAuthenticated: .constant(false))
    }
}


