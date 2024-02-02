//
//  OpportunityView.swift
//  Folio
//
//  Created by Hailey Pan on 2/1/24.
//

import SwiftUI

struct OpportunityCard: View {
    var opportunity: Opportunity

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(opportunity.title)
                .font(.headline)
                .foregroundColor(.white)
            Text(opportunity.organization)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(opportunity.location)
                .font(.caption)
                .foregroundColor(.secondary)
            // Add more details as desired

        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
