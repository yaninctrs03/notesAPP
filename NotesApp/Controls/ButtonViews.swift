//
//  ButtonViews.swift
//  NotesApp
//
//  Created by Yanin Contreras on 12/01/23.
//

import SwiftUI

struct RoundedButton: View {
    var label: String
    var active: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 280.0, height: 50)
                .foregroundColor(buttonColor)
            Text(label)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.cream)
        }
    }
    
    var buttonColor: Color {
        return active ? .darkGreen : .gray
    }
}

struct LogOutView: View {
    var body: some View {
        HStack {
            Image(systemName: "power")
                .foregroundColor(.red)
                .fontWeight(.semibold)
            Text("Log Out")
                .foregroundColor(.red)
                .fontWeight(.semibold)
        }
    }
}

struct ButtonViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoundedButton(label: "Log In", active: true)
            LogOutView()
        }
    }
}
