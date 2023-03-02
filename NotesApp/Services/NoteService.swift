//
//  NoteService.swift
//  NotesApp
//
//  Created by Yanin Contreras on 23/01/23.
//

import Foundation
import CoreData

class NoteService: ObservableObject, NoteProtocol {
    
    private let context = CoreDataInstance.shared.container.viewContext
    typealias Domain = Note
    
    func getNotes(with category: Int, forUser userId: String, success: @escaping ([Note]?, NoteError?) -> ()) {
        getAll { notesResult, error in
            if let notes = notesResult{
                var filteredNotes = notes.filter { note in
                    note.userId == userId &&
                    note.category == category
                }
                filteredNotes.sort { note1, note2 in
                    note2.creationDate < note1.creationDate
                }
                success(filteredNotes, nil)
            }else{
                success(nil, .notFound)
            }
        }
    }
    
    func getAllNotes(forUser userId: String, success: @escaping ([Note]?, NoteError?) -> ()) {
        getAll { notesResult, error in
            if let notes = notesResult{
                var filteredNotes = notes.filter { note in
                    note.userId == userId
                }
                filteredNotes.sort { note1, note2 in
                    note2.creationDate < note1.creationDate
                }
                success(filteredNotes, nil)
            }else{
                success(nil, .notFound)
            }
        }
    }
    
    func checkExistingNote(with id: String, success: @escaping (Bool) -> ()) {
        let request = NSFetchRequest<NoteCD>(entityName: String(describing: NoteCD.self))
        request.predicate = NSPredicate(format: "id = %@", id)
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
    
    func save(_ domain: Note, success: (Bool, RepositoryError?) -> ()) {
        let note = NoteCD(context: context)
        note.id = domain.id
        note.title = domain.title
        note.content = domain.content
        note.category = Int16(domain.category)
        note.userId = domain.userId
        note.creationDate = domain.creationDate
        note.latitude = domain.latitude ?? 0.0
        note.longitude = domain.longitude ?? 0.0
        CoreDataInstance.saveContext()
        success(true, nil)
    }
    
    func delete(_ domain: Note, success: (Bool, RepositoryError?) -> ()) {
        let request = NSFetchRequest<NoteCD>(entityName: String(describing: NoteCD.self))
        request.predicate = NSPredicate(format: "id = %@", domain.id.description)
        request.fetchLimit = 1
        do {
            let data = try context.fetch(request).first
            if let note = data {
                CoreDataInstance.shared.container.viewContext.delete(note)
                CoreDataInstance.saveContext()
                success(true, nil)
            } else {
                success(false, .notFound)
            }
        } catch {
            success(false, .unknown)
        }
    }
    
    func update(_ domain: Note, success: (Bool, RepositoryError?) -> ()) {
        let request = NSFetchRequest<NoteCD>(entityName: String(describing: NoteCD.self))
        request.predicate = NSPredicate(format: "id = %@", domain.id.description)
        request.fetchLimit = 1
        do {
            let data = try context.fetch(request).first
            if let note = data {
                note.title = domain.title
                note.content = domain.content
                note.category = Int16(domain.category)
                CoreDataInstance.saveContext()
                success(true, nil)
            } else {
                success(false, .notFound)
            }
        } catch {
            success(false, .unknown)
        }
    }
    
    func getAll(success: ([Note]?, RepositoryError?) -> ()) {
        let request = NSFetchRequest<NoteCD>(entityName: String(describing: NoteCD.self))
        do {
            var notes = [Note]()
            let items = try context.fetch(request)
            for item in items {
                let note = Note(id: item.id,
                                userId: item.userId ?? "",
                                title: item.title ?? "",
                                content: item.content ?? "",
                                latitude: item.latitude,
                                longitude: item.longitude,
                                creationDate: item.creationDate,
                                category: Int(item.category))
                
                notes.append(note)
            }
            success(notes, nil)
        } catch {
            success(nil, .unknown)
        }
    }
   
}
