import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack(spacing: 5) { // Added spacing between elements
            
            HStack {
                Text("Sign in")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)
                    .padding(.bottom, 10)
                    .shadow(color: .white, radius: 10, x: 5, y: 5) // Angled glowing shadow
                
                Spacer() // This pushes the Text to the left
            }
            .padding([.leading, .trailing]) // Add padding on the sides if needed

            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .foregroundColor(.white) // Made placeholder text more white
                .padding(.bottom, 8) // Added bottom padding for spacing

            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .foregroundColor(.white) // Made placeholder text more white
                .padding(.bottom, 20) // Added bottom padding for spacing

            Button(action: {
                Task {
                    do {
                        try await viewModel.signIn()
                        isAuthenticated = true  // Set isAuthenticated to true if signIn succeeds
                        print("Signed in successfully")
                    } catch {
                        print("Sign in error \(error)")
                    }
                }
            }) {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .buttonStyle(BlueButtonStyle())
            .padding(.bottom, 10) // Added bottom padding for spacing

            if viewModel.emailVerificationError {
                Text("Email not verified")
                    .foregroundColor(.red)
                    .padding(.bottom, 10) // Added bottom padding for spacing
            } else if let loginError = viewModel.loginError, !viewModel.emailVerificationError {
                Text(loginError)
                    .foregroundColor(.red)
                    .padding(.bottom, 10) // Added bottom padding for spacing
            }

            Spacer()
        }
        .navigationTitle("Sign in")
        .padding()
        .alert("Login Error", isPresented: Binding<Bool>(get: { viewModel.loginError != nil }, set: { _ in viewModel.loginError = nil })) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.loginError ?? "")
        }
        .background(LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .bottom, endPoint: .top))
        .edgesIgnoringSafeArea(.all)
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isAuthenticated: .constant(false))
    }
}
