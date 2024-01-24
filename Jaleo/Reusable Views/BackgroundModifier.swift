//
//  BackgroundModifier.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/24/24.
//

import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .bottom, endPoint: .top))
            .edgesIgnoringSafeArea(.all)
    }
}

extension View {
    func gradientBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
}

