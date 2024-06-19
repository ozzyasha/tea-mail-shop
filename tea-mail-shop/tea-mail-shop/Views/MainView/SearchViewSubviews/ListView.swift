//
//  ListViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject
    var searchViewModel: SearchFieldViewModel
    
    var body: some View {
        List(searchViewModel.searchResults, id: \.id) { tea in
                TeaViewListCell(tea: tea)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .frame(maxHeight: .infinity)
        .listStyle(.plain)
        .background(.additional)
        .buttonStyle(.borderless)
    }
        
}

//#Preview {
//    ListView(vm: TeaViewModel())
//}
