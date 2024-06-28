//
//  TabViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 25.06.24.
//

import Foundation

class TabViewModel: ObservableObject {
    @Published var selectedTab: Tab = .home
    enum Tab {
        case home, search, cart, account
    }
}
