//
//  VerificationView.swift
//  Folio
//
//  Created by Hailey Pan on 2/9/24.
//

import SwiftUI

struct VerificationView: View {
    @ObservedObject var viewModel: SignInEmailViewModel
    @Binding var isAuthenticated: Bool
    @State private var verificationMessage: String? = nil


    var body: some View {
        VStack {
            Text("Please verify your email")

//            Button("Check Email Verification") {
//                            viewModel.checkEmailVerified { verified in
//                                if verified {
//                                    isAuthenticated = true
//                                } else {
//                                    verificationMessage = "You have not verified your email yet."
//                                }
//                            }
//                        }
//
//                        if let message = verificationMessage {
//                            Text(message)
//                                .foregroundColor(.red)
//                                .padding()
//                        }
                    
        }
    }
}
