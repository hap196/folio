//
//  SignupView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/12/24.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var showSignInView: Bool
    @ObservedObject var viewModel: SignInEmailViewModel

    
    var body: some View {
        VStack {
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                
                Text("Sign in with email ")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            
            }
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Sign in")
        .alert("Login Error", isPresented: Binding<Bool>.init(get: { viewModel.loginError != nil }, set: { _ in viewModel.loginError = nil })) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.loginError ?? "")
        }

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInEmailViewModel()

        NavigationStack {
            LoginView(showSignInView: .constant(false), viewModel: viewModel)
        }
        
    }
}
