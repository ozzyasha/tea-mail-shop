//
//  OrdersViewCell.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 27.06.24.
//

import SwiftUI

struct OrdersViewCell: View {
    @State
    var order: Order
    @StateObject
    var ordersViewModel = OrdersViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order #\(order.id)")
                .font(.title3)
                .bold()
                .foregroundStyle(.black)
                .padding(.bottom)
            ForEach(order.orderedTeasArray, id: \.id) { orderedTea in
                Divider()
                HStack {
                    Text(orderedTea.name)
                        .foregroundStyle(.black)
                    Spacer()
                    Text("\(orderedTea.price)")
                        .foregroundStyle(.black)
                        .bold()
                    Text("(\(orderedTea.quantity))")
                        .foregroundStyle(.black)
                        .italic()
                }
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
    }
}

#Preview {
    OrdersViewCell(order: Order(id: "0", orderedTeasArray: [OrderedTea(id: 0, name: "tea", price: "0 Br", quantity: "0 шт."), OrderedTea(id: 1, name: "second", price: "0 Br", quantity: "0 шт.")]))
}
