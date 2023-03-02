//
//  ProfileViewModel.swift
//  NotesApp
//
//  Created by Yanin Contreras on 24/01/23.
//

import Foundation
import SwiftUI
import PhotosUI
import CoreTransferable

@MainActor class ProfileViewModel: ObservableObject {
    var authentication: AuthenticationService?
    var userId = UserDefaults.standard.string(forKey: "userId")
    var userService = UserService()
    var imageData = Data()
    
    @Published var user = User()
    @Published var isEditable = false
    @AppStorage("LastStyle") var systemPreference = UserDefaults.standard.integer(forKey: "LastStyle")
    @Published var isBiometricEnabled = false
    @Published private(set) var imageState: ImageState = .empty
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    
    init() {
        if let id = userId {
            userService.getUser(with: id) { userResult, error in
                if let user = userResult {
                    self.user = user
                    
                    guard let uiImage = UIImage(data: user.imageData) else { return }
                    user.userImage = Image(uiImage: uiImage)
                    self.imageState = .success(user.userImage)
                }
            }
        }
        
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ProfileImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let profileImage?):
                    self.imageState = .success(profileImage.image)
                    self.saveUserImage(profileImage)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
    
    func saveUserImage(_ profileImage: ProfileImage) {
        self.user.userImage = profileImage.image
        self.user.imageData = profileImage.imageData
        saveUser()
    }
    
    func logOut() {
        authentication?.logOut()
    }
    
    func saveUser() {
        userService.update(user) { success, error in
            print("Success: \(success)")
            isEditable = false
        }
    }
    
    func changeSystemColor(with preference: Int){
        switch preference {
        case 1:
            SceneDelegate.shared?.window!.overrideUserInterfaceStyle = .light
        case 2:
            SceneDelegate.shared?.window!.overrideUserInterfaceStyle = .dark
        default:
            SceneDelegate.shared?.window!.overrideUserInterfaceStyle = .unspecified
        }
    }
    
}

