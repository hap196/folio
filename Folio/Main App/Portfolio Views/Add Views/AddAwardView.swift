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
    
    var selectedYear: String // Passed from PortfolioView

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    Divider()
                    
                    Group {
                        Text("Award Name")
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        TextField("Ex. Science Fair 1st Place", text: $awardName)
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
                        Text("Year Received")
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        TextField("Ex. 2023", text: $yearReceived)
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
                        Text("Description (Optional)")
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        TextField("Ex. Awarded for outstanding project on renewable energy", text: $description)
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
                        saveAward()
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
        .navigationTitle("Add Award - " + selectedYear + "grade") // Setting the navigation title
        .navigationBarTitleDisplayMode(.inline) // Optional: For inline display of the title
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
