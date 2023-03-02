//
//  Repository.swift
//  NotesApp
//
//  Created by Yanin Contreras on 16/01/23.
//

import Foundation

protocol Repository {
    associatedtype Domain
    
    func save(_ domain: Domain, success: (Bool, RepositoryError?) -> ())
    func delete(_ domain: Domain, success: (Bool, RepositoryError?) -> ())
    func update(_ domain: Domain, success: (Bool, RepositoryError?) -> ())
    func getAll(success: ([Domain]?, RepositoryError?) -> ())
}

enum RepositoryError: Error {
    case notFound
    case unknown
}
