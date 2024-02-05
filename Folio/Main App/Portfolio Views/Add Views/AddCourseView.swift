import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddCourseView: View {
    @State private var courseName: String = ""
    @State private var selectedCourseLevel: String = "Regular"
    @State private var selectedGrade: String = "A"
    let courseLevels = ["Regular", "Honors", "AP", "IB", "Dual Enrollment"]
    let grades = ["A", "B", "C", "D", "F", "P", "NP", "Other"]
    
    var selectedYear: String
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack(alignment: .leading) {
                    Divider()
                
                    Group {
                        Text("Course name")
                            .foregroundColor(.customGray)
                            .padding(.top)
                        
                        TextField("Ex. AP Chemistry", text: $courseName)
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
                                        Text("Course level")
                                            .foregroundColor(.customGray)
                                            .padding(.top)
                                        
                                        Picker("Course Level", selection: $selectedCourseLevel) {
                                            ForEach(courseLevels, id: \.self) { level in
                                                Text(level).foregroundColor(Color.white.opacity(0.7))
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .accentColor(Color.customTurquoise)
                                        .padding(.vertical, 4)
                                        .background(Color.clear)
                                        .cornerRadius(5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                        )
                                    }
                                    
                                    Group {
                                        Text("Grade")
                                            .foregroundColor(.customGray)
                                            .padding(.top)
                                        
                                        Picker("Grade", selection: $selectedGrade) {
                                                                                    ForEach(grades, id: \.self) { grade in
                                                                                        Text(grade).foregroundColor(Color.white.opacity(0.7))
                                                                                    }
                                                                                }
                                                                                .pickerStyle(MenuPickerStyle())
                                                                                .padding(.vertical, 4)
                                                                                .background(Color.clear)
                                                                                .accentColor(Color.customTurquoise)
                                                                                .cornerRadius(5)
                                                                                .overlay(
                                                                                    RoundedRectangle(cornerRadius: 5)
                                                                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                                                                )
                                                                            }
                    Spacer()
                    
                    Divider()
                    
                    Button(action: {
                        self.saveCourse()
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
        .navigationTitle("Add Course - " + selectedYear + " grade")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    private func saveCourse() {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            
            let newCourse = Course(name: courseName, level: selectedCourseLevel, grade: selectedGrade)
            let userDocRef = Firestore.firestore().collection("Users").document(userId)
            
            // Update the Firestore path to include the selected year
            userDocRef.collection(selectedYear).document("Courses").collection("Items").document(newCourse.id).setData(newCourse.dictionary) { error in
                if let error = error {
                    // Handle the error by showing an alert to the user
                    print("Error adding course: \(error.localizedDescription)")
                } else {
                    // The course was added successfully
                    // Perform any actions needed after saving, e.g., dismiss the view
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    
    

}
