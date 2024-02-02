import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            // Content based on selected tab
            if selectedTab == 0 {
                // Actual content for Home
                    NavigationView {
                        
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom)
                                .edgesIgnoringSafeArea(.all)
                            
                            VStack(spacing: 10) {
                                HomeHeaderView()
                                Spacer()
                            }
                        }
                        
                    }
                
                
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
        .gradientBackground()
    }
}

struct HomeHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "doc.append")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
                .foregroundColor(.white)
            Text("Home")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
    }
}

