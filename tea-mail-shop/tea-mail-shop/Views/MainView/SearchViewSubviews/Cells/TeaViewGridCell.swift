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
    
    @State
    private var isLiked = false
    
    var body: some View {
        
        VStack {
            TeaViewImageView(imageURL: tea.img)
            
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
                    Text("(\(tea.quantity))")
                        .font(.system(size: 15))
                        .italic()
                }
                Spacer()
                Button(action: {
                    isLiked.toggle()
                    @AppStorage("isLiked") var liked: Bool = isLiked
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(.accent)
                        .font(.system(size: 30))
                }
                .frame(width: 40, height: 40, alignment: .bottomTrailing)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    TeaViewGridCell(tea: TeaCatalogueModel(id: 0, name: "Some tea tea tea tea tea tea tea tea tea tea teaaaaaaaaa teateatea aaaaa", price: "0 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", description: "description", quantity: "1 шт."))
}
