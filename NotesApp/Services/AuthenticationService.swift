//
//  AuthenticationService.swift
//  NotesApp
//
//  Created by Yanin Contreras on 18/01/23.
//

import Foundation
import SwiftUI

class AuthenticationService: ObservableObject, Authentication {
    @AppStorage("userId") var userId: String = ""
    
    private var userRepository = UserService()
    
    var isLoggedIn: Bool {
        get {
            return userId != ""
        }
    }

    func logIn(email: String, password: String, success: @escaping (Bool, String?) -> ()) {
        userRepository.getUser(with: (email, password)) { user, error in
            if let user = user {
                self.userId = user.id
                success(true, nil)
            } else {
                success(false, "User Not Found")
            }
        }
    }
    
    func logOut() {
        userId = ""
    }
    
}
