//
//  OrdersView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 27.06.24.
//

import SwiftUI

struct OrdersView: View {
    @StateObject
    var ordersViewModel = OrdersViewModel()
    @State
    private var isFirestoreErrorExists = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject
    private var tabViewModel: TabViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.additional.ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack {
                        if !ordersViewModel.ordersCatalogue.isEmpty {
                            ForEach(ordersViewModel.ordersCatalogue.indices, id: \.self) { index in
                                let order = ordersViewModel.ordersCatalogue[index]
                                OrdersViewCell(order: order)
                            }
                        } else {
                            Text("You don't have orders yet")
                                .foregroundStyle(.black)
                        }
                    }
                }
                .padding()
                .frame(maxHeight: .infinity)
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 10)
                    .background(.accent)
            }
        }
        .alert(String(localized: "Error: ") + "\(ordersViewModel.firestoreError)", isPresented: $isFirestoreErrorExists) {
            Button("OK", role: .cancel) { }
        }
        .onChange(of: tabViewModel.selectedTab) {
            if tabViewModel.selectedTab == .account {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    OrdersView()
        .environmentObject(TabViewModel())
}
