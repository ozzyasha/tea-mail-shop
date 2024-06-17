//
//  SearchFieldView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 17.06.24.
//

import SwiftUI

struct SearchFieldView: View {
    @State
    private var searchRequest = ""
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .padding(.leading)
                .foregroundStyle(.secondAdditional)
            TextField("Search", text: $searchRequest)
                .padding()
        }
        .background(Color.white)
        .frame(height: 35)
        .cornerRadius(15)
    }
}

#Preview {
    SearchFieldView()
}
