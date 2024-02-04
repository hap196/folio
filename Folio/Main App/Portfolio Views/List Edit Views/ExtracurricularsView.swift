import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ExtracurricularsView: View {
    @ObservedObject var viewModel: PortfolioViewModel
    let selectedYear: String
    let title: String

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Divider()
                List(viewModel.extracurriculars) { extracurricular in
                    NavigationLink(destination: EditExtracurricularView(extracurricular: extracurricular, onSave: saveExtracurricular)) {
                        HStack {
                            Text(extracurricular.name)
                            Spacer()
                            Image(systemName: "pencil")
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .onAppear(perform: loadExtracurriculars)
        }
        .navigationBarTitle(title + " - " + selectedYear + " grade", displayMode: .inline)
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

    
