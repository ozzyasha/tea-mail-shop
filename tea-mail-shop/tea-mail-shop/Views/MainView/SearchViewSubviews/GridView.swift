//
//  GridView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import SwiftUI

struct GridView: View {
    
    @ObservedObject
    var searchViewModel: SearchFieldViewModel
    @State
    private var columns: [GridItem] = [
        GridItem(.flexible(minimum: 100, maximum: 500)),
        GridItem(.flexible(minimum: 100, maximum: 500)),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 10,
                      pinnedViews: [.sectionHeaders, .sectionFooters]
            ) {
                ForEach(searchViewModel.searchResults, id: \.id) { tea in
                    TeaViewGridCell(tea: tea)
                }
            }
            .padding()
        }
        .listStyle(.plain)
        .background(.additional)
        .buttonStyle(.borderless)
    }
}

#Preview {
    GridView(searchViewModel: SearchFieldViewModel(teaVM: TeaViewModel()))
}
