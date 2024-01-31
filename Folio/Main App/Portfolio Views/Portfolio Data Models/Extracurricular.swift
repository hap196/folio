//
//  Extracurricular.swift
//  Folio
//
//  Created by Hailey Pan on 1/30/24.
//

import SwiftUI

class Extracurricular: ObservableObject, Identifiable, Codable {
    @Published var name: String
    @Published var description: String
    @Published var role: String
    @Published var yearsParticipated: [String]

    var id: String = UUID().uuidString

    enum CodingKeys: CodingKey {
        case id, name, description, role, yearsParticipated
    }

    var dictionary: [String: Any] {
        return [
            "id": id,
            "name": name,
            "description": description,
            "role": role,
            "yearsParticipated": yearsParticipated
        ]
    }

    init(name: String = "", description: String = "", role: String = "", yearsParticipated: [String] = []) {
        self.name = name
        self.description = description
        self.role = role
        self.yearsParticipated = yearsParticipated
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        role = try container.decode(String.self, forKey: .role)
        yearsParticipated = try container.decode([String].self, forKey: .yearsParticipated)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(role, forKey: .role)
    }
}


