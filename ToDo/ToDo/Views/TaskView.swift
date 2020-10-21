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
    
    
    
    @StateObject var taskViewModel: TaskViewModel
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.taskViewModel.toggleTask()
            }
            
        }) {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Image(systemName: taskViewModel.task.completed ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20))
                    .foregroundColor(taskViewModel.task.completed ? .purple : .secondary)
                Text(taskViewModel.task.taskName)
                    .font(.system(size: 20))
                    .strikethrough(taskViewModel.task.completed)
                    .foregroundColor(taskViewModel.task.completed ? .secondary : .primary)
                Spacer()
                Image(systemName: "circle")
                    .foregroundColor(.white)
                    .background(taskViewModel.task.backgroundColor).clipShape(Circle())
                    
            }
        }
        .padding(12)
        .contextMenu {
            
            if taskViewModel.task.reminderEnabled {
                Button(action: {
                    self.taskViewModel.disableReminder()
                }) {
                    HStack {
                        Image(systemName: "bell")
                        Text("Cancel Reminder")
                    }
                    
                }
            }
            
            Button(action: {
                self.taskViewModel.deleteTask()
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

