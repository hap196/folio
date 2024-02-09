//
//  SavedOpportunitiesViewModel.swift
//  Folio
//
//  Created by Hailey Pan on 2/8/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

final class SavedOpportunitiesViewModel: ObservableObject {
    @Published var savedOpportunities = [Opportunity]()
    private var db = Firestore.firestore()

    func fetchSavedOpportunities() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }

        db.collection("Users").document(userId).collection("SavedOpportunities").getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error getting saved opportunities IDs: \(error.localizedDescription)")
                return
            }

            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                print("No saved opportunities found")
                return
            }

            let opportunityIDs = documents.compactMap { $0.data()["opportunityId"] as? String }

            DispatchQueue.main.async {
                self?.savedOpportunities.removeAll()
            }

            for opportunityId in opportunityIDs {
                self?.db.collection("Opportunities").document(opportunityId).getDocument { (opportunitySnapshot, error) in
                    if let error = error {
                        print("Error getting opportunity: \(error.localizedDescription)")
                        return
                    }

                    if let opportunitySnapshot = opportunitySnapshot, opportunitySnapshot.exists,
                       let opportunity = try? opportunitySnapshot.data(as: Opportunity.self) {
                        DispatchQueue.main.async {
                            if !(self?.savedOpportunities.contains(where: { $0.id == opportunity.id }) ?? false) {
                                self?.savedOpportunities.append(opportunity)
                            }
                        }
                    } else {
                        print("Opportunity document does not exist or failed to decode.")
                    }
                }
            }
        }
    }
    
    

}
