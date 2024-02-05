//
//  AddTestScoreView.swift
//  Folio
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
        NavigationView {
            ZStack {
                
                VStack(alignment: .leading) {
                    Divider()
                    
                    Group {
                        Text("Test Name")
                            .foregroundColor(.customGray)
                            .padding(.top)
                        
                        TextField("Ex. SAT, ACT", text: $testName)
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
                        Text("Score")
                            .foregroundColor(.customGray)
                            .padding(.top)
                        
                        TextField("Ex. 1500, 34", text: $score)
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
                        Text("Date Taken")
                            .foregroundColor(.customGray)
                            .padding(.top)
                        
                        DatePicker("Select Date", selection: $dateTaken, displayedComponents: .date)
                            .padding()
                            .background(Color.clear)
                            .cornerRadius(5)
                            .accentColor(Color.customTurquoise)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .foregroundColor(Color.customGray)
                    }
                    
                    Spacer()
                    
                    Divider()
                    
                    Button(action: {
                        saveTestScore()
                    }) {
                        Text("Save")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(Color.customTurquoise)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Add Test Score - " + selectedYear + " grade")
        .navigationBarTitleDisplayMode(.inline)
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
