//
//  CartView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject
    var cartViewModel: CartViewModel
    @State
    private var showingAlert = false
    
    var body: some View {
        ZStack {
            Color.additional
                .ignoresSafeArea()
            VStack {
                VStack {
                    CartItemsListView()
                    HStack {
                        Spacer()
                        Text("Number of positions:")
                            .foregroundStyle(.black)
                        Text("\(cartViewModel.teaCart.count) items")
                            .bold()
                            .foregroundStyle(.black)
                    }
                    HStack {
                        Spacer()
                        Text("Total price:")
                            .foregroundStyle(.black)
                        Text("\(cartViewModel.totalPrice) Br")
                            .bold()
                            .foregroundStyle(.accent)
                    }
                    HStack {
                        Button {
                            cartViewModel.removeAllFromCart()
                        } label: {
                            Text("Empty Cart")
                                .foregroundStyle(.accent)
                                .font(.title2)
                        }
                        .padding(10)
                        .frame(width: 170)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        
                        Spacer()
                        Button {
                            showingAlert = true
                        } label: {
                            Text("Buy")
                                .foregroundStyle(.white)
                                .font(.title2)
                                .bold()
                        }
                        .padding(10)
                        .frame(width: 170)
                        .background(.accent)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        .alert("🥳 Your order is created successfully!", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) { }
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
            
            .font(.title2)
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartViewModel())
}
