//
//  FilteredOpportunitiesView.swift
//  Folio
//
//  Created by Hailey Pan on 2/1/24.
//

import SwiftUI

struct FilteredOpportunitiesView: View {
    var opportunities: [Opportunity]
    var categoryType: String

    var body: some View {
        List(filteredOpportunities) { opportunity in
            OpportunityCard(opportunity: opportunity)
        }
        .navigationBarTitle(Text(categoryType), displayMode: .inline)
        .onAppear {
            print("Showing opportunities for category: \(categoryType)")
            print("Filtered Opportunities Count: \(filteredOpportunities.count)")
        }
    }
    
    private var filteredOpportunities: [Opportunity] {
        opportunities.filter { $0.type.lowercased() == categoryType.lowercased() }
    }
}
