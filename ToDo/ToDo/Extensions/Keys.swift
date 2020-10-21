//
//  Keys.swift
//  ToDo
//
//  Created by Nikhi on 08/09/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import Foundation


struct Keys {
    static let firstTime = "first_time"
    static let loggedInUserName = "logged_in_user"
    static let safeEmail = "safe_email"
    static let savedDocumentPath: String = "SavedTasks"
    static let hideCompletedTasksKey: String = "hideCompletedTasks"

    
}


struct DataKeys {
    static let id = "id"
    static let taskName = "taskName"
    static let priority = "priority"
    static let completed = "completed"
    static let reminderEnabled = "reminderEnabled"
    static let reminderDisabled = "reminderDisabled"
    static let reminderDate = "reminderDate"
}
