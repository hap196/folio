//
//  SignupView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/12/24.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var showSignInView: Bool
    
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
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView(showSignInView: .constant(false))
        }
        
    }
}
