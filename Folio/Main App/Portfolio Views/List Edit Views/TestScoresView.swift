import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct TestScoresView: View {
    @ObservedObject var viewModel: PortfolioViewModel
    let selectedYear: String

    var body: some View {
        NavigationView {
            List(viewModel.testScores) { testScore in
                NavigationLink(destination: EditTestScoreView(testScore: testScore) { updatedTestScore in
                    saveTestScore(updatedTestScore)
                }) {
                    HStack {
                        Text(testScore.testName)
                        Spacer()
                        Image(systemName: "pencil")
                    }
                }
            }
            .navigationBarTitle("Test Scores")
            .onAppear(perform: loadTestScores)
        }
    }

    private func loadTestScores() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        viewModel.fetchTestScores(userId: userId, year: selectedYear)
    }

    private func saveTestScore(_ testScore: TestScore) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let userDocRef = Firestore.firestore().collection("Users").document(userId)
        userDocRef.collection(selectedYear).document("TestScores").collection("Items").document(testScore.id).setData(testScore.dictionary) { error in
            if let error = error {
                print("Error updating test score: \(error.localizedDescription)")
            } else {
                // Handle the successful update
            }
        }
    }
}
