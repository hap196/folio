//
//  TestScoresView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/24/24.
//

import SwiftUI

struct TestScoresView: View {
    var body: some View {
        HStack {
            // Back button
            Button(action: {
                // Pop the view off the navigation stack
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
            }
            Spacer()
            // Title in the center
            Text("Test scores")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
            // Spacer on the right to center the title
            Image(systemName: "arrow.left")
                .foregroundColor(.clear)
        }
        .padding()
    }
}
