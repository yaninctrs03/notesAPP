//
//  Note.swift
//  NotesApp
//
//  Created by Yanin Contreras on 18/01/23.
//

import Foundation
import CoreLocation

class Note: ObservableObject, Identifiable {
    var id: String
    var userId: String
    @Published var title: String
    @Published var content: String
    var latitude: Double?
    var longitude: Double?
    var creationDate: Date
    var category: Int
    var coordinate: CLLocationCoordinate2D
    
    init(id: String?, userId: String, title: String, content: String, latitude: Double, longitude: Double, creationDate: Date?, category:Int){
        self.id = id ?? UUID().uuidString
        self.userId = userId
        self.title = title
        self.content = content
        self.latitude = latitude
        self.longitude = longitude
        self.creationDate = creationDate ?? Date()
        self.category = category
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
