//
//  Award.swift
//  Folio
//
//  Created by Hailey Pan on 1/30/24.
//

import SwiftUI

struct Award: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var yearReceived: String // e.g., "2023"
    var description: String?

    var dictionary: [String: Any] {
        var dict = [
            "id": id,
            "name": name,
            "yearReceived": yearReceived
        ]
        if let description = description {
            dict["description"] = description
        }
        return dict
    }
}
