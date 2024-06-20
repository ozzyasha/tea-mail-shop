//
//  FavoritesView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        ZStack {
            Color.additional
                .ignoresSafeArea()
            
            VStack {
                Text("Favorites Screen")
                    .padding()
                    .frame(maxHeight: .infinity)
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 10)
                    .background(.accent)
            }
            .font(.title2)
        }
    }
}

#Preview {
    FavoritesView()
}
