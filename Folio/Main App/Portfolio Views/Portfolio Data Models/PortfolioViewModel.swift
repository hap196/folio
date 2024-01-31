import FirebaseFirestore
import Firebase

class PortfolioViewModel: ObservableObject {
    @Published var courses: [Course] = []
    @Published var extracurriculars: [Extracurricular] = []
    @Published var awards: [Award] = []
    @Published var testScores: [TestScore] = []

    private var db = Firestore.firestore()
    private var courseListener: ListenerRegistration?
    private var extracurricularListener: ListenerRegistration?
    private var awardListener: ListenerRegistration?
    private var testScoreListener: ListenerRegistration?

    func fetchDataForYear(userId: String, year: String) {
        resetData()
        fetchCourses(userId: userId, year: year)
        fetchExtracurriculars(userId: userId, year: year)
        fetchAwards(userId: userId, year: year)
        fetchTestScores(userId: userId, year: year)
    }

    private func resetData() {
        courses = []
        extracurriculars = []
        awards = []
        testScores = []

        courseListener?.remove()
        extracurricularListener?.remove()
        awardListener?.remove()
        testScoreListener?.remove()
    }
    
    func fetchDataForSection(userId: String, year: String, sectionType: SectionType) {
        // Fetch data based on the section type
        switch sectionType {
        case .Courses:
            fetchCourses(userId: userId, year: year)
        case .Extracurriculars:
            fetchExtracurriculars(userId: userId, year: year)
        case .Awards:
            fetchAwards(userId: userId, year: year)
        case .TestScores:
            fetchTestScores(userId: userId, year: year)
        }
    }
    
    func fetchCourses(userId: String, year: String) {
        courseListener?.remove()
        courseListener = db.collection("Users").document(userId).collection(year).document("Courses").collection("Items")
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }
                guard let documents = querySnapshot?.documents else {
                    print("No courses found: \(error?.localizedDescription ?? "")")
                    return
                }

                self.courses = documents.compactMap { documentSnapshot in
                    try? documentSnapshot.data(as: Course.self)
                }
            }
    }

    func fetchExtracurriculars(userId: String, year: String) {
        extracurricularListener?.remove()
        extracurricularListener = db.collection("Users").document(userId).collection(year).document("Extracurriculars").collection("Items")
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }
                guard let documents = querySnapshot?.documents else {
                    print("No extracurriculars found")
                    return
                }

                self.extracurriculars = documents.compactMap { documentSnapshot in
                    try? documentSnapshot.data(as: Extracurricular.self)
                }
            }
    }

    func fetchAwards(userId: String, year: String) {
        awardListener?.remove()
        awardListener = db.collection("Users").document(userId).collection(year).document("Awards").collection("Items")
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }
                guard let documents = querySnapshot?.documents else {
                    print("No awards found")
                    return
                }

                self.awards = documents.compactMap { documentSnapshot in
                    try? documentSnapshot.data(as: Award.self)
                }
            }
    }

    func fetchTestScores(userId: String, year: String) {
        testScoreListener?.remove()
        testScoreListener = db.collection("Users").document(userId).collection(year).document("TestScores").collection("Items")
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }
                guard let documents = querySnapshot?.documents else {
                    print("No test scores found")
                    return
                }

                self.testScores = documents.compactMap { documentSnapshot in
                    try? documentSnapshot.data(as: TestScore.self)
                }
            }
    }
}
