import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)

            HStack {
                // Tab 1: Home
                Button(action: { selectedTab = 0 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }
                .foregroundColor(selectedTab == 0 ? .blue : Color.lightGray)

                Spacer()

                // Tab 2: Portfolio
                Button(action: { selectedTab = 1 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "folder.fill")
                        Text("Portfolio")
                    }
                }
                .foregroundColor(selectedTab == 1 ? .blue : Color.lightGray)

                Spacer()

                // Tab 3: Chat
                Button(action: { selectedTab = 2 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "message.fill")
                        Text("Chat")
                    }
                }
                .foregroundColor(selectedTab == 2 ? .blue : Color.lightGray)

                Spacer()

                // Tab 4: Ventures
                Button(action: { selectedTab = 3 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "star.fill")
                        Text("Ventures")
                    }
                }
                .foregroundColor(selectedTab == 3 ? .blue : Color.lightGray)
            }
            .padding(.vertical, 20) // Adjusted for taller tab bar
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .padding(.horizontal)
        }
        .background(Color.clear)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// Light gray color extension
extension Color {
    static let lightGray = Color(red: 200 / 255, green: 200 / 255, blue: 200 / 255)
}
