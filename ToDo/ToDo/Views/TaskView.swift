//
//  TaskView.swift
//  ToDo
//
//  Created by Nikhi on 08/09/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI
import UserNotifications

struct TaskView: View {
    
    @EnvironmentObject var taskManager: TaskManager
    
    @State var task: Task
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.task.completed.toggle()
                self.taskManager.saveTasks()
            }
            
        }) {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20))
                    .foregroundColor(task.completed ? .purple : .secondary)
                Text(task.taskName)
                    .font(.system(size: 20))
                    .strikethrough(task.completed)
                    .foregroundColor(task.completed ? .secondary : .primary)
                Spacer()
                Image(systemName: "circle").background(task.backgroundColor).clipShape(Circle())
            }
        }
        .padding(12)
        .contextMenu {
            
            if task.reminderEnabled {
                Button(action: {
                    self.task.reminderEnabled = false
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.task.id])
                    print("Deleted Notification for task: \(self.task.id)")
                    self.taskManager.saveTasks()
                }) {
                    HStack {
                        Image(systemName: "bell")
                        Text("Cancel Reminder")
                    }
                    
                }
            }
            
            Button(action: {
                self.taskManager.deleteTask(for: self.task.id)
            }) {
                HStack {
                    Text("Delete Task")
                    Image(systemName: "trash")
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

