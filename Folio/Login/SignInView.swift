import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack(spacing: 5) {
            
            HStack {
                Text("Enter your details")
                    .font(.headline)
                    .foregroundColor(.customGray)
                    .padding(.top)
                    .padding(.bottom, 10)
                    .shadow(color: .gray.opacity(0.25), radius: 10, x: 5, y: 5)
                    .frame(maxWidth: .infinity, alignment: .center)

                Spacer()
            }
            .padding([.leading, .trailing])

            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
                .foregroundColor(.customGray)
                .padding(.bottom, 8)

            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
                .foregroundColor(.customGray)
                .padding(.bottom, 20)

            Button(action: {
                Task {
                    do {
                        try await viewModel.signIn()
                        isAuthenticated = true
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
                    .cornerRadius(10)
            }
            .buttonStyle(BlueButtonStyle())
            .padding(.bottom, 10)

            if viewModel.emailVerificationError {
                Text("Email not verified")
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
            } else if let loginError = viewModel.loginError, !viewModel.emailVerificationError {
                Text(loginError)
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
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
//        .background(LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .bottom, endPoint: .top))
        .edgesIgnoringSafeArea(.all)
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isAuthenticated: .constant(false))
    }
}
