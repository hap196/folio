//
//  AddTestScoreView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/24/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddTestScoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var testName: String = ""
    @State private var score: String = ""
    @State private var dateTaken = Date()

    var selectedYear: String
    
    var body: some View {
            ZStack {

                VStack {
                    TextField("Test Name", text: $testName)

                    TextField("Score", text: $score)

                    DatePicker("Date Taken", selection: $dateTaken, displayedComponents: .date)

                    Button("Save") {
                        saveTestScore()
                    }
                }
                .padding()
            }
        }


    private func saveTestScore() {
            guard let userId = Auth.auth().currentUser?.uid else { return }

            let newTestScore = TestScore(testName: testName, score: score, dateTaken: dateTaken)
            let userDocRef = Firestore.firestore().collection("Users").document(userId)
            // Update the Firestore path to include the selected year
            userDocRef.collection(selectedYear).document("TestScores").collection("Items").document(newTestScore.id).setData(newTestScore.dictionary) { error in
                if let error = error {
                    // Handle error
                    print("Error adding test score: \(error.localizedDescription)")
                } else {
                    // Dismiss the view
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
}
