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

    var selectedYear: String // Passed from PortfolioView

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading) {
                    Divider()

                    Group {
                        Text("Test Name")
                            .foregroundColor(.white)
                            .padding(.top)

                        TextField("Ex. SAT, ACT", text: $testName)
                            .padding()
                            .background(Color.clear)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .foregroundColor(Color.white.opacity(0.9))
                    }

                    Group {
                        Text("Score")
                            .foregroundColor(.white)
                            .padding(.top)

                        TextField("Ex. 1500, 34", text: $score)
                            .padding()
                            .background(Color.clear)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .foregroundColor(Color.white.opacity(0.9))
                    }

                    Group {
                        Text("Date Taken")
                            .foregroundColor(.white)
                            .padding(.top)

                        DatePicker("Select Date", selection: $dateTaken, displayedComponents: .date)
                            .padding()
                            .background(Color.clear)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .foregroundColor(Color.white.opacity(0.9))
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
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding(.horizontal) // Apply horizontal padding to the entire VStack
            }
        }
        .navigationTitle("Add Test Score - " + selectedYear + "grade") // Setting the navigation title
        .navigationBarTitleDisplayMode(.inline) // Optional: For inline display of the title
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
