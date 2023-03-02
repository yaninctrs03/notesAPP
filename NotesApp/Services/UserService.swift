//
//  UserService.swift
//  NotesApp
//
//  Created by Yanin Contreras on 18/01/23.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

class UserService: ObservableObject, UserProtocol {
    
    private let context = CoreDataInstance.shared.container.viewContext
    typealias Domain = User
    
    func getUser(with credentials: (email: String, password: String), success: @escaping (User?, UserError?) -> ()) {
        let request  = NSFetchRequest<UserCD>(entityName: String(describing: UserCD.self))
        request.predicate = NSPredicate(format: "email = %@ AND password = %@", credentials.email, credentials.password)
        request.fetchLimit = 1
        do {
            let data = try context.fetch(request).first
            
            if let userCD = data {
                let user = User()
                user.id = userCD.id ?? ""
                user.email = userCD.email ?? ""
                user.fullName = userCD.name ?? ""
                user.password = userCD.password ?? ""
                user.phoneNumber = userCD.phoneNumber ?? ""
                user.imageData = userCD.imageData ?? Data()
                user.userImage = getImageForData(userCD.imageData ?? Data())  
                success(user, nil)
            }
            success(nil, .notFound)
            
        } catch {
            success(nil, .unknown)
        }
    }
    
    func getUser(with userId: String, success: @escaping (User?, UserError?) -> ()) {
        let request  = NSFetchRequest<UserCD>(entityName: String(describing: UserCD.self))
        request.predicate = NSPredicate(format: "id = %@", userId)
        request.fetchLimit = 1
        do {
            let data = try context.fetch(request).first
            
            if let userCD = data {
                let user = User()
                user.id = userCD.id ?? ""
                user.email = userCD.email ?? ""
                user.fullName = userCD.name ?? ""
                user.password = userCD.password ?? ""
                user.phoneNumber = userCD.phoneNumber ?? ""
                user.imageData = userCD.imageData ?? Data()
                user.userImage = getImageForData(userCD.imageData ?? Data())
                success(user, nil)
            }
            success(nil, .notFound)
            
        } catch {
            success(nil, .unknown)
        }
    }
    
    func checkForExisting(email: String, success: @escaping (Bool) -> ()) {
        let request  = NSFetchRequest<UserCD>(entityName: String(describing: UserCD.self))
        request.predicate = NSPredicate(format: "email = %@ ", email)
        request.fetchLimit = 1
        do {
            let data = try context.fetch(request).first
            if let _ = data {
                success(true)
            } else {
                success(false)
            }
        } catch {
            success(false)
        }
    }
    
    
    func save(_ domain: User, success: (Bool, RepositoryError?) -> ()) {
        let user = UserCD(context: context)
        user.id = domain.id
        user.email = domain.email
        user.name = domain.fullName
        user.password = domain.password
        user.phoneNumber = domain.phoneNumber
        CoreDataInstance.saveContext()
        success(true, nil)
    }
    
    func delete(_ domain: User, success: (Bool, RepositoryError?) -> ()) {
        if let user = getUser(with: domain.id) {
            CoreDataInstance.shared.container.viewContext.delete(user)
            CoreDataInstance.saveContext()
            success(true, nil)
        } else {
            success(false, .unknown)
        }
    }
    
    func update(_ domain: User, success: (Bool, RepositoryError?) -> ()) {
        if let user = getUser(with: domain.id) {
            user.email = domain.email
            user.password = domain.password
            user.name = domain.fullName
            user.phoneNumber = domain.phoneNumber
            user.imageData = domain.imageData
            CoreDataInstance.saveContext()
            success(true, nil)
        } else {
            success(false, .notFound)
        }
    }
        
    func getAll(success: ([User]?, RepositoryError?) -> ()) {
        let request = NSFetchRequest<UserCD>(entityName: String(describing: UserCD.self))
        do {
            var users = [User]()
            let items = try context.fetch(request)
            for item in items {
                let user = User()
                user.id = item.id ?? ""
                user.fullName = item.name ?? ""
                user.email = item.email ?? ""
                user.password = item.password ?? ""
                user.phoneNumber = item.phoneNumber ?? ""
                user.imageData = item.imageData ?? Data()
                user.userImage = getImageForData(item.imageData ?? Data())
                users.append(user)
            }
            success(users, nil)
        } catch {
            success(nil, .unknown)
        }
    }
    
    private func getUser(with userId: String) -> UserCD? {
        let request  = NSFetchRequest<UserCD>(entityName: String(describing: UserCD.self))
        request.predicate = NSPredicate(format: "id = %@", userId)
        request.fetchLimit = 1
        do {
            let domain = try context.fetch(request).first
            return domain
        } catch {
            return nil
        }
    }
    
    private func getImageForData(_ imageData: Data) -> Image {
        guard let uiImage = UIImage(data: imageData) else { return Image(systemName: "person.crop.circle.fill") }
        return Image(uiImage: uiImage)
    }
    
}
