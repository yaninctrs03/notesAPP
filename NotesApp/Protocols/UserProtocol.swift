//
//  User.swift
//  NotesApp
//
//  Created by Yanin Contreras on 18/01/23.
//

import Foundation

protocol UserProtocol: Repository {
    func getUser(with credentials: (email: String, password: String), success: @escaping (User?, UserError?) -> ())
    func getUser(with userId: String, success: @escaping (User?, UserError?) -> ())
    func checkForExisting(email: String, success: @escaping (Bool) -> ())
}

enum UserError {
    case notFound
    case unknown
}
