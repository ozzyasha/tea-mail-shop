//
//  tea_mail_shopApp.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 5.06.24.
//

import SwiftUI
import FirebaseCore

@main
struct tea_mail_shopApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ViewCoordinator()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
