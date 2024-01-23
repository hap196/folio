import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            // Content based on selected tab
            if selectedTab == 0 {
                // Replace with actual content for Home
                Text("Home Content")
            } else if selectedTab == 1 {
                PortfolioView()
            } else if selectedTab == 2 {
                ChatView()
            } else if selectedTab == 3 {
                OpportunitiesView()
            }

            Spacer()
            
            // Custom TabBar
            TabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
