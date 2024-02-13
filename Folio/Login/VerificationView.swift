//
//  VerificationView.swift
//  Folio
//
//  Created by Hailey Pan on 2/9/24.
//

import SwiftUI

struct VerificationView: View {
    @ObservedObject var viewModel: SignInEmailViewModel
    @Binding var showVerificationView: Bool
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack(spacing:5) {
            Spacer()
            
            Image("verify_email")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
            
            Text("Check Your Email")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.customGray)
                .padding()

            Text("We sent a confirmation email to:")
                .fontWeight(.semibold)
                .foregroundColor(.customGray)

            Text(viewModel.email)
                .font(.callout)
                .foregroundColor(.customGray)
                .padding(.bottom)

            Spacer()
            
            Button(action: {
                Task {
                    await viewModel.checkEmailVerification()
                    if viewModel.isEmailVerified {
                        isAuthenticated = true
                        showVerificationView = false
                    } else {
                        viewModel.showVerificationAlert = true
                    }
                }
            }) {
                Text("I've verified my email")
                    .bold()
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .buttonStyle(BlueButtonStyle())

        
            
            Button("Resend Email") {
                Task {
                    await viewModel.sendVerificationMail()
                }
            }
            .padding(.bottom)
            .foregroundColor(.customTurquoise)
        }
        .alert("Email not verified", isPresented: $viewModel.showVerificationAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Please verify your email. Check your inbox for the verification link.")
        }
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(viewModel: SignInEmailViewModel(), showVerificationView: .constant(true), isAuthenticated: .constant(false))
    }
}
