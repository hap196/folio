//
//  AddAwardView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/24/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddAwardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var awardName: String = ""
    @State private var yearReceived: String = ""
    @State private var description: String = ""
    
    var selectedYear: String

    var body: some View {
            ZStack {
                // Background and layout similar to AddCourseView
                // ...

                VStack {
                    TextField("Award Name", text: $awardName)
                        // Style the TextField
                        // ...

                    TextField("Year Received", text: $yearReceived)
                        // Style the TextField
                        // ...

                    TextField("Description (Optional)", text: $description)
                        // Style the TextField
                        // ...

                    Button("Save") {
                        saveAward()
                    }
                    // Style the Button
                    // ...
                }
                .padding()
            }
        }


    private func saveAward() {
            guard let userId = Auth.auth().currentUser?.uid else { return }

            let newAward = Award(name: awardName, yearReceived: yearReceived, description: description)
            let userDocRef = Firestore.firestore().collection("Users").document(userId)
            // Update the Firestore path to include the selected year
            userDocRef.collection(selectedYear).document("Awards").collection("Items").document(newAward.id).setData(newAward.dictionary) { error in
                if let error = error {
                    // Handle error
                    print("Error adding award: \(error.localizedDescription)")
                } else {
                    // Dismiss the view
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
}
