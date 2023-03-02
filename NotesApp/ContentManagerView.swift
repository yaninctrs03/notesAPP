//
//  ContentManagerView.swift
//  NotesApp
//
//  Created by Yanin Contreras on 03/02/23.
//

import SwiftUI

struct ContentManagerView: View {
    @StateObject var authentication = AuthenticationService()
    private let actionService = ActionService.shared
    
    var body: some View {
        if authentication.isLoggedIn {
            MainView()
                .transition(.slide)
                .environmentObject(authentication)
                .environmentObject(actionService)
        } else {
            LoginView()
                .environmentObject(authentication)
                .environmentObject(actionService)
        }
    }
}

struct ContentManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentManagerView()
    }
}
