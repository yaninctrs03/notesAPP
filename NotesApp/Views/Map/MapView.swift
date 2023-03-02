//
//  MapView.swift
//  NotesApp
//
//  Created by Yanin Contreras on 25/01/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var authentication: AuthenticationService
    @StateObject private var viewModel = ViewModel()
    @State private var region: MKCoordinateRegion
    
    init() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        let currentLocation = locationManager.location
        let center = CLLocationCoordinate2D(latitude: currentLocation?.coordinate.latitude ?? 0, longitude: currentLocation?.coordinate.longitude ?? 0)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        _region = State(initialValue: region)
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: viewModel.notesList, annotationContent: { note in
                MapAnnotation(coordinate: note.coordinate) {
                    Image(systemName: "pin.fill")
                        .foregroundColor(.red)
                }
            })
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            self.viewModel.authentication = authentication
            viewModel.getNotes()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(AuthenticationService())
    }
}
