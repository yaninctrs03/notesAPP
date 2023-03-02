//
//  MapViewModel.swift
//  NotesApp
//
//  Created by Yanin Contreras on 25/01/23.
//

import Foundation

extension MapView {
    @MainActor class ViewModel: ObservableObject {
        @Published var notesList = [Note]()
        var authentication: AuthenticationService?
        var noteService = NoteService()
        
        func getNotes(){
            noteService.getAllNotes(forUser: authentication!.userId) { notes, error in
                if let notesResult = notes{
                    self.notesList = notesResult
                }
            }
        }
        
    }
}
