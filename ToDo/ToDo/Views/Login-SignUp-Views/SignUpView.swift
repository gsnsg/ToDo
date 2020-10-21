//
//  SignUpView.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        ScrollView {
            Image("LoginImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            VStack {
                LoginSectionView(text: $signUpViewModel.name, header: "Name", textType: .name)
                LoginSectionView(text: $signUpViewModel.emailAddress, header: "Email address", textType: .email)
                LoginSectionView(text: $signUpViewModel.password, header: "Password", textType: .password)
                
                
                Button(action: {
                    signUpViewModel.signUpUser()
                }, label: {
                    Text("Sign Up")
                        .font(.system(size: 20, weight: .medium))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                })
                .padding(.top, 30)
                .padding([.leading, .trailing])
                
                
            }.navigationBarTitle(Text("Sign Up"), displayMode: .inline)
            .alert(isPresented: $signUpViewModel.showAlert) {
                Alert(title: Text(signUpViewModel.alertTitle), message: Text(signUpViewModel.alertMessage), dismissButton: .default(Text("Okay")))
            }
            .onReceive(signUpViewModel.viewDismissalModePublisher) { (dismissView) in
                if dismissView {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            SignUpView().navigationTitle(Text("Sign Up"))
        }
        
        
    }
}

