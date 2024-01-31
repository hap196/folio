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

    var selectedYear: String // Passed from PortfolioView

    var body: some View {
        ZStack {

            VStack {
                TextField("Extracurricular Name", text: $extracurricularName)

                TextField("Description", text: $description)
                
                TextField("Years Participated (comma-separated)", text: $yearsParticipated)
                    
                Button("Save") {
                    saveExtracurricular()
                }
                
            }
            .padding()
        }
    }

    private func saveExtracurricular() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let yearsArray = yearsParticipated.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
        let newExtracurricular = Extracurricular(name: extracurricularName, description: description, yearsParticipated: yearsArray)

        let userDocRef = Firestore.firestore().collection("Users").document(userId)
        // Update the Firestore path to include the selected year
        userDocRef.collection(selectedYear).document("Extracurriculars").collection("Items").document(newExtracurricular.id).setData(newExtracurricular.dictionary) { error in
            if let error = error {
                // Handle error
                print("Error adding extracurricular: \(error.localizedDescription)")
            } else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
