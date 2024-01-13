//
//  SignupView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/12/24.
//

import SwiftUI

struct SignupView: View {
    var body: some View {
        VStack {
            NavigationLink {
                Text("Hello")
            } label: {
                
                Text("Sign in with email ")
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .frame(height:55)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            
            }
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Sign in")
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignupView()
        }
        
    }
}
