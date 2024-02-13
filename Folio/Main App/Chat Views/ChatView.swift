import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatView: View {
    @State private var navigateToSettings = false
    @Binding var isAuthenticated: Bool

    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = []
    let prompts: [(action: String, description: String)] = [
        ("Get ideas", "for impactful environmental projects"),
        ("Provide feedback", "on how to improve my portfolio"),
        ("Find extracurriculars", "focused on sustainability"),
        ("Recommend colleges", "with leading environmental programs")
    ]

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 10) {
                    ChatHeaderView(navigateToSettings: $navigateToSettings, isAuthenticated: $isAuthenticated)

                        if messages.isEmpty && messageText.isEmpty {
                                                promptAndLogoView
                                                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.24)))
                                            } else {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(messages, id: \.id) { message in
                                        MessageView(message: message)
                                    }
                                }
                            }
                            .padding()
                        }
                    
                    HStack {
                        TextField("Type a message", text: $messageText)
                            .padding(10)
                            .background(Color.clear)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                            .foregroundColor(.customGray)

                        Button(action: {
                            sendMessage()
                        }) {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.customTurquoise)
                        }
                        .disabled(messageText.isEmpty)
                        .padding(.horizontal)
                    }
                    .padding()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    private var promptAndLogoView: some View {
            VStack {
                Spacer()
                Image("folio_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(prompts, id: \.action) { prompt in
                            PromptButton(prompt: prompt, messageText: $messageText)
                        }
                    }
                    .padding(.horizontal)
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
    @Binding var navigateToSettings: Bool
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "message.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
                .foregroundColor(.customGray)
            Text("Chat")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.customGray)
            Spacer()

            Button(action: {
                navigateToSettings = true
            }) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .foregroundColor(Color.customGray)
            }
            .padding(.trailing, 20)
            NavigationLink(destination: SettingsView(isAuthenticated: $isAuthenticated), isActive: $navigateToSettings) {
                EmptyView()
            }
        }
        .padding(.vertical)
    }
}

struct PromptButton: View {
    let prompt: (action: String, description: String)
    @Binding var messageText: String

    var body: some View {
        Button(action: {
            messageText = "\(prompt.action) \(prompt.description)"
        }) {
            VStack(alignment: .leading) {
                Text(prompt.action)
                    .bold()
                    .foregroundColor(.customGray)
                Text(prompt.description)
                    .foregroundColor(.customGray)
                    .lineLimit(2)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}
