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
//        ZStack(alignment: .center) {
//            Color.green.ignoresSafeArea()
//            VStack {
                VStack {
        
                HStack {
                    Spacer()
                    Toggle(isOn: $isGrid) {
                        Image(systemName: isGrid ? "rectangle.grid.1x2" : "rectangle.grid.2x2")
                            .font(.system(size: 25))
                            .foregroundStyle(.accent)
                    }
                    .toggleStyle(.button)
                    .padding(.trailing)
                    .frame(height: 30)
                }
//                .frame(height: 30)
//                    NavigationStack {
                        if isGrid {
                            GridView(vm: vm)
//                                .toolbar {
//                                    Button(
//                                        action: {
//                                            isGrid.toggle()
//                                        },
//                                        label: {
//                                            Image(systemName: "rectangle.grid.1x2")
//                                            .font(.system(size: 25))
//                                            .foregroundStyle(Color.secondAdditional)
//                                        }
//                                    )
//                                }
//                                .toolbarBackground(.additional, for: .navigationBar)
                        } else {
                            ListView(vm: vm)
//                                .toolbar {
//                                    Button(
//                                        action: {
//                                            isGrid.toggle()
//                                        },
//                                        label: {
//                                            Image(systemName: "rectangle.grid.2x2")
//                                            .font(.system(size: 25))
//                                            .foregroundStyle(Color.secondAdditional)
//                                        }
//                                    )
//                                }
//                                .toolbarBackground(.additional, for: .navigationBar)
                        }
//                    }
                    
//                }
//                .frame(maxHeight: .infinity)
//                Rectangle()
//                    .fill(Color.clear)
//                    .frame(height: 10)
//                    .background(.accent)
//            }
        }
    }
}

#Preview {
    SearchView()
}
