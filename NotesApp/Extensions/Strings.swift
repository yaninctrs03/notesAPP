//
//  Strings.swift
//  NotesApp
//
//  Created by Yanin Contreras on 16/01/23.
//

import Foundation
import CommonCrypto
import CryptoKit

extension String {
    
    var emailRegex: String {
        get {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            return emailRegEx
        }
    }
    
    var isValidEmail: Bool {
        get {
            let emailPred = NSPredicate(format:"SELF MATCHES %@", self.emailRegex)
            return emailPred.evaluate(with: self)
        }
    }
    
    var encrypt: String {
        get {
            let passwordData = CryptoKit.SHA256.hash(data: self.data(using: .utf8)!)
            return passwordData.description
        }
    }

    
}
