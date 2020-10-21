//
//  OnboardingView.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("ToDo")
                .font(.system(size: 40, weight: .bold))
                .padding(.all, 40)
            
            OnboardingRowView(title: "Never lose track", subtitle: "Write down your tasks so that you can remember them later", imageName: "square.and.pencil")
            OnboardingRowView(title: "Notifications", subtitle: "Get notfications about a task on required day and time ", imageName: "bell")
            OnboardingRowView(title: "Tasks Synchronization", subtitle: "Synchronize your tasks across multiple devices", imageName: "arrow.counterclockwise")
            
            Spacer()
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                UserDefaults.standard.setValue(true, forKey: Keys.firstTime)
            }, label: {
                Text("Continue")
                    .font(.system(size: 20, weight: .medium))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
            })
            .padding([.leading, .trailing, .bottom])
            
        }
        
    }
}
