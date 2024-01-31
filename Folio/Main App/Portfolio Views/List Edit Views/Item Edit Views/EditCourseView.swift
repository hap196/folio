//
//  EditCoursesView.swift
//  Folio
//
//  Created by Hailey Pan on 1/31/24.
//

import SwiftUI

struct EditCourseView: View {
    @Environment(\.presentationMode) var presentationMode
        @ObservedObject var course: Course
        var onSave: (Course) -> Void

    var body: some View {
        VStack {
            TextField("Course Name", text: $course.name)

            TextField("Course Level", text: $course.level)
            TextField("Course Grade", text: $course.grade)
            
            Button("Save Changes") {
                onSave(course)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}

