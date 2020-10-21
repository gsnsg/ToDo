//
//  SettingsView.swift
//  ToDo
//
//  Created by Nikhi on 08/09/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    
    @Binding var hideCompletedTasks: Bool
    
    @State private var emailAddress = ""
    @State private var password = ""
    
    @State private var userLoggedIn = false
    var body: some View {
        NavigationView {
            Form {
                Toggle("Hide completed tasks", isOn: $hideCompletedTasks).onReceive([self.hideCompletedTasks].publisher.first()) { (value) in
                    UserDefaults.standard.set(value, forKey: Keys.hideCompletedTasksKey)
                }
                
                Button {
                    FirebaseManager.shared.logoutUser { (success, error) in
                        guard error == nil else {
                            return
                        }
                        print("Came Here")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Sign Out")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }

            }.navigationBarTitle("Settings")
                .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done")
                }))
            
        }
        
    }
}
