import SwiftUI

struct EditTestScoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var testScore: TestScore
    var onSave: (TestScore) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            
            Group {
                Text("Test Name")
                    .foregroundColor(.customGray)
                    .padding(.top)
                
                TextField("Ex. SAT, ACT", text: $testScore.testName)
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
                Text("Score")
                    .foregroundColor(.customGray)
                    .padding(.top)
                
                TextField("Ex. 1500, 34", text: $testScore.score)
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
                Text("Date Taken")
                    .foregroundColor(.customGray)
                    .padding(.top)
                
                DatePicker("Select Date", selection: $testScore.dateTaken, displayedComponents: .date)
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(5)
                    .accentColor(Color.customTurquoise)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .foregroundColor(Color.customGray)
            }
            
            Spacer()
            
            Divider()
            
            Button(action: {
                onSave(testScore)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save Changes")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.customTurquoise)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding(.horizontal)
        .navigationTitle("Edit Test Score")
        .navigationBarTitleDisplayMode(.inline)
    }
}
