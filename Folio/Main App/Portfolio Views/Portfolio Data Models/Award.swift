//
//  Award.swift
//  Folio
//
//  Created by Hailey Pan on 1/30/24.
//

import SwiftUI

class Award: ObservableObject, Identifiable, Codable {
    @Published var name: String
    @Published var yearReceived: String
    @Published var description: String

    var id: String = UUID().uuidString

    enum CodingKeys: CodingKey {
        case id, name, yearReceived, description
    }

    var dictionary: [String: Any] {
        return [
            "id": id,
            "name": name,
            "yearReceived": yearReceived,
            "description": description
        ]
    }

    init(name: String = "", yearReceived: String = "", description: String = "") {
        self.name = name
        self.yearReceived = yearReceived
        self.description = description
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        yearReceived = try container.decode(String.self, forKey: .yearReceived)
        description = try container.decode(String.self, forKey: .description)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(yearReceived, forKey: .yearReceived)
        try container.encode(description, forKey: .description)
    }
}
