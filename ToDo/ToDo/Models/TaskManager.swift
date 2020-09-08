//
//  TaskManager.swift
//  ToDo
//
//  Created by Nikhi on 08/09/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class Task: Codable, ObservableObject {
    
    
    var id: String
    var taskName: String
    var priority: String
    var completed: Bool
    
    var reminderEnabled: Bool = false
    var reminderDisabled: Bool = true
    var reminderDate: Date = Date()
    
    var backgroundColor: Color {
        priority == "High" ? Color.red : (priority == "Normal" ? Color.orange : Color.green)
    }
    
    //    enum CodingKeys: CodingKey {
    //        case id, taskName, priority, completed
    //    }
    //
    //    required init(from decoder: Decoder) throws {
    //        let container = try decoder.container(keyedBy: CodingKeys.self)
    //        id = try container.decode(String.self, forKey: .id)
    //        taskName = try container.decode(String.self, forKey: .taskName)
    //        priority = try container.decode(String.self, forKey: .priority)
    //        completed = try container.decode(Bool.self, forKey: .completed)
    //    }
    //
    //    func encode(to encoder: Encoder) throws {
    //        var container =  encoder.container(keyedBy: CodingKeys.self)
    //        try container.encode(id, forKey: .id)
    //        try container.encode(taskName, forKey: .taskName)
    //        try container.encode(priority, forKey: .priority)
    //        try container.encode(completed, forKey: .completed)
    //    }
    
    init(taskName: String, priority: String) {
        self.id = UUID().uuidString
        self.taskName = taskName
        self.priority = priority
        self.completed = false
    }
    
    
    
}

class TaskManager: ObservableObject {
    
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var tasks = [Task]()
    @Published var filteredTasks = [Task]()
    
    init() {
        self.fetchTasks()
    }
    
    func addTask(task: Task) {
        self.tasks.append(task)
    }
    
    func getDocumentPath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func fetchTasks() {
        // Firebase goes here
        let path = getDocumentPath().appendingPathComponent(Keys.savedDocumentPath)
        do {
            let data = try Data(contentsOf: path)
            tasks = try JSONDecoder().decode([Task].self, from: data)
            self.tasks.sort { (task1, task2) -> Bool in
                !task1.completed && task2.completed
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func saveTasks() {
        let path = getDocumentPath().appendingPathComponent(Keys.savedDocumentPath)
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: path, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        self.tasks.sort { (task1, task2) -> Bool in
            !task1.completed && task2.completed
        }
        self.filterTaks()
        // Notify Views about the change
        
        objectWillChange.send()
        
        
    }
    
    func filterTaks() {
        var temp = [Task]()
        for task in self.tasks {
            if !task.completed {
                temp.append(task)
            }
        }
        self.filteredTasks = temp
    }
    
    func deleteTask(for id: String) {
        self.tasks.removeAll { $0.id == id }
        self.saveTasks()
    }
    
    
    func requestUserPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                print("Request authorization error: \(error)")
            } else if granted {
                print("Authorization granted")
            } else {
                print("User denied notifications")
            }
        }
    }
    
    func scheduleNotification(id: String, for task: String, date: Date) {
        requestUserPermission()
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.year = Calendar.current.component(.year, from: date)
        dateComponents.month = Calendar.current.component(.month, from: date)
        dateComponents.day = Calendar.current.component(.day, from: date)
        dateComponents.hour = Calendar.current.component(.hour, from: date)
        dateComponents.minute = Calendar.current.component(.minute, from: date)
        
        
        let content = UNMutableNotificationContent()
        content.title = "ToDo"
        content.subtitle = """
        "\(task)"
        """
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}


