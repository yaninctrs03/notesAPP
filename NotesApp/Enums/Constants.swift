//
//  Constants.swift
//  NotesApp
//
//  Created by Yanin Contreras on 17/01/23.
//

import Foundation

enum K {
    enum Tabs {
        public static let allNotes = "All Notes"
        public static let all = "All "
        public static let def = "Default"
        public static let image = "Image"
        public static let music = "Music"
        public static let map = "Map"
    }
    
    enum Category: Int {
        case Default = 0
        case Image = 1
        case Music = 2
    }
    
    enum Field {
        case name
        case email
        case password
    }

    enum SystemImage {
        public static let profileImage = "person.crop.circle.fill"
        public static let newNote = "plus.circle.fill"
        
        
    }
}
