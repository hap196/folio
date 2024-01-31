//
//  TestScore.swift
//  Folio
//
//  Created by Hailey Pan on 1/30/24.
//

import SwiftUI

struct TestScore: Identifiable, Codable {
    var id: String = UUID().uuidString
    var testName: String
    var score: String
    var dateTaken: Date // Using Date to represent the date

    var dictionary: [String: Any] {
        return [
            "id": id,
            "testName": testName,
            "score": score,
            "dateTaken": dateTaken // Ensure this is formatted properly for Firestore
        ]
    }
}
