//
//  EditAwardsView.swift
//  Folio
//
//  Created by Hailey Pan on 1/31/24.
//

import SwiftUI

struct EditAwardView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var award: Award
    var onSave: (Award) -> Void

    var body: some View {
        VStack {
            TextField("Award Name", text: $award.name)
            TextField("Year Received", text: $award.yearReceived)
            TextField("Description", text: $award.description)
            
            Button("Save Changes") {
                onSave(award)
                presentationMode.wrappedValue.dismiss()
            }
            // Style the Button and TextFields later
        }
        .padding()
        // Additional styling or layout later
    }
}
