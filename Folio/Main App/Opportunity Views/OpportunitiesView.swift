//
//  OpportunitiesView.swift
//  Folio
//
//  Created by Hailey Pan on 1/23/24.
//
// Button to trigger the upload
//            ONLY UNCOMMENT THIS IF YOU WANT TO ADD TO THE OPPORTUNITIES DATABASE
//            Button("Upload Data") {
//                viewModel.uploadDataToFirestore()
//                isUploaded = true
//            }
//            .disabled(isUploaded)

import SwiftUI

struct OpportunitiesView: View {
    @ObservedObject var viewModel = OpportunitiesViewModel()
    @State private var navigateToSettings = false
    @Binding var isAuthenticated: Bool
    
    @State private var searchText = ""
    @State private var isSearching = false

    @State private var randomOpportunities = [Opportunity]()
    
    var body: some View {
        NavigationView {
            ZStack {

                VStack {
                    OpportunitiesHeaderView(navigateToSettings: $navigateToSettings, isAuthenticated: $isAuthenticated)

                    // Search Bar at the top
                    HStack {
                        TextField("Search...", text: $searchText)
                            .padding(7)
                            .padding(.leading, 30)
                            .background(Color(.gray).opacity(0.25))
                            .cornerRadius(10)
                            .foregroundColor(.customGray)
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.customGray)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 8)
                                }
                            )
                            .padding(.horizontal)
                            .onTapGesture {
                                self.isSearching = true
                            }
                        
                        if isSearching {
                            Button("Cancel") {
                                self.isSearching = false
                                self.searchText = ""
                                // Dismiss the keyboard
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                            .foregroundColor(.customTurquoise)
                            .padding(.trailing, 20)
                            .transition(.move(edge: .trailing))
                            .animation(.default)
                        }
                    }
                    .onTapGesture {
                        self.isSearching = true
                    }
                    
                    // Content
                                        ZStack {
                                            if isSearching {
                                                if !searchText.isEmpty {
                                                            List(viewModel.opportunities.filter({ $0.title.localizedCaseInsensitiveContains(searchText) })) { opportunity in
                                                                NavigationLink(destination: OpportunityDetailsView(opportunity: opportunity)) {
                                                                    Text(opportunity.title)
                                                                        .foregroundColor(.customTurquoise) // Assuming custom color definition exists
                                                                }
                                                                .listRowBackground(Color.clear)
                                                            }
                                                            .listStyle(PlainListStyle())
                                                        }
                                            } else {
                                                ScrollView {
                                                    VStack(alignment: .leading, spacing: 20) {
                                                        Text("Start Browsing")
                                                            .font(.system(size: 19, weight: .bold))
                                                            .foregroundColor(.customGray)
                                                            .padding(.top)

                                                        // 2x2 grid for "Start Browsing"
                                                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                                                            CategoryButton(title: "Internships", color: Color.customTurquoise.opacity(0.95), textColor: .white, viewModel: viewModel)
                                                            CategoryButton(title: "Competitions", color: Color.customTurquoise.opacity(0.95), textColor: .white, viewModel: viewModel)
                                                            CategoryButton(title: "Volunteering", color: Color.customTurquoise.opacity(0.95), textColor: .white, viewModel: viewModel)
                                                            CategoryButton(title: "Scholarships", color: Color.customTurquoise.opacity(0.95), textColor: .white, viewModel: viewModel)
                                                        }
                                                        .padding(.bottom)

                                                        
                                                        Text("Picked for You")
                                                            .font(.system(size: 19, weight: .bold))
                                                            .foregroundColor(.customGray)
                                                            .padding(.top)
                                                            .padding(.leading, 5)
                                                            .padding(.bottom)

                                                        
                                                        ScrollView(.horizontal, showsIndicators: false) {
                                                            HStack(spacing: 5) {
                                                                ForEach(0..<6, id: \.self) { _ in
                                                                    if let opportunity = viewModel.getRandomOpportunity() {
                                                                        NavigationLink(destination: OpportunityDetailsView(opportunity: opportunity)) {
                                                                            OpportunityCard(opportunity: opportunity)
                                                                        }
                                                                    }
                                                                }
                                                                .padding(.trailing, 10)
                                                                
                                                            }
                                                            
                                                        }
                                                        .frame(height: 200)
                                                        
                                                        
                                                        Text("New Postings")
                                                            .font(.system(size: 19, weight: .bold))
                                                            .foregroundColor(.customGray)
                                                            .padding(.top)
                                                            .padding(.leading, 5)
                                                            .padding(.bottom)

                                                        ScrollView(.horizontal, showsIndicators: false) {
                                                            HStack(spacing: 5) {
                                                                ForEach(0..<6, id: \.self) { _ in
                                                                    if let opportunity = viewModel.getRandomOpportunity() {
                                                                        NavigationLink(destination: OpportunityDetailsView(opportunity: opportunity)) {
                                                                            OpportunityCard(opportunity: opportunity)
                                                                        }
                                                                    }
                                                                }
                                                                .padding(.trailing, 10)
                                                                
                                                            }
                                                            
                                                        }
                                                        .frame(height: 200)
                                                        
                                                        Text("New Postings")
                                                            .font(.system(size: 19, weight: .bold))
                                                            .foregroundColor(.customGray)
                                                            .padding(.top)
                                                            .padding(.leading, 5)
                                                            .padding(.bottom)

                                                        ScrollView(.horizontal, showsIndicators: false) {
                                                            HStack(spacing: 5) {
                                                                ForEach(0..<6, id: \.self) { _ in
                                                                    if let opportunity = viewModel.getRandomOpportunity() {
                                                                        NavigationLink(destination: OpportunityDetailsView(opportunity: opportunity)) {
                                                                            OpportunityCard(opportunity: opportunity)
                                                                        }
                                                                    }
                                                                }
                                                                .padding(.trailing, 10)
                                                                
                                                            }
                                                            
                                                        }
                                                        .frame(height: 200)
                                                        
                                                    }
                                                    .padding(.vertical, 15)
                                                    .padding(.trailing, 20)
                                                }
                                                .padding(.leading, 20)
                                            }
                                        }

                                        Spacer()
                                    }
                                }
                                .navigationBarHidden(true)
                            }
                        }
                    }

struct CategoryButton: View {
    let title: String
    let color: Color
    let textColor: Color
    @ObservedObject var viewModel: OpportunitiesViewModel

    var body: some View {
        NavigationLink(destination: FilteredOpportunitiesView(opportunities: viewModel.opportunities, categoryType: title)) {
            Text(title)
                .bold()
                .foregroundColor(textColor)
                .frame(width: 150, height: 80)
                .background(color)
                .cornerRadius(8)
        }
    }
}


struct OpportunitiesHeaderView: View {
    
    @Binding var navigateToSettings: Bool
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
                .foregroundColor(.customGray)
            Text("Ventures")
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
