//
//  OpportunitiesView.swift
//  Jaleo
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
    @State private var searchText = ""
    @State private var isSearching = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    OpportunitiesHeaderView()

                    // Search Bar at the top
                    HStack {
                        TextField("Search...", text: $searchText)
                            .padding(7)
                            .padding(.leading, 30) // add padding to make room for the icon
                            .background(Color(.systemGray6).opacity(0.5)) // Semi-transparent background
                            .cornerRadius(10)
                            .foregroundColor(.white.opacity(0.7)) // Muted white text
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
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
                            .foregroundColor(.white)
                            .padding(.trailing, 10)
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
                                                // Search Results
                                                List(viewModel.opportunities.filter({ searchText.isEmpty ? true : $0.title.localizedCaseInsensitiveContains(searchText) })) { opportunity in
                                                    NavigationLink(destination: OpportunityDetailsView(opportunity: opportunity)) {
                                                        Text(opportunity.title)
                                                            .foregroundColor(.white.opacity(0.7)) // Muted white text
                                                    }
                                                    .listRowBackground(Color.black.opacity(0.3)) // Semi-transparent background for list rows
                                                }
                                                .listStyle(PlainListStyle())
                                            } else {
                                                // Browsing Page Content
                                                ScrollView {
                                                    VStack(alignment: .leading, spacing: 20) {
                                                        // Subheading "Start Browsing"
                                                        Text("Start Browsing")
                                                            .font(.system(size: 19, weight: .bold)) // Smaller font size
                                                            .foregroundColor(.white)
                                                            .padding(.top)

                                                        // 2x2 grid for "Start Browsing"
                                                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                                            CategoryButton(title: "Internships", color: Color.white.opacity(0.95), textColor: .black)
                                                            CategoryButton(title: "Competitions", color: Color.white.opacity(0.95), textColor: .black)
                                                            CategoryButton(title: "Volunteering", color: Color.white.opacity(0.95), textColor: .black)
                                                            CategoryButton(title: "Scholarships", color: Color.white.opacity(0.95), textColor: .black)
                                                        }
                                                        .padding(.bottom)

                                                        // Subheading "Picked for You"
                                                        Text("Picked for You")
                                                            .font(.system(size: 19, weight: .bold)) // Smaller font size
                                                            .foregroundColor(.white)
                                                            .padding(.top)

                                                        // Horizontal ScrollView for "Picked for You"
                                                        ScrollView(.horizontal, showsIndicators: false) {
                                                            HStack(spacing: 20) {
                                                                ForEach(viewModel.opportunities) { opportunity in
                                                                    NavigationLink(destination: OpportunityDetailsView(opportunity: opportunity)) {
                                                                        OpportunityCard(opportunity: opportunity)
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        .frame(height: 200) // Adjust based on content size
                                                    }
                                                    .padding(.horizontal)
                                                
                                                }
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
    let textColor: Color // Added text color parameter

    var body: some View {
        Button(action: {}) {
            Text(title)
                .bold()
                .foregroundColor(textColor) // Use the text color parameter
                .frame(width: 150, height: 80)
                .background(color)
                .cornerRadius(8)
        }
    }
}

struct OpportunitiesHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "doc.append")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
                .foregroundColor(.white)
            Text("Opportunities")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
    }
}
