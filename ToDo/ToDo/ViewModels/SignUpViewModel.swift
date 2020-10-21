//
//  SignUpViewModel.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import Foundation
import Combine

final class SignUpViewModel: ObservableObject {
    
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    
    // User Details
    @Published var name: String = ""
    @Published var emailAddress: String = ""
    @Published var password: String = ""
    
    
    // User Alert Variables
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    
    func signUpUser() {
        FirebaseManager.shared.signUp(name: name, emailAddress: emailAddress, password: password) { [weak self] (success, error) in
            guard error == nil else {
                self?.showAlert = true
                self?.alertTitle = "Oops!"
                self?.alertMessage = error!
                return
            }
            self?.viewDismissalModePublisher.send(true)
        }
    }
    
}
