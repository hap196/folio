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
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(opportunity.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.customGray)
                    
                    HStack {
//                        Image("placeholder")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .cornerRadius(8)

                        VStack(alignment: .leading) {

                            HStack {
                                Image(systemName: "location.fill")
                                Text(opportunity.location)
                                    .font(.subheadline)
                                    .foregroundColor(.customGray)
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
                        .foregroundColor(.customGray)

                    Text(opportunity.description)
                        .font(.body)
                        .foregroundColor(.gray)

                    Text("Eligibility")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)
                        .foregroundColor(.customGray)

                    ForEach(opportunity.eligibility?.components(separatedBy: ",") ?? [], id: \.self) { qualification in
                        Text("• \(qualification.trimmingCharacters(in: .whitespacesAndNewlines))")
                    }
                    .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding()
            }

            VStack {
                Spacer()

                Divider()

                HStack {
                    Button(action: {
                                self.showingSafariView = true
                            }) {
                                Text("Apply Now")
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(Color.customTurquoise)
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
        .navigationBarTitle(Text("Venture Details"), displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
    }
}
