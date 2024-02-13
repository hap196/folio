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
        VStack(alignment: .leading) {
            Divider()

            Group {
                Text("Award Name")
                    .foregroundColor(.customGray)
                    .padding(.top)

                TextField("Ex. Science Fair 1st Place", text: $award.name)
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .foregroundColor(Color.customGray)
            }

            Group {
                Text("Year Received")
                    .foregroundColor(.customGray)
                    .padding(.top)

                TextField("Ex. 2023", text: $award.yearReceived)
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .foregroundColor(Color.customGray)
            }

            Group {
                Text("Description (Optional)")
                    .foregroundColor(.customGray)
                    .padding(.top)

                TextField("Ex. Awarded for outstanding project on renewable energy", text: $award.description)
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .foregroundColor(Color.customGray)
            }

            Spacer()

            Divider()

            Button(action: {
                onSave(award)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save Changes")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.customTurquoise)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding(.horizontal)
        .navigationTitle("Edit Award")
        .navigationBarTitleDisplayMode(.inline)
    }
}
