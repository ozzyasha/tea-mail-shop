//
//  SearchFieldView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 17.06.24.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding
    var searchRequest: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .padding(.leading)
                .foregroundStyle(.secondAdditional)
            TextField("Search", text: $searchRequest)
                .padding()
                .environment(\.colorScheme, .light)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
        }
        .background(Color.white)
        .frame(height: 35)
        .cornerRadius(15)
    }
}

#Preview {
    SearchFieldView(searchRequest: .constant(""))
}
