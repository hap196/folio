//
//  AddExtracurricularView.swift
//  Folio
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
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    Divider()
                    
                    Group {
                        Text("Extracurricular Name")
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        TextField("Ex. Chess Club", text: $extracurricularName)
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
                        Text("Description")
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        TextField("Ex. President, led weekly meetings...", text: $description)
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
                        Text("Years Participated (comma-separated)")
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        TextField("Ex. 2020, 2021, 2022", text: $yearsParticipated)
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
                        saveExtracurricular()
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
        .navigationTitle("Add Extracurricular - " + selectedYear + "grade") // Setting the navigation title
        .navigationBarTitleDisplayMode(.inline) // Optional: For inline display of the title
    }

    private func saveExtracurricular() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let yearsArray = yearsParticipated.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
        let newExtracurricular = Extracurricular(name: extracurricularName, description: description, yearsParticipated: yearsArray)

        let userDocRef = Firestore.firestore().collection("Users").document(userId)
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
