//
//  MainViewModel.swift
//  NotesApp
//
//  Created by Yanin Contreras on 17/01/23.
//

import Foundation

@MainActor class MainViewModel: ObservableObject {
    @Published var title = "All Notes"
    @Published var isAllSelected = true
    @Published var isDefaultSelected = false
    @Published var isImageSelected = false
    @Published var isMusicSelected = false
    @Published var notesList = [Note]()
    @Published var isActionNoteTriggered = false
    var authentication: AuthenticationService?
    var noteService = NoteService()
    
    func changeSelectedNote(_ option: String){
        title = option.elementsEqual(K.Tabs.all) ? K.Tabs.allNotes : option
        isAllSelected = option.elementsEqual(K.Tabs.all)
        isDefaultSelected = option.elementsEqual(K.Tabs.def)
        isImageSelected = option.elementsEqual(K.Tabs.image)
        isMusicSelected = option.elementsEqual(K.Tabs.music)
        
        if(option.elementsEqual(K.Tabs.all)){
            getNotes()
        } else {
            let category = getReturnValue(for: option)
            filterNotes(by: category)
        }
    }
    
    func filterNotes(by category: Int){
        noteService.getNotes(with: category, forUser: authentication!.userId) { notes, error in
            if let notesResult = notes{
                self.notesList = notesResult
            }
        }
    }
    
    func getNotes(){
        noteService.getAllNotes(forUser: authentication!.userId) { notes, error in
            if let notesResult = notes{
                self.notesList = notesResult
            }
        }
    }
    
    func deleteNote(note: Note){
        noteService.delete(note) { success, error in
            if success {
                print("deleted")
            }
        }
    }
    
    func getReturnValue(for value: String) -> Int {
        switch value {
        case "Default":
            return K.Category.Default.rawValue
        case "Image":
            return K.Category.Image.rawValue
        case "Music":
            return K.Category.Music.rawValue
        default:
            return -1
        }
    }
}

