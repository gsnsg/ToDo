//
//  AlternateFormView.swift
//  ToDo
//
//  Created by Nikhi on 08/09/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI
import UserNotifications

struct AlternateFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskManager: TaskManager
    
    @State var showNotification = false
    @State private var taskName = ""
    @State private var currentPriority = "Normal"
    
    @State private var date = Date()
    
    let priorities = ["High", "Normal", "Low"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("GENERAL INFO")) {
                    TextField("Task Name", text: $taskName)
                }
                
                Section(header: Text("PRIORITY")) {
                    Picker(selection: $currentPriority, label: Text("Priority")) {
                        ForEach(priorities, id: \.self) { priority in
                            Text(priority.capitalized)
                            
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("NOTIFICATION")) {
                    Toggle("Show Reminder", isOn: $showNotification.animation())
                    if showNotification {
                        DatePicker("Please enter a time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    }
                    
                }
                HStack {
                    Spacer()
                    Button("Save") {
                        
                        let newTask = Task(taskName: self.taskName, priority: self.currentPriority)
                        if self.showNotification {
                            newTask.reminderEnabled = true
                            newTask.reminderDate = self.date
                            self.taskManager.scheduleNotification(id: newTask.id, for: self.taskName, date: self.date)
                            
                        }
                        self.taskManager.addTask(task: newTask)
                        self.taskManager.saveTasks()
                        self.presentationMode.wrappedValue.dismiss()
                    }.disabled(taskName.count == 0)
                    Spacer()
                }
                
                
                
            }.navigationBarTitle("Add New Task")
                .navigationBarItems(trailing: Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
        
    }
    
    
    
    
    
}

struct AlternateFormView_Previews: PreviewProvider {
    static var previews: some View {
        AlternateFormView()
    }
}
