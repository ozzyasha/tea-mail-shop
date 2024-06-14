//
//  SearchView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            Color.additional
                .ignoresSafeArea()
            
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(maxHeight: .infinity)
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 10)
                    .background(.secondAdditional)
            }
            .font(.title2)
        }
    }
}

#Preview {
    SearchView()
}
