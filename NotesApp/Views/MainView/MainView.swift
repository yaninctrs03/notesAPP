//
//  MainView.swift
//  NotesApp
//
//  Created by Yanin Contreras on 17/01/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authentication: AuthenticationService
    @EnvironmentObject var actionService: ActionService
    @StateObject private var viewModel = MainViewModel()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
                HStack(spacing: 0.0) {
                    TabsView(viewModel: viewModel)
                        .padding(.trailing, -15.0)
                    ContentView(viewModel: viewModel)
                        .frame(maxWidth: .infinity)
                }
            }
            .onAppear {
                self.viewModel.authentication = authentication
                viewModel.getNotes()
            }
            .onChange(of: scenePhase) { newValue in
              switch newValue {
              case .active:
                performActionIfNeeded()
              case .background:
                print("background")
              default:
                break
              }
            }
            .sheet(isPresented: $viewModel.isActionNoteTriggered) {
                NoteDetailView()
            }
        }
    }
    
    func performActionIfNeeded() {
      guard let action = actionService.action else { return }
      switch action {
      case .newNote:
          viewModel.isActionNoteTriggered = true
      }
      actionService.action = nil
    }
}

struct TabsView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 1.0) {
            TabItem(label: K.Tabs.all, active: viewModel.isAllSelected)
                .onTapGesture {
                    viewModel.changeSelectedNote(K.Tabs.all)
                }
            TabItem(label: K.Tabs.def, active: viewModel.isDefaultSelected)
                .onTapGesture {
                    viewModel.changeSelectedNote(K.Tabs.def)
                }
            TabItem(label: K.Tabs.image, active: viewModel.isImageSelected)
                .onTapGesture {
                    viewModel.changeSelectedNote(K.Tabs.image)
                }
            TabItem(label: K.Tabs.music, active: viewModel.isMusicSelected)
                .onTapGesture {
                    viewModel.changeSelectedNote(K.Tabs.music)
                }
            Spacer()
            NavigationLink(destination: MapView()) {
                MapTabItem()
            }
        }
        
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            Color("Content")
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.bottom)
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 40.0)
                    Spacer()
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: K.SystemImage.profileImage)
                            .resizable()
                            .foregroundColor(.accent)
                            .frame(width: 50.0, height: 50.0)
                    }
                }
                List {
                    ForEach($viewModel.notesList) { note in
                        NoteCellView(note: note)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    viewModel.deleteNote(note: note.wrappedValue)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.red)
                                }
                            }
                    }
                    .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                HStack {
                    Spacer()
                    NavigationLink(destination: NoteDetailView()) {
                        Image(systemName: K.SystemImage.newNote)
                            .resizable()
                            .foregroundColor(.accent)
                            .frame(width: 60.0, height: 60.0)
                    }
                    
                }
                
            }
            .padding(.horizontal)
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AuthenticationService())
            .environmentObject(ActionService())
    }
}
