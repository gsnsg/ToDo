//
//  NotificationManager.swift
//  ToDo
//
//  Created by Nikhi on 22/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


final class NotificationManager {
    static let shared = NotificationManager()
    
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
    
    func addNotification(forTask task: Task) {
        requestUserPermission()
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.year = Calendar.current.component(.year, from: task.reminderDate)
        dateComponents.month = Calendar.current.component(.month, from: task.reminderDate)
        dateComponents.day = Calendar.current.component(.day, from: task.reminderDate)
        dateComponents.hour = Calendar.current.component(.hour, from: task.reminderDate)
        dateComponents.minute = Calendar.current.component(.minute, from: task.reminderDate)
        
        
        let content = UNMutableNotificationContent()
        content.title = "ToDo"
        content.subtitle = """
        "\(task.taskName)"
        """
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)
        removeNotification(forId: task.id)
        UNUserNotificationCenter.current().add(request)
    }
    
    
    func removeNotification(forId id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
