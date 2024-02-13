import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AwardsView: View {
    @ObservedObject var viewModel: PortfolioViewModel
    let selectedYear: String
    let title: String

    var body: some View {
            VStack(spacing: 0) {
                Divider()
                List(viewModel.awards) { award in
                    NavigationLink(destination: EditAwardView(award: award, onSave: saveAward)) {
                        HStack {
                            Text(award.name)
                            Spacer()
                            Image(systemName: "pencil")
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .onAppear(perform: loadAwards)
        .navigationBarTitle(title + " - " + selectedYear + " grade", displayMode: .inline)
    }

    private func loadAwards() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        viewModel.fetchAwards(userId: userId, year: selectedYear)
    }

    private func saveAward(_ award: Award) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let userDocRef = Firestore.firestore().collection("Users").document(userId)
        userDocRef.collection(selectedYear).document("Awards").collection("Items").document(award.id).setData(award.dictionary) { error in
            if let error = error {
                print("Error updating award: \(error.localizedDescription)")
            } else {
                
            }
        }
    }
}


