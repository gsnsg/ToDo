//
//  AlternateFormView.swift
//  ToDo
//
//  Created by Nikhi on 08/09/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI
import UserNotifications

struct AddNewTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var addNewTaskViewModel = AddNewTaskViewModel()
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("GENERAL INFO")) {
                    TextField("Task Name", text: $addNewTaskViewModel.taskName)
                }
                
                Section(header: Text("PRIORITY")) {
                    Picker(selection: $addNewTaskViewModel.currentPriority, label: Text("Priority")) {
                        ForEach(addNewTaskViewModel.priorities, id: \.self) { priority in
                            Text(priority.capitalized)
                            
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("NOTIFICATION")) {
                    Toggle("Show Reminder", isOn: $addNewTaskViewModel.showNotification.animation())
                    if addNewTaskViewModel.showNotification {
                        DatePicker("Please select a time", selection: $addNewTaskViewModel.date, displayedComponents: [.date, .hourAndMinute])
                    }
                    
                }
                HStack {
                    Spacer()
                    Button("Save") {
                        self.addNewTaskViewModel.addTask()
                        self.presentationMode.wrappedValue.dismiss()
                    }.disabled(addNewTaskViewModel.taskName.count == 0)
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
        AddNewTaskView()
    }
}
