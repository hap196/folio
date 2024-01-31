//
//  Extracurricular.swift
//  Folio
//
//  Created by Hailey Pan on 1/30/24.
//

import SwiftUI

struct Extracurricular: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var yearsParticipated: [String] // e.g., ["9th", "10th"]

    var dictionary: [String: Any] {
        return [
            "id": id,
            "name": name,
            "description": description,
            "yearsParticipated": yearsParticipated
        ]
    }
}

