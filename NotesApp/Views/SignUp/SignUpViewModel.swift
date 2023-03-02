//
//  SignUpViewModel.swift
//  NotesApp
//
//  Created by Yanin Contreras on 17/01/23.
//

import Foundation
import SwiftUI

extension SignUpView{
    @MainActor class ViewModel: ObservableObject {
        @Published var fullName = ""
        @Published var email = ""
        @Published var password = ""
        @Published var isAlertShown = false
        @Published var alertMessage = ""
        @Published var isLoading = false
        
        
        var authentication: AuthenticationService?
        var userService = UserService()
        
        func areFieldsValid() -> Bool{
            return email.isValidEmail && !password.isEmpty && !fullName.isEmpty
        }
        
        func validateUser(){
            isLoading = true
            userService.checkForExisting(email: email) { userExists in
                if !userExists {
                    self.createUser()
                } else {
                    self.isLoading = false
                    self.alertMessage = "This email is already registered, please Log In"
                    self.isAlertShown = true
                }
            }
        }
        
        private func createUser(){
            let user = User()
            user.email = email
            user.fullName = fullName
            user.password = password.encrypt
            userService.save(user) { success, error in
                if success {
                    self.isLoading = false
                    self.alertMessage = "User successfully created, please Log In"
                    self.isAlertShown = true
                }
            }
        }
        
    }
    
}
