import FirebaseFirestore

class PortfolioViewModel: ObservableObject {
    @Published var courses: [Course] = []

    private var db = Firestore.firestore()

    func fetchCourses(userId: String) {
        db.collection("Users").document(userId).collection("Courses").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No courses found")
                return
            }

            self.courses = documents.map { (queryDocumentSnapshot) -> Course in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let level = data["level"] as? String ?? ""
                let grade = data["grade"] as? String ?? ""
                return Course(name: name, level: level, grade: grade)
            }
        }
    }
}
