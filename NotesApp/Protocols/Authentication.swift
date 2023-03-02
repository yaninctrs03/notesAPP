//
//  Authentication.swift
//  NotesApp
//
//  Created by Yanin Contreras on 18/01/23.
//

import Foundation

protocol Authentication {
    func logIn(email: String, password: String, success: @escaping (Bool, String?)->())
    func logOut()
    var isLoggedIn: Bool { get }
}
