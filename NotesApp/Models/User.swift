//
//  User.swift
//  NotesApp
//
//  Created by Yanin Contreras on 18/01/23.
//

import Foundation
import SwiftUI

class User: ObservableObject{
    var id: String = UUID().uuidString
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullName: String = ""
    @Published var phoneNumber: String = ""
    @Published var userImage: Image = Image(systemName: "person.crop.circle.fill")
    @Published var imageData: Data = Data()
    
    
}
