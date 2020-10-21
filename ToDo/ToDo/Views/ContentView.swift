//
//  ContentView.swift
//  ToDo
//
//  Created by Nikhi on 08/09/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    @State var showOnboardingScreen = !UserDefaults.standard.bool(forKey: Keys.firstTime)
    
    @StateObject var manager = FirebaseManager.shared
    
    @State private var present = false
    var body: some View {
        if manager.userLoggedIn {
            HomeView()
        } else {
            LoginView()
                .sheet(isPresented: $showOnboardingScreen) { 
                    OnboardingView()
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


