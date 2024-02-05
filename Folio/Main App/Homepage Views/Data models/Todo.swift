//
//  Todo.swift
//  Folio
//
//  Created by Hailey Pan on 2/4/24.
//

import Foundation

struct Todo: Identifiable {
    let id: String
    var title: String
    var dueDate: Date
    var isStarred: Bool
    var isChecked: Bool

    init(title: String, dueDate: Date, isStarred: Bool = false, isChecked: Bool = false) {
        self.id = UUID().uuidString // Generate a unique ID for each todo
        self.title = title
        self.dueDate = dueDate
        self.isStarred = isStarred
        self.isChecked = isChecked
    }
}
