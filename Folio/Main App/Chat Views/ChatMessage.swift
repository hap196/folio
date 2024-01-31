//
//  ChatMessage.swift
//  Folio
//
//  Created by Hailey Pan on 1/31/24.
//

import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isSentByCurrentUser: Bool // To differentiate between sent and received messages
}
