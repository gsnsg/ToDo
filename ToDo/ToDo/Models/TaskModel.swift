//
//  TaskModel.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import Foundation
import SwiftUI




class Task: Codable, ObservableObject {
    
    @Published var id: String
    @Published var taskName: String
    @Published var priority: String
    @Published var completed: Bool
    
    @Published var reminderEnabled: Bool = false
    @Published var reminderDisabled: Bool = false
    @Published var reminderDate: Date = Date()
    
    var backgroundColor: Color {
        priority == "High" ? Color.red : (priority == "Normal" ? Color.orange : Color.green)
    }
    
    
    var dictionary: [String: Any] {
        return [DataKeys.id: id,
                DataKeys.taskName: taskName,
                DataKeys.priority: priority,
                DataKeys.completed: completed,
                DataKeys.reminderEnabled: reminderEnabled,
                DataKeys.reminderDisabled: reminderDisabled,
                DataKeys.reminderDate: "\(reminderDate)"
        ]
    }
    
   
    
    
    enum CodingKeys: CodingKey {
        case id, taskName, priority, completed, reminderEnabled, reminderDisabled, reminderDate
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        taskName = try container.decode(String.self, forKey: .taskName)
        priority = try container.decode(String.self, forKey: .priority)
        completed = try container.decode(Bool.self, forKey: .completed)
        reminderEnabled = try container.decode(Bool.self, forKey: .reminderEnabled)
        reminderDisabled = try container.decode(Bool.self, forKey: .reminderDisabled)
        reminderDate = try container.decode(Date.self, forKey: .reminderDate)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(taskName, forKey: .taskName)
        try container.encode(priority, forKey: .priority)
        try container.encode(completed, forKey: .completed)
        try container.encode(reminderEnabled, forKey: .reminderEnabled)
        try container.encode(reminderDisabled, forKey: .reminderDisabled)
        try container.encode(reminderDate, forKey: .reminderDate)
    }
    
    
    
    
    init(id: String?, taskName: String, priority: String) {
        self.id = id ?? UUID().uuidString
        self.taskName = taskName
        self.priority = priority
        self.completed = false
    }
    
    
    
}
