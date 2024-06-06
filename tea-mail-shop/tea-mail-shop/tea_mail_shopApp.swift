//
//  tea_mail_shopApp.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 5.06.24.
//

import SwiftUI

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
