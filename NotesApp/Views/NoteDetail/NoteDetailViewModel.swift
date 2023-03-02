//
//  NoteDetailViewModel.swift
//  NotesApp
//
//  Created by Yanin Contreras on 18/01/23.
//

import Foundation
import SwiftUI
import MapKit


extension NoteDetailView {
    @MainActor class ViewModel: ObservableObject {
        @Published var note: Note
        @Published var isToastVisible = false
        @Published var locationService = LocationService()
        
        var userId = UserDefaults.standard.string(forKey: "userId")
        var noteService = NoteService()
        
        init() {
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            let currentLocation = locationManager.location
            note = Note(id: nil, userId: userId ?? "", title: "", content: "", latitude: currentLocation?.coordinate.latitude ?? 0, longitude: currentLocation?.coordinate.longitude ?? 0, creationDate: nil, category: 0)
        }
        
        func checkExistingNote() {
            noteService.checkExistingNote(with: note.id.description) { exists in
                if exists {
                    self.updateNote()
                } else {
                    self.saveNote()
                }
            }
        }
        
        private func saveNote() {
            noteService.save(note) { success, error in
                if(success){
                    isToastVisible = success
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.isToastVisible = false
                    }
                }
            }
        }
        
        private func updateNote() {
            noteService.update(note) { success, error in
                if(success){
                    isToastVisible = success
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.isToastVisible = false
                    }
                }
            }
        }
        
        func setLocation() {
//            if let location = locationService.location {
//                note.latitude = location.latitude
//                note.longitude = location.longitude
//            }
        }
    }
}
