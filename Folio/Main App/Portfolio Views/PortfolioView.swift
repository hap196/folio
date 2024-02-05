import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct PortfolioView: View {
    @State private var selectedYear = 0
    let years = ["9th", "10th", "11th", "12th"]
    
    @ObservedObject var viewModel = PortfolioViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                
                VStack(spacing: 10) {
                    PortfolioHeaderView()
                    
                    // Custom Tabs with full width and dividers
                    ZStack(alignment: .bottomLeading) {
                        HStack(spacing: 0) {
                            ForEach(Array(years.enumerated()), id: \.offset) { index, year in
                                Button(action: {
                                    withAnimation {
                                        selectedYear = index
                                    }
                                }) {
                                    Text(year)
                                        .foregroundColor(selectedYear == index ? .customTurquoise : .customGray)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .contentShape(Rectangle())
                                }
                                
                                if index < years.count - 1 {
                                    Divider().background(Color.gray.opacity(0.15))
                                }
                            }
                        }
                        .frame(height: 50)
                        .background(Color.clear)
                        
                        Rectangle()
                            .fill(Color.customTurquoise)
                            .frame(width: UIScreen.main.bounds.width / CGFloat(years.count), height: 2)
                            .offset(x: CGFloat(selectedYear) * (UIScreen.main.bounds.width / CGFloat(years.count)), y: -50)
                            .animation(.default, value: selectedYear)
                    }
                    .frame(height: 50)
                    .background(Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                    )
                    .padding(.horizontal)
                    
                    // Section cards
                    TabView(selection: $selectedYear) {
                        ForEach(0..<years.count) { yearIndex in
                            ScrollView {
                                VStack(alignment: .leading, spacing: 12) {
                                    ForEach(SectionType.allCases, id: \.self) { sectionType in
                                        CollapsibleSectionCardView(
                                            title: sectionType.rawValue,
                                            sectionType: sectionType,
                                            viewModel: viewModel,
                                            selectedYear: years[selectedYear]
                                        )
                                    }
                                }
                                .scrollIndicators(.hidden)
                            }
                            .tag(yearIndex)
                            .padding(.horizontal, 15)
                            .scrollIndicators(.hidden)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .onChange(of: selectedYear) { newValue in
                        fetchDataForSelectedYear()
                    }
                    .onAppear {
                        fetchDataForSelectedYear()
                    }

                    Spacer()
                }
                
                .onAppear {
                    fetchDataForSelectedYear()
                }
            }
        }
    }

    private func fetchDataForSelectedYear() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        viewModel.fetchDataForYear(userId: userId, year: years[selectedYear])
    }

    @Namespace private var namespace
}

struct PortfolioHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "folder.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
                .foregroundColor(.customGray)
            Text("My Portfolio")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.customGray)
            Spacer()
        }
        .padding(.vertical)
    }
}

struct CollapsibleSectionCardView: View {
    let title: String
    let sectionType: SectionType
    let viewModel: PortfolioViewModel
    let selectedYear: String

    @State private var isCollapsed: Bool = false
    @State private var navigateToEditView = false
    @State private var navigateToAddView = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Button(action: {
                    withAnimation {
                        self.isCollapsed.toggle()
                        if !isCollapsed {
                            // Assuming you have access to the user ID here
                            let userId = Auth.auth().currentUser?.uid ?? ""
                            viewModel.fetchDataForSection(userId: userId, year: selectedYear, sectionType: sectionType)
                        }
                    }
                }) {
                    Image(systemName: isCollapsed ? "chevron.down" : "chevron.up")
                        .foregroundColor(.customGray)
                }

                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.customGray)

                Spacer()

                Button(action: {
                    navigateToEditView = true
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.customGray)
                }

                Button(action: {
                    navigateToAddView = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.customGray)
                }
            }
            .padding(.vertical, 10)

            NavigationLink(destination: viewForSectionType(sectionType, isEditMode: true), isActive: $navigateToEditView) { EmptyView() }
            NavigationLink(destination: viewForSectionType(sectionType, isEditMode: false), isActive: $navigateToAddView) { EmptyView() }

            if !isCollapsed {
                VStack(alignment: .leading, spacing: 0) {
                    switch sectionType {
                    case .Courses:
                        ForEach(viewModel.courses, id: \.id) { course in
                            Text(course.name).foregroundColor(Color.gray.opacity(0.15))
                            Divider()
                        }
                    case .Extracurriculars:
                        ForEach(viewModel.extracurriculars, id: \.id) { extracurricular in
                            Text(extracurricular.name).foregroundColor(Color.gray.opacity(0.15))
                            Divider()
                        }
                    case .Awards:
                        ForEach(viewModel.awards, id: \.id) { award in
                            Text(award.name).foregroundColor(Color.gray.opacity(0.15))
                            Divider()
                        }
                    case .TestScores:
                        ForEach(viewModel.testScores, id: \.id) { testScore in
                            Text(testScore.testName).foregroundColor(Color.gray.opacity(0.15))
                            Divider()
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 7)
    }

    @ViewBuilder
    private func viewForSectionType(_ sectionType: SectionType, isEditMode: Bool) -> some View {
        // Return views for each section type
        // Example: if sectionType == .Courses, return a CoursesView
        // You'll need to implement these view components based on your app's structure
        switch sectionType {
        case .Courses:
            isEditMode ? AnyView(CoursesView(viewModel: viewModel, selectedYear: selectedYear, title: "Courses")) : AnyView(AddCourseView(selectedYear: selectedYear))
        case .Extracurriculars:
            isEditMode ? AnyView(ExtracurricularsView(viewModel: viewModel, selectedYear: selectedYear, title: "Extracurriculars")) : AnyView(AddExtracurricularView(selectedYear: selectedYear))
        case .Awards:
            isEditMode ? AnyView(AwardsView(viewModel: viewModel, selectedYear: selectedYear, title: "Awards")) : AnyView(AddAwardView(selectedYear: selectedYear))
        case .TestScores:
            isEditMode ? AnyView(TestScoresView(viewModel: viewModel, selectedYear: selectedYear, title: "Test Scores")) : AnyView(AddTestScoreView(selectedYear: selectedYear))
        }
    }

}


enum SectionType: String, CaseIterable {
    case Courses = "Courses"
    case Extracurriculars = "Extracurriculars"
    case Awards = "Awards"
    case TestScores = "Test Scores"
}

extension Color {
    static let customLightBackground = Color.gray.opacity(0.1)
    static let customDarkBackground = Color.gray.opacity(0.2)
    static let customBlue = Color.blue
}
