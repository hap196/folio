import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.45))

            HStack {
                // Tab 1: Home
                Button(action: { selectedTab = 0 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "house.fill")
                        Text("Home")
                            .font(.caption)
                    }
                }
                .foregroundColor(selectedTab == 0 ? .customTurquoise : .gray.opacity(0.45))

                Spacer()

                // Tab 2: Portfolio
                Button(action: { selectedTab = 1 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "folder.fill")
                        Text("Portfolio")
                            .font(.caption)
                    }
                }
                .foregroundColor(selectedTab == 1 ? .customTurquoise : .gray.opacity(0.45))

                Spacer()

                // Tab 3: Chat
                Button(action: { selectedTab = 2 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "message.fill")
                        Text("Chat")
                            .font(.caption)
                    }
                }
                .foregroundColor(selectedTab == 2 ? .customTurquoise : .gray.opacity(0.45))

                Spacer()

                // Tab 4: Opportunities
                Button(action: { selectedTab = 3 }) {
                    VStack(spacing: 4) {
                        Image(systemName: "star.fill")
                        Text("Ventures")
                            .font(.caption)
                    }
                }
                .foregroundColor(selectedTab == 3 ? .customTurquoise : .gray.opacity(0.45))
            }
            .padding(.vertical, 20)
            .padding(.horizontal)
            .padding(.bottom)
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .padding(.horizontal)
        }
        .background(Color.clear)
        .cornerRadius(10)
    }
}
