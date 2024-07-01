//
//  TeaViewGridCell.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import SwiftUI

struct TeaViewGridCell: View {
    @State
    var tea: TeaCatalogueModel
    @EnvironmentObject
    var cartViewModel: CartViewModel
    @State
    var isDetailsPresented = false
    @ObservedObject
    var reviewsViewModel = ReviewsViewModel()
    
    var isCartButtonEnabled: Bool {
        tea.quantity != "Нет в наличии"
    }
    
    var body: some View {
        
        VStack {
            TeaViewImageView(imageURL: tea.img, sizeOfSide: 120)
            HStack {
                Text(tea.name)
                    .font(.headline)
                    .foregroundStyle(Color.black)
                Spacer()
            }
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
                Button(action: {
                    if isCartButtonEnabled {
                        cartViewModel.addToCart(tea: tea)
                    }
                }) {
                    Image(systemName: cartViewModel.isAddedToCart["\(tea.id)"] ?? false ? "cart.fill" : "cart")
                        .foregroundColor(isCartButtonEnabled ? .accent : .gray)
                        .font(.system(size: 30))
                }
                .frame(width: 40, height: 40, alignment: .bottomTrailing)
                .disabled(!isCartButtonEnabled)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .onTapGesture {
            isDetailsPresented = true
        }
        .fullScreenCover(isPresented: $isDetailsPresented) {
            DetailsView(tea: tea, reviewsViewModel: reviewsViewModel)
        }
    }
}

#Preview {
    TeaViewGridCell(tea: TeaCatalogueModel(id: 0, name: "Some tea", price: "0 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "1 шт."))
        .environmentObject(CartViewModel())
}
