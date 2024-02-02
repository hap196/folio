//
//  OpportunityViewModel.swift
//  Folio
//
//  Created by Hailey Pan on 1/31/24.
//

import FirebaseFirestore
import Foundation

class OpportunitiesViewModel: ObservableObject {
    
    @Published var opportunities = [Opportunity]()

    init() {
        fetchOpportunities()
    }

    private func fetchOpportunities() {
        let db = Firestore.firestore()
        db.collection("Opportunities").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents: \(error?.localizedDescription ?? "unknown error")")
                return
            }

            self.opportunities = documents.compactMap { queryDocumentSnapshot -> Opportunity? in
                try? queryDocumentSnapshot.data(as: Opportunity.self)
            }
        }
    }

    func parseJson() -> [Opportunity]? {
        guard let url = Bundle.main.url(forResource: "opportunities", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return nil }

        let decoder = JSONDecoder()
        return try? decoder.decode([Opportunity].self, from: data)
    }

    func uploadDataToFirestore() {
        guard let opportunities = parseJson() else { return }

        let db = Firestore.firestore()

        for opportunity in opportunities {
            db.collection("Opportunities").addDocument(data: [
                "title": opportunity.title,
                "organization": opportunity.organization,
                "location": opportunity.location,
                "description": opportunity.description,
                "type": opportunity.type,
                "level": opportunity.level ?? "",
                "link": opportunity.link,
                "eligibility": opportunity.eligibility ?? "",
                "programDates": opportunity.programDates ?? "",
                "applicationDeadline": opportunity.applicationDeadline ?? "",
                "registrationDeadline": opportunity.registrationDeadline ?? ""
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(opportunity.title)")
                }
            }
        }
    }
}
