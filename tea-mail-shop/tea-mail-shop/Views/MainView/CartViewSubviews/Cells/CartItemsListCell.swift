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
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    TeaViewImageView(imageURL: tea.img, sizeOfSide: 80)
                        .padding(.trailing)
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text(tea.name)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color.black)
                    Spacer()
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Button(action: {
                        cartViewModel.removeGroupFromCart(tea: tea)
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.accent)
                    }
                    .frame(width: 20, height: 20, alignment: .topTrailing)
                    Spacer()
                }
            }
            .padding(.top, 10)
            Divider()
            HStack(alignment: .bottom) {
                Text(cartViewModel.getPrice(for: tea))
                    .font(.system(size: 20, weight: .bold))
                    .frame(height: 20)
                    .foregroundStyle(.accent)
                    .padding()
                Spacer()
                Stepper {
                    Text(cartViewModel.getQuantity(for: tea))
                        .font(.system(size: 15))
                        .italic()
                        .foregroundStyle(.black)
                } onIncrement: {
                    cartViewModel.addToCart(tea: tea)
                } onDecrement: {
                    cartViewModel.removeOneItemFromCart(tea: tea)
                }
                .frame(height: 20)
                .padding()
                
            }
            .padding(.bottom, 10)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
    }

}

#Preview {
    CartItemsListCell(tea: TeaCatalogueModel(id: 0, name: "Some tea", price: "0 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "1 шт."))
        .environmentObject(CartViewModel())
}
