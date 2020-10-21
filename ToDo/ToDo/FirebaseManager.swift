//
//  FirebaseManager.swift
//  ToDo
//
//  Created by Nikhi on 21/10/20.
//  Copyright © 2020 nikhit. All rights reserved.
//

import SwiftUI
import Firebase

final class FirebaseManager: ObservableObject {
    static let shared = FirebaseManager()
    
    // Tells if the  user has been logged in or not
    @Published var userLoggedIn: Bool = Firebase.Auth.auth().currentUser != nil
    
    // Database Reference
    private let  ref = Database.database().reference()
    
    
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.lowercased().replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    func signUp(name: String, emailAddress: String, password: String, completion: @escaping((Bool, String?) -> Void)) {
        
        ref.child("users/").observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let usersDictionary = snapshot.value as? [String : Any] else {
                completion(false, "Failed to fetch users snapshot")
                return
            }
            
            let safeEmail = Self.safeEmail(emailAddress: emailAddress)
            guard usersDictionary[safeEmail] == nil else {
                completion(false, "User Already Exists")
                return
            }
            
            Auth.auth().createUser(withEmail: emailAddress, password: password) { (result, error) in
                guard error == nil else {
                    completion(false, error!.localizedDescription)
                    return
                }
                self?.ref.child("users/\(safeEmail)").updateChildValues(["name": name, "email" : emailAddress])
                withAnimation {
                    self?.userLoggedIn = true
                }
                self?.storeUserData(name: name, email: safeEmail)
                completion(true, nil)
            }
        }
        
    }
    
    func login(email: String, password: String, completion: @escaping((Bool, String?) -> Void)) {
        
        let safeEmail = Self.safeEmail(emailAddress: email)
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard error == nil else {
                completion(false, error!.localizedDescription)
                return
            }
            self?.ref.child("users/\(safeEmail)").observeSingleEvent(of: .value) { (snapshot) in
                guard let userDictionary = snapshot.value as? [String : String] else {
                    completion(false, "Failed to find user in database")
                    return
                }
                guard let userName = userDictionary["name"] else {
                    completion(false, "UserName nil found")
                    return
                }
                self?.storeUserData(name: userName, email: safeEmail)
                withAnimation {
                    self?.userLoggedIn = true
                }
                
            }
        }
    }
    
    func logoutUser(completion: @escaping((Bool, String?) -> Void)) {
        do {
            try Auth.auth().signOut()
            self.userLoggedIn = false
            completion(true, nil)
        } catch {
            completion(false, error.localizedDescription)
        }
    }
    
    // Store name and email whenever user logs in or signs up
    private func storeUserData(name: String, email: String) {
        UserDefaults.standard.set(name, forKey: Keys.loggedInUserName)
        UserDefaults.standard.set(email, forKey: Keys.safeEmail)
    }
}



//MARK: - Database Methods
extension FirebaseManager {

    
    func updateTask(task: Task) {
        if let safeEmail = UserDefaults.standard.string(forKey: Keys.safeEmail) {
            ref.child("tasks/\(safeEmail)/\(task.id)").updateChildValues(task.dictionary) { (error, red) in
                guard error == nil else {
                    print("Database save fail")
                    return
                }
                
            }
        }
    }
    
    
    func deleteTask(forId taskId: String) {
        if let safeEmail = UserDefaults.standard.string(forKey: Keys.safeEmail) {
            ref.child("tasks/\(safeEmail)/\(taskId)").removeValue()
        }
    }
}
