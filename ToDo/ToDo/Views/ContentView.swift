//
//  ContentView.swift
//  ToDo
//
//  Created by Nikhi on 08/09/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI

enum CurrentSheet {
    case settings, addNewTask
}

struct ContentView: View {
    @EnvironmentObject var taskManger: TaskManager
    
    @State private var showSheet = false
    @State private var currentSheet: CurrentSheet = .settings
    @State var hideCompletedTasks: Bool = UserDefaults.standard.bool(forKey: Keys.hideCompletedTasksKey)
    
    
    
    @State var rebuildView: Bool = false
    
    @State private var filteredTasks = [Task]()
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView(showsIndicators: false) {
                    
                    ForEach(hideCompletedTasks ? taskManger.filteredTasks : taskManger.tasks, id: \.self.id) { task in
                            TaskView(task: task).environmentObject(self.taskManger)
                    }
                }.padding([.horizontal])
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        AddButton(showSheet: $showSheet, currentSheet: $currentSheet).padding([.trailing, .bottom])
                    }
                }
            }
            .navigationBarTitle("ToDo")
            .navigationBarItems(trailing: Button(action: {
                self.currentSheet = .settings
                self.showSheet.toggle()
            }, label: {
                Image(systemName: "gear")
                    .font(.system(size: 23))
                    .foregroundColor(.purple)
            }))
                .sheet(isPresented: $showSheet, onDismiss: filterTasks) {
                    if self.currentSheet == .settings {
                        SettingsView(hideCompletedTasks: self.$hideCompletedTasks)
                    } else {
                        AlternateFormView().environmentObject(self.taskManger)
                    }
            }
        }
    }
    
    func filterTasks() {
        taskManger.saveTasks()
    }
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


