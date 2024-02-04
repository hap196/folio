//
//  OpportunityDetailsView.swift
//  Folio
//
//  Created by Hailey Pan on 1/31/24.
//

import SwiftUI

struct OpportunityDetailsView: View {
    var opportunity: Opportunity
    
    @State private var showingSafariView = false
    
    private var applyLink: URL? {
        URL(string: opportunity.link)
    }
    
    var body: some View {
        ZStack {
            // Main ScrollView Content
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(opportunity.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Image("placeholder") // Placeholder image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)

                        VStack(alignment: .leading) {

                            HStack {
                                Image(systemName: "location.fill") // Location icon
                                Text(opportunity.location)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            // Tags for type and level
                            HStack {
                                Text(opportunity.type)
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                                
                                Text(opportunity.level ?? "Unknown")
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
                        }
                    }

                    Divider()

                    Text("About this Opportunity")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)

                    Text(opportunity.description)
                        .font(.body)
                        .foregroundColor(.gray)

                    Text("Eligibility")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)

                    ForEach(opportunity.eligibility?.components(separatedBy: ",") ?? [], id: \.self) { qualification in
                        Text("• \(qualification.trimmingCharacters(in: .whitespacesAndNewlines))")
                    }
                    
                    Spacer() // This will push all the content to the top
                }
                .padding()
            }

            // Apply Now Button at the Bottom
            VStack {
                Spacer() // Pushes the button to the bottom

                Divider()

                HStack {
                    Button(action: {
                                self.showingSafariView = true
                            }) {
                                Text("Apply Now")
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding()
                            .sheet(isPresented: $showingSafariView) {
                                if let applyLink = applyLink {
                                    SafariView(url: applyLink)
                                }
                            }

                    Button(action: {
                        // Action for Save
                    }) {
                        Image(systemName: "bookmark")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    .padding(.trailing)
                }
            }
        }
        .navigationBarTitle(Text("Opportunity Details"), displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom) // Ensures the button is aligned at the very bottom
    }
}
