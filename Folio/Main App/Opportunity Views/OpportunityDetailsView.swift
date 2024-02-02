//
//  OpportunityDetailsView.swift
//  Folio
//
//  Created by Hailey Pan on 1/31/24.
//

import SwiftUI

struct OpportunityDetailsView: View {
    var opportunity: Opportunity

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(opportunity.title)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(opportunity.organization)
                    .font(.title3)
                    .foregroundColor(.secondary)

                Text(opportunity.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Divider()

                // Tab View for Description, Company, Review, etc.
                TabView {
                    Text(opportunity.description)
                        .tabItem {
                            Text("Description")
                        }
                    
                    Text("Company information here.") // Replace with actual company information
                        .tabItem {
                            Text("Company")
                        }
                    
                    Text("Reviews here.") // Replace with actual reviews
                        .tabItem {
                            Text("Review")
                        }
                }

                // Qualification Section
                VStack(alignment: .leading) {
                    Text("Qualifications")
                        .font(.headline)
                        .padding(.vertical, 5)

                    // List qualifications
                    ForEach(opportunity.eligibility?.components(separatedBy: ",") ?? [], id: \.self) { qualification in
                        Text("• \(qualification.trimmingCharacters(in: .whitespacesAndNewlines))")
                    }
                }

                // Apply Now Button
                Button(action: {
                    // Action for Apply Now
                }) {
                    Text("Apply Now")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationBarTitle(Text(opportunity.title), displayMode: .inline)
    }
}
