//
//  LoginViewModel.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    
    // View Model Publisher used to dismiss view when user logs in successfully
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    
    // User Login Details
    @Published var emailAddress: String = ""
    @Published var password: String = ""
    
    // Show Sign Up View
    @Published var showSignUpView: Bool = false
    
    // User Alert Variables
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    func loginUser() {
        FirebaseManager.shared.login(email: emailAddress, password: password) { [weak self] (success, error) in
            guard error == nil else {
                self?.showAlert = true
                self?.alertTitle = "Oops!"
                self?.alertMessage = error!
                return
            }
            self?.viewDismissalModePublisher.send(true)
        }
    }
    
   
    
    func signUpButtonTapped() {
        self.showSignUpView = true
    }
}
