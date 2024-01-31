import SwiftUI

struct EditTestScoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var testScore: TestScore
    var onSave: (TestScore) -> Void

    var body: some View {
        VStack {
            TextField("Test Name", text: $testScore.testName)
            TextField("Score", text: $testScore.score)
            DatePicker("Date Taken", selection: $testScore.dateTaken, displayedComponents: .date)
            
            Button("Save Changes") {
                onSave(testScore)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}
