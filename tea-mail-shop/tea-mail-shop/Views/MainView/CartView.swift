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
    @ObservedObject
    var firestore = FirestoreService()
    
    var body: some View {
        ZStack {
            Color.additional
                .ignoresSafeArea()
            VStack {
                VStack {
                    if cartViewModel.teaCart.count != 0 {
                        HStack {
                            Spacer()
                            Button {
                                cartViewModel.removeAllFromCart()
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.accent)
                                    .font(.system(size: 18))
                                Text("Clear Cart")
                                    .foregroundStyle(.accent)
                                    .font(.system(size: 18))
                            }
                            .padding(10)
                            .frame(width: 180)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        }
                    }
                    CartItemsListView()
                    if cartViewModel.teaCart.count != 0 {
                        HStack {
                            Spacer()
                            Text("\(cartViewModel.teaCart.count) items in cart")
                                .font(.system(size: 15))
                                .foregroundStyle(.black)
                        }
                        Divider()
                            .background(.secondAdditional)
                        HStack(alignment: .bottom) {
                            Spacer()
                            Text("Total price:")
                                .font(.title2)
                                .frame(height: 18)
                                .foregroundStyle(.black)
                            Text("\(cartViewModel.totalPrice) Br")
                                .font(.title)
                                .frame(height: 18)
                                .bold()
                                .foregroundStyle(.accent)
                        }
                        .padding(.vertical)
                        Button {
                            showingAlert = true
                            firestore.writeFirestore(orders: cartViewModel.teaCart)
                            cartViewModel.teaCart.forEach { tea in
                                cartViewModel.isAddedToCart["\(tea.id)"] = false
                            }
                        } label: {
                            Text("Confirm Order")
                                .foregroundStyle(.white)
                                .font(.title2)
                                .bold()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.accent)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        .alert("🥳 Your order is created successfully!", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) {
                                cartViewModel.removeAllFromCart()
                            }
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
