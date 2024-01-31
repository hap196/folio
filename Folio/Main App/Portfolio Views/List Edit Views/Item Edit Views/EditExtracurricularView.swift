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
        VStack {
            Text("HI")
            TextField("Extracurricular Name", text: $extracurricular.name)
            TextField("Description", text: $extracurricular.description)
            TextField("Role", text: $extracurricular.role)

            Button("Save Changes") {
                onSave(extracurricular)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}

