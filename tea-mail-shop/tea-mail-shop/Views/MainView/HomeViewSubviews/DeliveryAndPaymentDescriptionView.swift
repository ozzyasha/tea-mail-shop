//
//  DeliveryAndPaymentDescriptionView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 21.06.24.
//

import SwiftUI

struct DeliveryAndPaymentDescriptionView: View {
    
    @ObservedObject
    private var vm = DeliveryViewModel()

    var body: some View {
        ZStack {
            Color.additional
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    List {
                        ForEach(vm.deliveryOptions, id: \.id) { option in
                            DisclosureGroup(
                                isExpanded: option.isExpanded,
                                content: {
                                    Text(option.description)
                                },
                                label: {
                                    Text(option.option)
                                        .font(.title3)
                                        .foregroundStyle(.accent)
                                }
                            )
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
