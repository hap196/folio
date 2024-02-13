//
//  EditExtracurricularsView.swift
//  Folio
//
//  Created by Hailey Pan on 1/31/24.
//

import SwiftUI

struct EditExtracurricularView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var extracurricular: Extracurricular
    var onSave: (Extracurricular) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Divider()

            Group {
                Text("Extracurricular Name")
                    .foregroundColor(.customGray)
                    .padding(.top)

                TextField("Ex. Chess Club", text: $extracurricular.name)
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
                Text("Description")
                    .foregroundColor(.customGray)
                    .padding(.top)

                TextField("Ex. President, led weekly meetings...", text: $extracurricular.description)
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
                Text("Role")
                    .foregroundColor(.customGray)
                    .padding(.top)

                TextField("Ex. Team Captain", text: $extracurricular.role)
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
                onSave(extracurricular)
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
        .navigationTitle("Edit Extracurricular")
        .navigationBarTitleDisplayMode(.inline)
    }
}
