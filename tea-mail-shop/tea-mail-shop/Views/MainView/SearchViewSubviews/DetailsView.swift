//
//  DetailsView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 29.06.24.
//

import SwiftUI

struct DetailsView: View {
    @State
    var tea: TeaCatalogueModel
    @EnvironmentObject
    var cartViewModel: CartViewModel
    @Environment(\.presentationMode)
    var presentationMode
    @ObservedObject
    var reviewsViewModel: ReviewsViewModel
    @State
    private var reviewsDetent = PresentationDetent.medium
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.additional.ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.accent)
                        Text("Back")
                            .foregroundStyle(.accent)
                    }
                    Spacer()
                }
                .padding(.leading, 30)
                ScrollView {
                    ZStack(alignment: .bottomLeading) {
                        TeaViewImageView(imageURL: tea.img, sizeOfSide: 360)
                            .frame(height: 300)
                            .clipped()
                        LinearGradient(colors: [Color.black.opacity(0.5), Color.black.opacity(0.3), Color.clear, Color.clear], startPoint: .bottom, endPoint: .top)
                        Text(tea.name)
                            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                            .font(.title3)
                            .bold()
                            .foregroundStyle(Color.white)
                            .shadow(radius: 4, x: 2, y: 2)
                    }
                    HStack(alignment: .bottom) {
                        Text(tea.price)
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.accent)
                            .frame(height: 25)
                        Spacer()
                        Text("(price for \(tea.quantity))")
                            .italic()
                            .foregroundStyle(.black)
                            .frame(height: 25)
                    }
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
                    HStack {
                        Button(action: {
                            reviewsViewModel.isReviewsViewPresented = true
                        }) {
                            HStack {
                                Image(systemName: "leaf")
                                    .foregroundColor(.accent)
                                    .font(.system(size: 20))
                                Spacer()
                                Text("Rate the tea")
                                    .foregroundColor(.accent)
                                    .font(.system(size: 15))
                            }
                            .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
                            .frame(maxWidth: 150)
                        }
                        .sheet(isPresented: $reviewsViewModel.isReviewsViewPresented) {
                            ReviewLeavingView(reviewsViewModel: reviewsViewModel, tea: $tea)
                                .presentationDetents(
                                    [.medium, .large],
                                    selection: $reviewsDetent
                                )
                        }
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        .padding()
                        .shadow(radius: 3, x: 3, y: 3)
                        Spacer()
                        Button(action: {
                            cartViewModel.addToCart(tea: tea)
                        }) {
                            HStack {
                                Image(systemName: cartViewModel.isAddedToCart["\(tea.id)"] ?? false ? "cart.fill" : "cart")
                                    .foregroundColor(cartViewModel.isAddedToCart["\(tea.id)"] ?? false ? .accent : .white)
                                    .font(.system(size: 20))
                                Spacer()
                                Text(cartViewModel.isAddedToCart["\(tea.id)"] ?? false ? "In Cart" : "Add to Cart")
                                    .foregroundColor(cartViewModel.isAddedToCart["\(tea.id)"] ?? false ? .accent : .white)
                                    .font(.system(size: 15))
                            }
                            .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
                            .frame(maxWidth: 150)
                        }
                        .background(cartViewModel.isAddedToCart["\(tea.id)"] ?? false ? .white : .accent)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        .padding()
                        .shadow(radius: 3, x: 3, y: 3)
                    }
                    Text(tea.teaDescription)
                        .lineLimit(100)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .frame(maxHeight: .infinity)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 25)
                    Divider()
                    HStack {
                        Text("Reviews")
                            .font(.title)
                            .foregroundStyle(.accent)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    Divider()
                    DetailReviewsView(tea: tea)
                }
                
                .frame(maxHeight: .infinity)
                .background(.white)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                .padding()
            }
            .frame(maxHeight: .infinity)
        }
        .frame(maxHeight: .infinity)
        
    }
}

#Preview {
    DetailsView(tea: TeaCatalogueModel(id: 0, name: "Some tea", price: "0 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription", quantity: "1 шт."), reviewsViewModel: ReviewsViewModel())
        .environmentObject(CartViewModel())
}
