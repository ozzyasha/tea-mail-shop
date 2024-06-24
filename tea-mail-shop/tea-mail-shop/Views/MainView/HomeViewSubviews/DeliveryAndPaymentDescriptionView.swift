//
//  DeliveryAndPaymentDescriptionView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 21.06.24.
//

import SwiftUI

struct DeliveryAndPaymentDescriptionView: View {
    
    @StateObject
    private var deliveryViewModel = DeliveryViewModel()
    @StateObject
    private var paymentViewModel = PaymentViewModel()

    var body: some View {
        ZStack {
            Color.additional
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading) {
                    List {
                        HStack {
                            Text("Доставка")
                                .font(.title2)
                                .foregroundStyle(.accent)
                                .bold()
                                .padding(.top, 20)
                            Spacer()
                            
                        }
                        .padding()
                        ForEach($deliveryViewModel.deliveryOptions, id: \.id) { $option in
                            DeliveryAndPaymentCell(deliveryOption: $option)
                        }
                        HStack {
                            Text("Оплата")
                                .font(.title2)
                                .foregroundStyle(.accent)
                                .bold()
                                .padding(.top, 20)
                            Spacer()
                        }
                        .padding()
                        ForEach($paymentViewModel.paymentOptions, id: \.id) { $option in
                            DeliveryAndPaymentCell(deliveryOption: $option)
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
