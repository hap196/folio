import SwiftUI

struct ChatView: View {
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = []

    var body: some View {
        NavigationView {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 10) {
                    
                    ChatHeaderView()
                    
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
            
        }
        
    }
        

    private func sendMessage() {
        let newMessage = ChatMessage(text: messageText, isSentByCurrentUser: true)
        messages.append(newMessage)
        messageText = ""

        // URL of Node.js server's /message endpoint
        guard let url = URL(string: "http://localhost:3000/message") else { return }

        // Create a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Create a dictionary with the user's message
        let messageDictionary: [String: String] = ["message": newMessage.text]

        // Convert the dictionary to JSON data
        if let jsonData = try? JSONSerialization.data(withJSONObject: messageDictionary, options: []) {
            request.httpBody = jsonData
        }

        // Create a URLSession task to send the message to the server
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, error == nil {
                do {
                    // Parse the JSON data
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
                       let serverMessage = jsonResponse["reply"] {
                        // Append the server's response to messages
                        DispatchQueue.main.async {
                            messages.append(ChatMessage(text: serverMessage, isSentByCurrentUser: false))
                        }
                    }
                } catch {
                    print("Error parsing the JSON response")
                }
            } else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        .resume()
    }

}

struct ChatHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "doc.append")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
                .foregroundColor(.white)
            Text("Chat")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
    }
}
