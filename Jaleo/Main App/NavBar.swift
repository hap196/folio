import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            // Tab 1
            Button(action: { selectedTab = 0 }) {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            }.foregroundColor(selectedTab == 0 ? .blue : .gray)

            // Tab 2
            Button(action: { selectedTab = 1 }) {
                VStack {
                    Image(systemName: "folder.fill")
                    Text("Portfolio")
                }
            }.foregroundColor(selectedTab == 1 ? .blue : .gray)

            // Tab 3
            Button(action: { selectedTab = 2 }) {
                VStack {
                    Image(systemName: "message.fill")
                    Text("Chat")
                }
            }.foregroundColor(selectedTab == 2 ? .blue : .gray)

            // Tab 4
            Button(action: { selectedTab = 3 }) {
                VStack {
                    Image(systemName: "star.fill")
                    Text("Ventures")
                }
            }.foregroundColor(selectedTab == 3 ? .blue : .gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
