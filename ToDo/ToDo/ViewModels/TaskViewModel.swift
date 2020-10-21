//
//  TaskViewModel.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import Foundation
import SwiftUI

final class TaskViewModel: ObservableObject, Identifiable {
    
    let id = UUID().uuidString
    
    @Published var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    func toggleTask() {
        self.task.completed.toggle()
        FirebaseManager.shared.updateTask(task: task)
        
    }
    
    func deleteTask() {
        FirebaseManager.shared.deleteTask(forId: self.task.id)
    }
    
    func disableReminder() {
        self.task.reminderEnabled = false
        self.task.reminderDisabled = true
        NotificationManager.shared.removeNotification(forId: task.id)
        FirebaseManager.shared.updateTask(task: task)
    }
}

