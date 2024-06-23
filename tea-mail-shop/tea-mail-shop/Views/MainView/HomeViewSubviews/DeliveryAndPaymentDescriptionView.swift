//
//  DeliveryAndPaymentDescriptionView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 21.06.24.
//

import SwiftUI

struct DeliveryAndPaymentDescriptionView: View {
    
    @ObservedObject
    private var deliveryViewModel = DeliveryViewModel()
    @ObservedObject
    private var paymentViewModel = PaymentViewModel()

    var body: some View {
        ZStack {
            Color.additional
                .ignoresSafeArea()
            VStack {
                VStack {
                    List {
                        Text("Доставка")
                            .font(.title2)
                            .foregroundStyle(.accent)
                            .bold()
                            .padding(.top, 20)
                        ForEach(deliveryViewModel.deliveryOptions, id: \.id) { option in
                            DeliveryAndPaymentCell(deliveryOption: option)
                        }
                        Text("Оплата")
                            .font(.title2)
                            .foregroundStyle(.accent)
                            .bold()
                            .padding(.top, 20)
                        ForEach(paymentViewModel.paymentOptions, id: \.id) { option in
                            DeliveryAndPaymentCell(deliveryOption: option)
                        }
                    }
                    .listStyle(.plain)

                }
                .background(.white)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                .padding()
                .frame(maxHeight: .infinity)
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 10)
                    .background(.accent)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Доставка и оплата")
                    .bold()
                    .foregroundStyle(.accent)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(.additional)
    }
}

#Preview {
    DeliveryAndPaymentDescriptionView()
}
