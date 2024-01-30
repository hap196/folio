//
//  Course.swift
//  Folio
//
//  Created by Hailey Pan on 1/25/24.
//

import SwiftUI

struct Course: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var level: String
    var grade: String
    
    // Convert to dictionary for Firestore
    var dictionary: [String: Any] {
        return [
            "id": id,
            "name": name,
            "level": level,
            "grade": grade
        ]
    }
}
