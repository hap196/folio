//
//  SignupView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/12/24.
//

import SwiftUI

struct StartingView: View {
    
    @Binding var showSignInView: Bool
    @ObservedObject var viewModel: SignInEmailViewModel

    
    var body: some View {
        VStack {
            NavigationLink {
                SurveyView(showSignInView: $showSignInView)
            } label: {
                
                Text("Get started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            
            }
            
            NavigationLink {
                //SignInEmailView(showSignInView: $showSignInView)
                SignInView(showSignInView: $showSignInView)
            } label: {
                
                Text("I already have an account")
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

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInEmailViewModel()

        NavigationStack {
            StartingView(showSignInView: .constant(false), viewModel: viewModel)
        }
        
    }
}
