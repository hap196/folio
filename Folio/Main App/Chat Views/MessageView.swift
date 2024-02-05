//
//  MessagesView.swift
//  Folio
//
//  Created by Hailey Pan on 1/31/24.
//

import SwiftUI

struct MessageView: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isSentByCurrentUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.customTurquoise)
                    .cornerRadius(15)
                    .foregroundColor(Color.white)
            } else {
                Text(message.text)
                    .padding()
                    .background(Color.customGray)
                    .cornerRadius(15)
                    .foregroundColor(Color.white)
                Spacer()
            }
        }
    }
}
