//
//  AddButton.swift
//  ToDo
//
//  Created by Nikhi on 08/09/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI

struct AddButton: View {
    
    @Binding var showSheet: Bool
    @Binding var currentSheet: CurrentSheet
    
    var body: some View {
        Button(action: {
            self.showSheet.toggle()
            self.currentSheet = .addNewTask
        }) {
            Image(systemName: "plus")
                .font(.system(size: 30))
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
}
