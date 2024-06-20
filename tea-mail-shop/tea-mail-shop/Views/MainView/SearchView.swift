//
//  SearchView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//

import SwiftUI

struct SearchView: View {
    @StateObject
    private var searchVM = SearchFieldViewModel(teaVM: TeaViewModel())
    @State
    private var searchText = ""
    @State
    var isGrid = false
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.additional.ignoresSafeArea()
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        SearchFieldView(searchRequest: $searchText)
                            .padding(.leading)
                        Spacer()
                        Toggle(isOn: $isGrid) {
                            Image(systemName: isGrid ? "rectangle.grid.1x2" : "rectangle.grid.2x2")
                                .font(.system(size: 25))
                                .foregroundStyle(.accent)
                        }
                        .toggleStyle(.button)
                        .padding(.trailing)
                    }
                    .onChange(of: searchText) {
                        searchVM.searchText = searchText
                    }

                    if isGrid {
                        GridView(searchViewModel: searchVM)
                    } else {
                        ListView(searchViewModel: searchVM)
                    }
                }
                .frame(maxHeight: .infinity)
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 10)
                    .background(.accent)
            }
        }
    }
}

#Preview {
    SearchView()
}
