//
//  CoursesView.swift
//  Folio
//
//  Created by Hailey Pan on 1/24/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct CoursesView: View {
    @ObservedObject var viewModel: PortfolioViewModel
    let selectedYear: String
    let title: String
    
    @State private var selectedCourse: Course?
    @State private var isEditingCourse = false
    
    var body: some View {
            VStack(spacing:0) {
                Divider()
                
                List(viewModel.courses) { course in
                    NavigationLink(destination: EditCourseView(course: course, onSave: saveCourse)) {
                        HStack {
                            Text(course.name)
                            Spacer()
                            Image(systemName: "pencil")
                        }
                    }
                    
                }
                .listStyle(PlainListStyle())
            }
            .onAppear(perform: loadCourses)
        .navigationBarTitle(title + " - " + selectedYear + " grade", displayMode: .inline)
    }
    
    private func loadCourses() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        viewModel.fetchCourses(userId: userId, year: selectedYear)
    }
    
    private func saveCourse(_ course: Course) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let userDocRef = Firestore.firestore().collection("Users").document(userId)
        userDocRef.collection(selectedYear).document("Courses").collection("Items").document(course.id).setData(course.dictionary) { error in
            if let error = error {
                print("Error updating course: \(error.localizedDescription)")
            } else {
                self.isEditingCourse = false
            }
        }
    }
}
