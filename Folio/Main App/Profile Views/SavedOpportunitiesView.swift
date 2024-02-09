//
//  SavedOpportunitiesView.swift
//  Folio
//
//  Created by Hailey Pan on 2/8/24.
//

import SwiftUI

struct SavedOpportunitiesView: View {
    @StateObject var viewModel = SavedOpportunitiesViewModel()

    var body: some View {
        List(viewModel.savedOpportunities) { opportunity in
            NavigationLink(destination: OpportunityDetailsView(opportunity: opportunity)) {
                Text(opportunity.title)
            }
        }
        .onAppear {
            viewModel.fetchSavedOpportunities()
        }
        .navigationTitle("Saved Opportunities")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(PlainListStyle())
    }
}
