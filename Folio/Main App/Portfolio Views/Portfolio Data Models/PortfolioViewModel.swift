import FirebaseFirestore

class PortfolioViewModel: ObservableObject {
    @Published var courses: [Course] = []
    @Published var extracurriculars: [Extracurricular] = []
    @Published var awards: [Award] = []
    @Published var testScores: [TestScore] = []

    private var db = Firestore.firestore()

    // Existing fetchCourses function

    func fetchExtracurriculars(userId: String) {
        db.collection("Users").document(userId).collection("Extracurriculars").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No extracurriculars found")
                return
            }

            self.extracurriculars = documents.map { document in
                let data = document.data()
                let name = data["name"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let yearsParticipated = data["yearsParticipated"] as? [String] ?? []
                return Extracurricular(name: name, description: description, yearsParticipated: yearsParticipated)
            }
        }
    }

    func fetchAwards(userId: String) {
        db.collection("Users").document(userId).collection("Awards").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No awards found")
                return
            }

            self.awards = documents.map { document in
                let data = document.data()
                let name = data["name"] as? String ?? ""
                let yearReceived = data["yearReceived"] as? String ?? ""
                let description = data["description"] as? String
                return Award(name: name, yearReceived: yearReceived, description: description)
            }
        }
    }

    func fetchTestScores(userId: String) {
        db.collection("Users").document(userId).collection("TestScores").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No test scores found")
                return
            }

            self.testScores = documents.map { document in
                let data = document.data()
                let testName = data["testName"] as? String ?? ""
                let score = data["score"] as? String ?? ""
                // Handle the date conversion from Firestore to Date object
                let dateTaken = (data["dateTaken"] as? Timestamp)?.dateValue() ?? Date()
                return TestScore(testName: testName, score: score, dateTaken: dateTaken)
            }
        }
    }
}
