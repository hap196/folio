import SwiftUI

struct ChatView: View {
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = []

    var body: some View {
        VStack {
            // Messages list
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(messages) { message in
                        MessageView(message: message)
                    }
                }
            }

            // Message input field
            HStack {
                TextField("Type a message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))

                Button("Send") {
                    sendMessage()
                }
                .disabled(messageText.isEmpty)
            }
            .padding()
        }
    }

    private func sendMessage() {
        let newMessage = ChatMessage(text: messageText, isSentByCurrentUser: true)
        messages.append(newMessage)
        messageText = ""

        // Here you would add the code to send the message to your server
        // and receive the response from the ChatGPT API
    }
}
