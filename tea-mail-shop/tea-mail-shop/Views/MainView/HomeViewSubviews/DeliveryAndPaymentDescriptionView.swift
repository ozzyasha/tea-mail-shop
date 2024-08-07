//
//  DeliveryAndPaymentDescriptionView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 21.06.24.
//

import SwiftUI

struct DeliveryAndPaymentDescriptionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject
    private var tabViewModel: TabViewModel
    
    @StateObject
    private var deliveryViewModel = DeliveryViewModel()
    @StateObject
    private var paymentViewModel = PaymentViewModel()
    
    var body: some View {
        ZStack {
            Color.additional
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                ScrollView {
                    HStack {
                        Text("Доставка")
                            .font(.title2)
                            .foregroundStyle(.accent)
                            .bold()
                            .padding(.top, 20)
                        Spacer()
                    }
                    .padding()
                    Divider()
                        .background(.additional)
                    ForEach($deliveryViewModel.deliveryOptions, id: \.id) { $option in
                        DeliveryAndPaymentCell(deliveryOption: $option)
                        Divider()
                            .background(.additional)
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
                        Divider()
                            .background(.additional)
                        DeliveryAndPaymentCell(deliveryOption: $option)
                    }
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
        .onChange(of: tabViewModel.selectedTab) {
            if tabViewModel.selectedTab == .home {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    DeliveryAndPaymentDescriptionView()
        .environmentObject(TabViewModel())
}
