//
//  CartItemsListView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 25.06.24.
//

import SwiftUI

struct CartItemsListView: View {
    @EnvironmentObject
    var cartViewModel: CartViewModel
    
    var body: some View {
        if cartViewModel.teaCart.count != 0 {
            List(cartViewModel.teaCart, id: \.id) { tea in
                CartItemsListCell(tea: tea)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .frame(maxHeight: .infinity)
            .listStyle(.plain)
            .background(.additional)
            .buttonStyle(.borderless)
        } else {
            VStack {
                ZStack {
                    Spacer()
                    Text("You haven't added anything yet...")
                        .foregroundStyle(.black)
                        .padding()
                    Spacer()
                }
                .background(.white)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            }
            .frame(maxHeight: .infinity)
        }
        
    }
}

#Preview {
    CartItemsListView()
        .environmentObject(CartViewModel())
}
