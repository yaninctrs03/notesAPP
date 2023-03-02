//
//  NoteProtocol.swift
//  NotesApp
//
//  Created by Yanin Contreras on 23/01/23.
//

import Foundation

protocol NoteProtocol: Repository {
    func getNotes(with category: Int, forUser userId: String, success: @escaping ([Note]?, NoteError?) -> ())
    func getAllNotes(forUser userId: String, success: @escaping ([Note]?, NoteError?) -> ())
    func checkExistingNote(with id:String, success: @escaping (Bool) -> ())
}

enum NoteError {
    case notFound
    case unknown
}
