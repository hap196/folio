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

    var selectedYear: String

    var body: some View {
        NavigationView {
            ZStack {
                
                VStack(alignment: .leading) {
                    Divider()
                    
                    Group {
                        Text("Extracurricular Name")
                            .foregroundColor(.customGray)
                            .padding(.top)
                        
                        TextField("Ex. Chess Club", text: $extracurricularName)
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
                        Text("Description")
                            .foregroundColor(.customGray)
                            .padding(.top)
                        
                        TextField("Ex. President, led weekly meetings...", text: $description)
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
                        Text("Years Participated (comma-separated)")
                            .foregroundColor(.customGray)
                            .padding(.top)
                        
                        TextField("Ex. 2020, 2021, 2022", text: $yearsParticipated)
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
                        saveExtracurricular()
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
        .navigationTitle("Add Extracurricular - " + selectedYear + " grade")
        .navigationBarTitleDisplayMode(.inline)
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
