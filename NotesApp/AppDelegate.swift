//
//  AppDelegate.swift
//  NotesApp
//
//  Created by Yanin Contreras on 1/31/23.
//

import UIKit
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    private let actionService = ActionService.shared
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        if let shortcutItem = options.shortcutItem {
            actionService.action = Action(shortcutItem: shortcutItem)
        }
        
        let configuration = UISceneConfiguration(
            name: connectingSceneSession.configuration.name,
            sessionRole: connectingSceneSession.role
        )
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
}

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?
    private let actionService = ActionService.shared
    private(set) static var shared: SceneDelegate?
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        actionService.action = Action(shortcutItem: shortcutItem)
        completionHandler(true)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Self.shared = self
        
        let contentView = ContentManagerView()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            // restore from defaults initial or previously stored style
            let style = UserDefaults.standard.integer(forKey: "LastStyle")
            window.overrideUserInterfaceStyle = (style == 0 ? .dark : UIUserInterfaceStyle(rawValue: style)!)
            
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
