//
//  ListViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject
    var vm: TeaViewModel
    @Binding
    var searchText: String
    
    var searchResults: [TeaCatalogueModel] {
        if searchText.isEmpty {
            return vm.teaCatalogueModel
        } else {
            return vm.teaCatalogueModel.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        List(searchResults, id: \.id) { tea in
                TeaViewListCell(tea: tea)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .frame(maxHeight: .infinity)
        .listStyle(.plain)
        .background(.additional)
        .buttonStyle(.borderless)
        .searchable(text: $searchText)
    }
        
}

//#Preview {
//    ListView(vm: TeaViewModel())
//}
