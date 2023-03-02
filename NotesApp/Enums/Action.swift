//
//  Action.swift
//  NotesApp
//
//  Created by Yanin Contreras on 1/31/23.
//

import Foundation
import UIKit

// 1
enum ActionType: String {
  case newNote = "NewNote"
}

// 2
enum Action: Equatable {
  case newNote

  // 3
  init?(shortcutItem: UIApplicationShortcutItem) {
    // 4
    guard let type = ActionType(rawValue: shortcutItem.type) else {
      return nil
    }

    // 5
    switch type {
    case .newNote:
      self = .newNote
    }
  }
}

// 6
class ActionService: ObservableObject {
  static let shared = ActionService()

  // 7
  @Published var action: Action?
}
