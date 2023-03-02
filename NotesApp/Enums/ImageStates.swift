//
//  ImageStates.swift
//  NotesApp
//
//  Created by Yanin Contreras on 09/02/23.
//

import Foundation
import SwiftUI
import PhotosUI

enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case failure(Error)
}

enum TransferError: Error {
    case importFailed
}

struct ProfileImage: Transferable {
    let image: Image
    let imageData: Data
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
        #if canImport(AppKit)
            guard let nsImage = NSImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(nsImage: nsImage)
            return ProfileImage(image: image, imageData: data)
        #elseif canImport(UIKit)
            guard let uiImage = UIImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(uiImage: uiImage)
            return ProfileImage(image: image, imageData: data)
        #else
            throw TransferError.importFailed
        #endif
        }
    }
}
