//
//  SearchView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//

import SwiftUI

struct SearchView: View {
    @StateObject
    var vm = TeaViewModel()
    
    @State
    var isGrid = false
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.additional.ignoresSafeArea()
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        SearchFieldView()
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
                    if isGrid {
                        GridView(vm: vm)
                    } else {
                        ListView(vm: vm)
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
