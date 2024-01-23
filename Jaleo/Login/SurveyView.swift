//
//  SurveyView.swift
//  Jaleo
//
//  Created by Hailey Pan on 1/14/24.
//

import SwiftUI

enum SurveyStep {
    case grade
    case school
    case major
    case details
}

struct SurveyView: View {
    @State private var currentStep: SurveyStep = .grade
    @State private var grade: String = ""
    @State private var school: String = ""
    @State private var major: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        VStack {
            // Progress Bar
            ProgressView(value: progressValue(), total: 4)
                .padding()

            // Survey Step Content
            switch currentStep {
            case .grade:
                gradeStepView
            case .school:
                schoolStepView
            case .major:
                majorStepView
            case .details:
                detailsStepView
            }

            // Navigation Buttons
            HStack {
                if currentStep != .grade {
                    Button("Back") {
                        goBack()
                    }
                }

                Spacer()

                Button(currentStep == .details ? "Submit" : "Next") {
                    goToNextStep()
                }
            }
            .padding()
        }

    }

    private var gradeStepView: some View {
        // View for selecting grade (9th, 10th, 11th, 12th)
        // Use Picker, List, or buttons to set the 'grade' state
        // Example:
        Picker("Grade", selection: $grade) {
            Text("9th").tag("9th")
            Text("10th").tag("10th")
            Text("11th").tag("11th")
            Text("12th").tag("12th")
        }
        .pickerStyle(.segmented)
    }

    private var schoolStepView: some View {
        // View for entering school (use TextField or similar)
        TextField("School", text: $school)
            .textFieldStyle(.roundedBorder)
            .padding()
    }

    private var majorStepView: some View {
        // View for selecting or entering major
        // Use Picker, Dropdown, or TextField
        TextField("Major", text: $major)
            .textFieldStyle(.roundedBorder)
            .padding()
    }

    private var detailsStepView: some View {
        // View for entering name and email
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            // Sign Up Button
            Button(action: {
                Task {
                    do {
                        try await viewModel.signUp()
                       // showSignInView = false
                        print("Signed up successfully")
                    } catch {
                        print("Sign up error")
                    }
                }
            }) {
            Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    private func progressValue() -> Float {
        switch currentStep {
        case .grade:
            return 1
        case .school:
            return 2
        case .major:
            return 3
        case .details:
            return 4
        }
    }

    private func goToNextStep() {
        switch currentStep {
        case .grade:
            currentStep = .school
        case .school:
            currentStep = .major
        case .major:
            currentStep = .details  // Proceed to details step instead of showing sign up view
        case .details:
            // Now you would show the sign up view after collecting survey details
            SignUpView(showSignUpView: $showSignInView)
            //showSignInView = true
            print("Survey Submitted")
        }
    }


    private func goBack() {
        // Logic to navigate back to the previous step
        switch currentStep {
        case .school:
        currentStep = .grade
        case .major:
        currentStep = .school
        case .details:
        currentStep = .major
        default:
        break
        }
    }
}

//struct SurveyView_Previews: PreviewProvider {
//    static var previews: some View {
//        SurveyView(showSignInView: $showSignInView)
//    }
//}
