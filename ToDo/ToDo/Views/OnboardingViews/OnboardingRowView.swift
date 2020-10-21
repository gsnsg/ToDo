//
//  OnboardingRowView.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI

struct OnboardingRowView: View {
    let title: String
    let subtitle: String
    let imageName: String
    
    var body: some View {
        
        HStack {
            Image(systemName: imageName)
                .font(.system(size: 50))
                .foregroundColor(Color.purple)
                .padding(.all)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                Text(subtitle)
                
            }
            Spacer()
        }
        .padding([.top, .leading, .trailing])
        
        
    }
}
