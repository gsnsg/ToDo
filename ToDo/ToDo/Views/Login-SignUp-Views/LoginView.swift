//
//  LoginView.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    // View Model for Login View
    @StateObject var loginViewModel = LoginViewModel()
    
    
    
    var body: some View {
        NavigationView{
            ScrollView {
                Image("LoginImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                VStack {
                    LoginSectionView(text: $loginViewModel.emailAddress, header: "Email address", textType: .email)
                    LoginSectionView(text: $loginViewModel.password, header: "Password", textType: .password)
                    
                    Button(action: {
                        loginViewModel.loginUser()
                    }, label: {
                        Text("Login")
                            .font(.system(size: 20, weight: .medium))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    })
                    .padding(.top, 30)
                    .padding([.leading, .trailing])
                    
                    NavigationLink(destination: SignUpView(),isActive: $loginViewModel.showSignUpView) {}
                    
                    HStack(alignment: .center) {
                        Text("Don't have an account?")
                            .font(.system(size: 15, weight: .light))
                        Button(action: {
                            loginViewModel.signUpButtonTapped()
                        }) {
                            Text("Sign Up")
                                .font(.system(size: 15))
                        }
                    }.padding(.top)
                }
                
            }.navigationBarTitle(Text("Login"))
            .alert(isPresented: $loginViewModel.showAlert) {
                Alert(title: Text(loginViewModel.alertTitle), message: Text(loginViewModel.alertMessage), dismissButton: .default(Text("Okay")))
            }
            .onReceive(loginViewModel.viewDismissalModePublisher) { (dismissView) in
                if dismissView {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            
        }
    }
}





struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

