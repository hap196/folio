//
//  Opportunity.swift
//  Folio
//
//  Created by Hailey Pan on 1/31/24.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase

// Opportunity Data model

struct Opportunity: Codable, Identifiable {
    @DocumentID var id: String?

    let title: String
    let organization: String
    let location: String
    let description: String
    let type: String
    let level: String?
    let link: String
    let eligibility: String?
    let programDates: String?
    let applicationDeadline: String?
    let registrationDeadline: String?

    enum CodingKeys: String, CodingKey {
        case title, organization, location, description, type, level, link, eligibility
        case programDates = "program_dates"
        case applicationDeadline = "application deadline"
        case registrationDeadline = "registration deadline"
    }
}
