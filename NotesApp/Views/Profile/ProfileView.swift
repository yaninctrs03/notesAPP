//
//  ProfileView.swift
//  NotesApp
//
//  Created by Yanin Contreras on 24/01/23.
//

import SwiftUI
import PhotosUI
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authentication: AuthenticationService
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 20.0) {
                InfoSection(viewModel: viewModel )
                Section(label: "Preferences")
                PreferencesSection(viewModel: viewModel)
                Divider()
                Button {
                    viewModel.logOut()
                } label: {
                    LogOutView()
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.vertical)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        switch(viewModel.isEditable) {
                        case true: viewModel.saveUser()
                        case false: viewModel.isEditable = true
                        }
                    } label: {
                        viewModel.isEditable ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "pencil.line")
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.authentication = authentication
        }
    }
}

struct InfoSection: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            HStack(alignment: .center, spacing: 20.0) {
                ProfileImageView(viewModel: viewModel)
                    .overlay(alignment: .bottomTrailing) {
                        PhotosPicker(selection: $viewModel.imageSelection) {
                            Image(systemName: "pencil.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30))
                                .foregroundColor(.accentColor)
                        }
                    }
                if viewModel.isEditable {
                    TextField("", text: $viewModel.user.fullName)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.name)
                        .submitLabel(.next)
                        .autocapitalization(.words)
                        .keyboardType(.default)
                        .padding(.horizontal)
                        .placeholder("Full Name", when: viewModel.user.fullName.isEmpty)
                } else {
                    Text(viewModel.user.fullName)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            ProfileItem(iconName: "envelope", input: $viewModel.user.email, isEditing: $viewModel.isEditable)
            ProfileItem(iconName: "phone", input: $viewModel.user.phoneNumber, isEditing: $viewModel.isEditable)

        }
        .padding(.horizontal, 20)

    }
}

struct PreferencesSection: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15.0) {
            Text("System color")
            Picker("System Color", selection: $viewModel.systemPreference) {
                Text("Light").tag(UIUserInterfaceStyle.light.rawValue)
                Text("Dark").tag(UIUserInterfaceStyle.dark.rawValue)
                Text("System").tag(UIUserInterfaceStyle.unspecified.rawValue)
            }
            .onChange(of: viewModel.systemPreference, perform: { newValue in
                viewModel.changeSystemColor(with: newValue)
            })
            .pickerStyle(.segmented)
//            Toggle(isOn: $viewModel.isBiometricEnabled) {
//                Text("FaceID/TouchID")
//            }.tint(.accent)
        }
        .padding(.horizontal, 20)

    }
}

struct ProfileImageView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        switch viewModel.imageState {
        case .success(let image):
            image.resizable()
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                
        case .loading:
            ProgressView()
                .frame(width: 80, height: 80)
        case .empty:
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .opacity(0.8)
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
        case .failure:
            Image(systemName: "questionmark.circle.fill")
                .resizable()
                .opacity(0.8)
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthenticationService())
    }
}


