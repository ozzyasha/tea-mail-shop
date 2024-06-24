//
//  MainView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//

import SwiftUI

struct MainView: View {
    @StateObject
    var cartViewModel = CartViewModel()
    
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
                CartView()
                    .badge(cartViewModel.teaCart.count != 0 ? "\(cartViewModel.teaCart.count)" : nil)
                    .tabItem {
                        Label("Cart", systemImage: "cart.fill")
                    }
                AccountView()
                    .tabItem {
                        Label("Account", systemImage: "person.crop.circle.fill")
                    }
            }
            .tint(.white)
            .environmentObject(cartViewModel)
    }
}

#Preview {
    MainView()
}
