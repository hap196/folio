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

    let courseLevels = ["Regular", "Honors", "AP", "IB", "Dual Enrollment"]
    let grades = ["A", "B", "C", "D", "F", "P", "NP", "Other"]

    var body: some View {
            ZStack {
                VStack(alignment: .leading) {
                    Divider()

                    Group {
                        Text("Course name")
                            .foregroundColor(.customGray)
                            .padding(.top)

                        TextField("Ex. AP Chemistry", text: $course.name)
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

                        Picker("Course Level", selection: $course.level) {
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

                        Picker("Grade", selection: $course.grade) {
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
                        onSave(course)
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
            
        }
        .navigationTitle("Edit Course")
        .navigationBarTitleDisplayMode(.inline)
    }
}
