//
//  DeliveryAndPaymentCell.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 23.06.24.
//

import SwiftUI

struct DeliveryAndPaymentCell: View {
    @Binding
    var deliveryOption: DeliveryAndPaymentModel
    
    var body: some View {
        DisclosureGroup {
            Text(deliveryOption.description)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.black)
        } label: {
            Text(deliveryOption.option)
                .multilineTextAlignment(.leading)
                .font(.title3)
                .foregroundStyle(.black)
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    DeliveryAndPaymentCell(deliveryOption: .constant(DeliveryAndPaymentModel(option: "Вариант доставки", description: "Описание варианта доставки")))
}
