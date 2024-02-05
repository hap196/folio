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
                            
                            ScrollView {
                                                VStack(spacing: 30) {
                                                    HomeHeaderView()
                                                    GreetingView()
                                                    UpcomingTasksView()
                                                    Spacer()
                                                    DeadlinesView()
                                                    FeaturedOpportunitiesView()
                                                }
                                                
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
    }
}

struct HomeHeaderView: View {
    var body: some View {
        HStack {
             Image(systemName: "house.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
                .foregroundColor(.customGray)
            Text("Home")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.customGray)
            Spacer()
        }
        .padding()
    }
}

