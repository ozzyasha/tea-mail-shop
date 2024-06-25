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
    @EnvironmentObject
    var tabViewModel: TabViewModel
    
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
                LottieView()
                    .frame(width: 250, height: 250)
                    Text("Your cart is empty")
                        .multilineTextAlignment(.center)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.black)
                        .padding()
                    Text("Looks like you haven't added anything to your cart yet")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .padding()
                Button {
                    tabViewModel.selectedTab = .search
                } label: {
                    Text("Go to the catalogue")
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .foregroundStyle(.accent)
                        .padding()
                }
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            .frame(maxHeight: .infinity)
        }
        
    }
}

#Preview {
    CartItemsListView()
        .environmentObject(CartViewModel())
        .environmentObject(TabViewModel())
}
