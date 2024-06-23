//
//  DeliveryAndPaymentCell.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 23.06.24.
//

import SwiftUI

struct DeliveryAndPaymentCell: View {
    @State
    var deliveryOption: DeliveryAndPaymentModel
    
    var body: some View {
        DisclosureGroup() {
            Text(deliveryOption.description)
                .foregroundStyle(.black)
        } label: {
            Text(deliveryOption.option)
                .font(.title3)
                .foregroundStyle(.black)
                .padding(.leading)
        }
    }
}

#Preview {
    DeliveryAndPaymentCell(deliveryOption: DeliveryAndPaymentModel(option: "Вариант доставки", description: "Описание варианта доставки"))
}
