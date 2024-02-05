//
//  UpcomingTasksView.swift
//  Folio
//
//  Created by Hailey Pan on 2/4/24.
//

import SwiftUI


struct UpcomingTasksView: View {
    @State private var areTodayTasksCollapsed: Bool = false
    @State private var areWeeklyTasksCollapsed: Bool = false
    @State private var todayTasks: [Todo] = [
        // Sample tasks for today
        Todo(title: "Finish Math Homework", dueDate: Date()),
        Todo(title: "Read Biology Chapter 5", dueDate: Date(), isStarred: true)
    ]
    @State private var thisWeekTasks: [Todo] = [
        // Sample tasks for this week
        Todo(title: "Start History Essay", dueDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!),
        Todo(title: "Chemistry Lab Report", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Today's tasks header with collapse toggle
            HStack {
                Text("Today")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        areTodayTasksCollapsed.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(areTodayTasksCollapsed ? 0 : 90))
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 10)
            
            if !areTodayTasksCollapsed {
                ForEach(todayTasks) { task in
                    TaskView(task: task)
                }
            }

            // This Week's tasks header with collapse toggle
            HStack {
                Text("This Week")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        areWeeklyTasksCollapsed.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(areWeeklyTasksCollapsed ? 0 : 90))
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 10)
            
            if !areWeeklyTasksCollapsed {
                ForEach(thisWeekTasks) { task in
                    TaskView(task: task)
                }
            }
        }
        .padding(.horizontal, 30)
    }
}
