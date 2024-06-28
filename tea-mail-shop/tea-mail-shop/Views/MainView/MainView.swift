//
//  MainView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//

import SwiftUI

struct MainView: View {
    @StateObject
    private var cartViewModel = CartViewModel()
    @StateObject
    private var tabViewModel = TabViewModel()
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.additional
        UITabBar.appearance().backgroundColor = .accent
    }
    
    var body: some View {
        TabView(selection: $tabViewModel.selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(TabViewModel.Tab.home)
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass.circle.fill")
                    }
                    .tag(TabViewModel.Tab.search)
                CartView()
                    .badge(cartViewModel.teaCart.count != 0 ? "\(cartViewModel.teaCart.count)" : nil)
                    .tabItem {
                        Label("Cart", systemImage: "cart.fill")
                    }
                    .tag(TabViewModel.Tab.cart)
                AccountView()
                    .tabItem {
                        Label("Account", systemImage: "person.crop.circle.fill")
                    }
                    .tag(TabViewModel.Tab.account)
            }
            .tint(.white)
            .environmentObject(cartViewModel)
            .environmentObject(tabViewModel)
    }
}

#Preview {
    MainView()
}
