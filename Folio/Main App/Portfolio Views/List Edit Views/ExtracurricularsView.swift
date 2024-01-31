//
//  ExtracurricularsView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/24/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ExtracurricularsView: View {
    @ObservedObject var viewModel: PortfolioViewModel
    let selectedYear: String

    var body: some View {
        NavigationView {
            List(viewModel.extracurriculars) { extracurricular in
                NavigationLink(destination: EditExtracurricularView(extracurricular: extracurricular) { updatedExtracurricular in
                    saveExtracurricular(updatedExtracurricular)
                }) {
                    HStack {
                        Text(extracurricular.name)
                        Spacer()
                        Image(systemName: "pencil")
                    }
                }
            }
            .navigationBarTitle("Extracurriculars")
            .onAppear(perform: loadExtracurriculars)
        }
    }

    private func loadExtracurriculars() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        viewModel.fetchExtracurriculars(userId: userId, year: selectedYear)
    }

    private func saveExtracurricular(_ extracurricular: Extracurricular) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let userDocRef = Firestore.firestore().collection("Users").document(userId)
        userDocRef.collection(selectedYear).document("Extracurriculars").collection("Items").document(extracurricular.id).setData(extracurricular.dictionary) { error in
            if let error = error {
                print("Error updating extracurricular: \(error.localizedDescription)")
            } else {
                
            }
        }
    }
}
    