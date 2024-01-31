//
//  TestScore.swift
//  Folio
//
//  Created by Hailey Pan on 1/30/24.
//

import SwiftUI

class TestScore: ObservableObject, Identifiable, Codable {
    @Published var testName: String
    @Published var score: String
    @Published var dateTaken: Date

    var id: String = UUID().uuidString

    enum CodingKeys: CodingKey {
        case id, testName, score, dateTaken
    }

    var dictionary: [String: Any] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return [
            "id": id,
            "testName": testName,
            "score": score,
            "dateTaken": dateFormatter.string(from: dateTaken)
        ]
    }

    init(testName: String = "", score: String = "", dateTaken: Date = Date()) {
        self.testName = testName
        self.score = score
        self.dateTaken = dateTaken
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        testName = try container.decode(String.self, forKey: .testName)
        score = try container.decode(String.self, forKey: .score)
        let dateString = try container.decode(String.self, forKey: .dateTaken)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateTaken = dateFormatter.date(from: dateString) ?? Date()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(testName, forKey: .testName)
        try container.encode(score, forKey: .score)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        try container.encode(dateFormatter.string(from: dateTaken), forKey: .dateTaken)
    }
}

