//
//  HomeViewModel.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import Combine

final class HomeViewModel: ObservableObject {
    
    private var ref = Firebase.Database.database().reference()
    
    @Published var showSheet = false
    @Published var currentSheet: CurrentSheet = .settings
    @Published var hideCompletedTasks: Bool = UserDefaults.standard.bool(forKey: Keys.hideCompletedTasksKey)

    @Published var taskViewModels: [TaskViewModel] = []
    
    
    init() {
        self.fetchTasks()
        
    }

    
    func fetchTasks() {
        
        if let safeEmail = UserDefaults.standard.string(forKey: Keys.safeEmail) {
            ref.child("tasks/\(safeEmail)/").observe(.value) { [weak self] (snapshot) in
                self?.taskViewModels.removeAll()
                guard let snapshotDictionary = snapshot.value as? [String : Any] else {
                    return
                }
                
                
                for nsDict in snapshotDictionary.values  {
                    guard let dict = nsDict as? Dictionary<String, Any> else {
                        return
                    }
                    guard let id = dict[DataKeys.id] as? String, let taskName = dict[DataKeys.taskName] as? String,
                          let priority = dict[DataKeys.priority] as? String, let completed = dict[DataKeys.completed] as? Bool,
                          let reminderEnabled = dict[DataKeys.reminderEnabled] as? Bool, let reminderDisabled = dict[DataKeys.reminderDisabled] as? Bool,
                          let reminderDate = dict[DataKeys.reminderDate] as? String else {
                        return
                    }
                    // Date Formatting
                    let df = DateFormatter()
                    df.locale = Locale(identifier: "US_en")
                    df.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                    
                    guard let remindDate = df.date(from: reminderDate) else { return }
                    let task = Task(id: id, taskName: taskName, priority: priority)
                    task.completed = completed
                    task.reminderEnabled = reminderEnabled
                    task.reminderDisabled = reminderDisabled
                    task.reminderDate = remindDate
                    
                    if task.reminderEnabled && !task.reminderDisabled {
                        NotificationManager.shared.addNotification(forTask: task)
                    }
                    
                    self?.taskViewModels.append(TaskViewModel(task: task))
                    
                }
                
                
            }
        }
        
    }
    
    
    
    
    func setShowSheet(sheet: CurrentSheet) {
        self.currentSheet = sheet
        self.showSheet = true
    }
    
}

