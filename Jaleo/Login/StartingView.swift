import SwiftUI

struct StartingView: View {
    @Binding var isAuthenticated: Bool
    @StateObject private var viewModel = SignInEmailViewModel()
    @State private var showSurveyView = false
    @State private var showSignInView = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("000000"), Color("333333")]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 2) { // Add spacing between VStack elements
                Spacer()
                Spacer()
                
                Image("placeholder_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                
                Text("Your AI College Advisor.")
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 10, x: 5, y: 5) // Angled glowing shadow
                    .padding()

                Spacer()
                Spacer()

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
                .padding(.bottom, 20) // Add padding below the first button

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

                Spacer()
            }
            .padding(.horizontal) // Apply horizontal padding to the entire VStack
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

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .shadow(color: .white.opacity(0.5), radius: 4, x: 5, y: 5) // Angled glowing shadow
    }
}

struct GrayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.gray)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .shadow(color: .white.opacity(0.5), radius: 4, x: 5, y: 5) // Angled glowing shadow
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView(isAuthenticated: .constant(false))
    }
}
