//
//  LoginSectionView.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import Foundation
import SwiftUI

enum TextType: String {
    case email = "email address", password = "password", name = "name"
}

struct LoginSectionView: View {
    
    @Binding var text: String
    
    let header: String
    let textType: TextType
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text(header)
                    .font(.system(size: 20, weight: .medium))
                Spacer()
            }
            
            if textType == .email || textType == .name {
                TextField("Enter \(textType.rawValue)", text: $text)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
            } else {
                SecureField("Enter \(textType.rawValue)", text: $text)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
            }
            
            
        }.padding([.top, .leading, .trailing])
    }
}



