//
//  Persistence.swift
//  NotesApp
//
//  Created by Yanin Contreras on 10/01/23.
//

import CoreData

final class CoreDataInstance {
    let container = NSPersistentContainer(name: "NotesApp")
    
    static let shared = CoreDataInstance()

    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    static func saveContext() {
        if shared.container.viewContext.hasChanges {
            do {
                try shared.container.viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
