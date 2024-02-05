//
//  TaskView.swift
//  Folio
//
//  Created by Hailey Pan on 2/4/24.
//

import SwiftUI

struct TaskView: View {
    var task: Todo
    
    var body: some View {
        HStack {
            Circle()
                .fill(task.isStarred ? Color.yellow : Color.gray)
                .frame(width: 10, height: 10)
            Text(task.title)
                .foregroundColor(.white)
                .strikethrough(task.isChecked)
            Spacer()
            Text(task.dueDate, style: .date)
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding(.vertical, 5)
    }
}
