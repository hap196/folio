//
//  AddAwardView.swift
//  Folio
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
        NavigationView {
            ZStack {
                
                VStack(alignment: .leading) {
                    Divider()
                    
                    Group {
                        Text("Award Name")
                            .foregroundColor(.customGray)
                            .padding(.top)
                        
                        TextField("Ex. Science Fair 1st Place", text: $awardName)
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
                        
                        TextField("Ex. 2023", text: $yearReceived)
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
                        
                        TextField("Ex. Awarded for outstanding project on renewable energy", text: $description)
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
                        saveAward()
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
        .navigationTitle("Add Award - " + selectedYear + " grade")
        .navigationBarTitleDisplayMode(.inline)
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
