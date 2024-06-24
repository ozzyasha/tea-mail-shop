//
//  CartItemsListCell.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 25.06.24.
//

import SwiftUI

struct CartItemsListCell: View {
    @State
    var tea: TeaCatalogueModel
    @EnvironmentObject
    var cartViewModel: CartViewModel
    
    var body: some View {
        HStack {
            TeaViewImageView(imageURL: tea.img)
                .padding(.trailing)
            
            VStack {
                HStack() {
                    Text(tea.name)
                        .font(.headline)
                        .foregroundStyle(Color.black)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Button(action: {
                            cartViewModel.removeFromCart(tea: tea)
                        }) {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.accent)
                                .font(.system(size: 30))
                        }
                        .frame(width: 40, height: 40, alignment: .bottomTrailing)
                    }
                }
                .padding(.top, 10)
                Spacer()
                Divider()
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("\(tea.price)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.accent)
                        Text("(\(tea.quantity))")
                            .font(.system(size: 15))
                            .italic()
                            .foregroundStyle(.black)
                    }
                    Spacer()
                    
                }
                .padding(.bottom, 10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    CartItemsListCell(tea: TeaCatalogueModel(id: 0, name: "Some tea", price: "0 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", description: "description", quantity: "1 шт."))
        .environmentObject(CartViewModel())
}
