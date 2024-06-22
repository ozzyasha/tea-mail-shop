//
//  DeliveryAndPaymentDescriptionView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 21.06.24.
//

import SwiftUI

struct DeliveryAndPaymentDescriptionView: View {
    var body: some View {
        ZStack {
            Color.additional
                .ignoresSafeArea()
            
            VStack {
                Text("Favorites Screen")
                    .padding()
                    .frame(maxHeight: .infinity)
                    .font(.title2)
                    .foregroundStyle(.accent)
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 10)
                    .background(.accent)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Контакты")
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
