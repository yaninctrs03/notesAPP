//
//  NotesApp.swift
//  NotesApp
//
//  Created by Yanin Contreras on 10/01/23.
//

import SwiftUI

@main
struct NotesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentManagerView()
        }
    }
}
