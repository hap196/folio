//
//  AddExtracurricularView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/24/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth


struct AddExtracurricularView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var extracurricularName: String = ""
    @State private var description: String = ""
    @State private var yearsParticipated: String = ""

    var body: some View {
            ZStack {
                // Background and layout similar to AddCourseView
                // ...

                VStack {
                    TextField("Extracurricular Name", text: $extracurricularName)
                        // Style the TextField
                        // ...

                    TextField("Description", text: $description)
                        // Style the TextField
                        // ...

                    TextField("Years Participated (comma-separated)", text: $yearsParticipated)
                        // Style the TextField
                        // ...

                    Button("Save") {
                        saveExtracurricular()
                    }
                    // Style the Button
                    // ...
                }
                .padding()
            }
        }

    private func saveExtracurricular() {
            guard let userId = Auth.auth().currentUser?.uid else { return }

            let yearsArray = yearsParticipated.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            let newExtracurricular = Extracurricular(name: extracurricularName, description: description, yearsParticipated: yearsArray)

            let userDocRef = Firestore.firestore().collection("Users").document(userId)
            userDocRef.collection("Extracurriculars").document(newExtracurricular.id).setData(newExtracurricular.dictionary) { error in
                if let error = error {
                    // Handle error
                    print("Error adding extracurricular: \(error.localizedDescription)")
                } else {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
}

