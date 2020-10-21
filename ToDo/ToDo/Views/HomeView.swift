//
//  HomeView.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI


enum CurrentSheet {
    case settings, addNewTask, none
}

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    @State var hideCompletedTasks: Bool = UserDefaults.standard.bool(forKey: Keys.hideCompletedTasksKey)
    
    
    @State private var filteredTasks = [Task]()
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView(showsIndicators: false) {

                    ForEach(homeViewModel.taskViewModels) { viewModel in
                        TaskView(taskViewModel: viewModel)
                    }
                }.padding([.horizontal])
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        AddButton(homeViewModel: homeViewModel).padding([.trailing, .bottom])
                    }
                }
            }
            .navigationBarTitle("ToDo")
            .navigationBarItems(trailing: Button(action: {
                self.homeViewModel.setShowSheet(sheet: .settings)
            }, label: {
                Image(systemName: "gear")
                    .font(.system(size: 23))
                    .foregroundColor(.purple)
            }))
            .sheet(isPresented: $homeViewModel.showSheet) {
                if self.homeViewModel.currentSheet == .settings {
                    SettingsView(hideCompletedTasks: self.$hideCompletedTasks)
                } else if self.homeViewModel.currentSheet == .addNewTask {
                    AddNewTaskView()
                }
            }
        }
    }
    
   
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
