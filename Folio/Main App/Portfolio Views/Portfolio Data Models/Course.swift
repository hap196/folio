//
//  Course.swift
//  Folio
//
//  Created by Hailey Pan on 1/25/24.
//

import SwiftUI

class Course: ObservableObject, Identifiable, Codable {
    @Published var name: String
    @Published var level: String
    @Published var grade: String

    var id: String = UUID().uuidString

    enum CodingKeys: CodingKey {
        case id, name, level, grade
    }

    // Convert to dictionary for Firestore
    var dictionary: [String: Any] {
        return [
            "id": id,
            "name": name,
            "level": level,
            "grade": grade
        ]
    }

    // Default initializer
    init(name: String = "", level: String = "", grade: String = "") {
        self.name = name
        self.level = level
        self.grade = grade
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        level = try container.decode(String.self, forKey: .level)
        grade = try container.decode(String.self, forKey: .grade)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(level, forKey: .level)
        try container.encode(grade, forKey: .grade)
    }
}
