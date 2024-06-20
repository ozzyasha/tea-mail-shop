//
//  MainView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.additional
        UITabBar.appearance().backgroundColor = .accent
    }
    
    var body: some View {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass.circle.fill")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
                AccountView()
                    .badge("+")
                    .tabItem {
                        Label("Account", systemImage: "person.crop.circle.fill")
                    }
            }
            .tint(.white)
    }
}

#Preview {
    MainView()
}
