//
//  NoteDetailView.swift
//  NotesApp
//
//  Created by Yanin Contreras on 18/01/23.
//

import SwiftUI

struct NoteDetailView: View {
    var note: Note?
    @EnvironmentObject var authentication: AuthenticationService
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            Image("LinedPaper")
                .resizable()
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.bottom)
            VStack {
                Picker("", selection: $viewModel.note.category) {
                    Text("Default").tag(0)
                    Text("Image").tag(1)
                    Text("Music").tag(2)
                }
                .pickerStyle(.segmented)
                TextField("", text: $viewModel.note.title)
                    .font(.title)
                    .bold()
                    .placeholder("New Note", when: viewModel.note.title.isEmpty, withFont: .title.bold(), withHorizontalSpacing: 0.0)
                TextEditor(text: $viewModel.note.content)
                    .scrollContentBackground(.hidden)
                    .placeholder("Content", when: viewModel.note.content.isEmpty, withVerticalSpacing: 8.0, withHorizontalSpacing: 3.0)
                Spacer()
            }
            .padding(.all)
            if(viewModel.isToastVisible){
                ToastView(isShowing: true, message: "Note Saved")
                    .transition(.scale)
            }
        }
        .onAppear {
            if let existingNote = note {
                viewModel.note = existingNote
            }
            viewModel.locationService.requestLocation()
            viewModel.locationService.requestAuthorisation()
            viewModel.setLocation()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    viewModel.checkExistingNote()
                }
            }
        }
        
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView()
    }
}
