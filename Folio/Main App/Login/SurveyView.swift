//
//  SurveyView.swift
//  Folio
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
    
    @State private var showSignUpView = false
    @State private var signupSuccessful = false
    @Binding var isAuthenticated: Bool

    private var showSignUpBinding: Binding<Bool> {
            Binding(
                get: { self.showSignUpView && !self.signupSuccessful },
                set: { self.showSignUpView = $0 }
            )
        }
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    HStack {
                        Button(action: {
                            goBack()
                        }) {
                            Label("", systemImage: "arrow.backward")
                                .foregroundColor(.customTurquoise)
                                .padding([.top, .horizontal])
                        }
                        
                        ProgressView(value: progressValue(), total: 4)
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                            .padding([.top, .horizontal])
                            .cornerRadius(10)
                            .accentColor(Color.customTurquoise)
                    }
                    .padding(.top, 15)
                    
                    Spacer()
                    
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
                    
                    Spacer()
                    
                    Divider()
                        .padding(.vertical)
                    
                    Button(action: {
                        goToNextStep()
                    }) {
                        Text("Continue")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(BlueButtonStyle())
                    .padding(.bottom)
                    
                }
                
                //        .fullScreenCover(isPresented: $showSignUpView) {
                //            SignUpView(showSignUpView: $showSignUpView, isAuthenticated: $isAuthenticated)
                //        }
                .fullScreenCover(isPresented: $showSignUpView) {
                    SignUpView(
                        viewModel: SignInEmailViewModel(grade: grade, school: school, major: major),
                        showSignUpView: $showSignUpView,
                        isAuthenticated: $isAuthenticated
                    )
                }
                
                // Present HomeView when the signup is successful
                .fullScreenCover(isPresented: $signupSuccessful) {
                    //          HomeView()  // Replace with your actual HomeView
                    SettingsView(isAuthenticated: $isAuthenticated)
                }
                .padding(.horizontal)
                
            }
        }
        
    }

    private var gradeStepView: some View {
        VStack(spacing: 10) {
            Text("What grade are you in?")
                        .font(.headline)
                        .padding(.top, 30)
                        .padding(.bottom, 15)
                        .foregroundColor(.customGray)
            ForEach(["9th", "10th", "11th", "12th"], id: \.self) { gradeOption in
                Button(action: {
                    grade = gradeOption
                }) {
                    Text(gradeOption)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(grade == gradeOption ? Color.customGray : Color.gray.opacity(0.15))
                        .foregroundColor(grade == gradeOption ?  Color.white : .customTurquoise)
                        .cornerRadius(10)
                        .fontWeight(.bold)
                }
            }
            Spacer()
        }
        .padding()
    }


    private var schoolStepView: some View {
        VStack {
            Text("What school do you go to?")
                .font(.headline)
                .padding(.top, 30)
                .padding(.bottom, 15)
                .foregroundColor(.customGray)

            TextField("School", text: $school)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
                .foregroundColor(.customGray)
            
            Spacer()
        }
        .padding()
    }

    private var majorStepView: some View {
        VStack {
            Text("What major are you interested in?")
                .font(.headline)
                .padding(.top, 30)
                .padding(.bottom, 15)
                .foregroundColor(.customGray)

            TextField("Major", text: $major)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
                .foregroundColor(.customGray)
            
            Spacer()
        }
        .padding()
    }


    private var detailsStepView: some View {
        VStack {
            Text("What's your name?")
                .font(.headline)
                .padding(.top, 30)
                .padding(.bottom, 15)
                .foregroundColor(.customGray)
            
            TextField("First name", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
                .foregroundColor(.customGray)
            
            TextField("Last name", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
                .foregroundColor(.customGray)
            
            Spacer()
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
            showSignUpView = true
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
