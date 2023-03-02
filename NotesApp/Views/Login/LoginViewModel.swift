//
//  LoginViewModel.swift
//  NotesApp
//
//  Created by Yanin Contreras on 12/01/23.
//

import Foundation
import SwiftUI

extension LoginView {
    @MainActor class ViewModel: ObservableObject {
        @Published var isLogged = false
        @Published var email = ""
        @Published var password = ""
        @Published var isAlertShown = false
        @Published var isLogging = false
        
        var authentication: AuthenticationService?
        
        
        func areFieldsValid() -> Bool{
            return email.isValidEmail && !password.isEmpty
        }
        
        func makeLogin(){
            isLogging = true
            authentication?.logIn(email: email, password: password.encrypt) { success, error in
                if !success {
                    self.isAlertShown = true
                }
                self.isLogging = false
            }
        }
        
        func clearFields() {
            email = ""
            password = ""
        }
    }
}
