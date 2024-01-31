import FirebaseFirestore
import Firebase

class PortfolioViewModel: ObservableObject {
    @Published var courses: [Course] = []
    @Published var extracurriculars: [Extracurricular] = []
    @Published var awards: [Award] = []
    @Published var testScores: [TestScore] = []

    private var db = Firestore.firestore()

    func fetchDataForYear(userId: String, year: String) {
        fetchCourses(userId: userId, year: year)
        fetchExtracurriculars(userId: userId, year: year)
        fetchAwards(userId: userId, year: year)
        fetchTestScores(userId: userId, year: year)
    }
    
    func fetchCourses(userId: String, year: String) {
        db.collection("Users").document(userId).collection(year).document("Courses").collection("Items")
            .addSnapshotListener { querySnapshot, error in
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
        db.collection("Users").document(userId).collection(year).document("Extracurriculars").collection("Items")
            .addSnapshotListener { querySnapshot, error in
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
        db.collection("Users").document(userId).collection(year).document("Awards").collection("Items")
            .addSnapshotListener { querySnapshot, error in
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
        db.collection("Users").document(userId).collection(year).document("TestScores").collection("Items")
            .addSnapshotListener { querySnapshot, error in
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
