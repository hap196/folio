import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0
    @Binding var isAuthenticated: Bool
    @State private var navigateToSettings = false

    var body: some View {
        VStack(spacing: 0) {
            // Content based on selected tab
            if selectedTab == 0 {
                // Actual content for Home
                    NavigationView {
                        
                        ZStack {
                            
                            ScrollView {
                                                VStack(spacing: 30) {
                                                    HomeHeaderView(navigateToSettings: $navigateToSettings, isAuthenticated: $isAuthenticated)
//                                                    GreetingView()
//                                                    UpcomingTasksView()
//                                                    Spacer()
//                                                    DeadlinesView()
//                                                    FeaturedOpportunitiesView()
                                                }
                                                
                                            }
                        }
                        
                    }
                
                
            } else if selectedTab == 1 {
                PortfolioView(isAuthenticated: $isAuthenticated)

            } else if selectedTab == 2 {
                ChatView(isAuthenticated: $isAuthenticated)
            } else if selectedTab == 3 {
                OpportunitiesView(isAuthenticated: $isAuthenticated)
            }

            Spacer()
            
            // Custom TabBar
            TabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HomeHeaderView: View {
    
    @Binding var navigateToSettings: Bool
    @Binding var isAuthenticated: Bool
    
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
            NavigationLink(
                            destination: SettingsView(isAuthenticated: $isAuthenticated),
                            isActive: $navigateToSettings
                        ) {
                EmptyView()
            }
        }
        .padding(.vertical)
    }
}

