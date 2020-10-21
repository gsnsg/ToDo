//
//  AddNewTaskViewModel.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import Foundation


final class AddNewTaskViewModel: ObservableObject {
    @Published var showNotification = false
    @Published var taskName = ""
    @Published var currentPriority = "Normal"
    @Published var date = Date()

    
    let priorities = ["High", "Normal", "Low"]
    
    func addTask() {
        
        // Replace Task Manager with Firebase Storage
        let newTask = Task(id: nil, taskName: self.taskName, priority: self.currentPriority)
        if self.showNotification {
            newTask.reminderEnabled = true
            newTask.reminderDate = self.date
            NotificationManager.shared.addNotification(forTask: newTask)
            
        }
        FirebaseManager.shared.updateTask(task: newTask)
    }
}
