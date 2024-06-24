//
//  HomeView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//

import SwiftUI

struct HomeView: View {
    @StateObject
    var vm = SliderItemsViewModel()
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                Color.additional.ignoresSafeArea()
                VStack {
                    VStack {
                        HStack {
                            NavigationLink("Контакты") {
                                ContactsView()
                            }
                            .foregroundStyle(Color.accent)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .padding(.vertical)
                            
                            Divider().frame(height: 60)
                                .background(.accent)
                            
                            NavigationLink("Доставка и оплата") {
                                DeliveryAndPaymentDescriptionView()
                            }
                            .foregroundStyle(Color.accent)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .padding(.vertical)
                            
                            Divider().frame(height: 60)
                                .background(.accent)
                            
                            Button {
                                if let url = URL(string: Endpoint.teaNews.rawValue) {
                                    UIApplication.shared.open(url)
                                }
                            } label: {
                                Text("Статьи о чае")
                                    .foregroundStyle(Color.accent)
                                    .frame(maxWidth: 300, maxHeight: 50)
                                    .padding(.vertical)
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                    .background(.additional)
                    SliderView(sliderItemsViewModel: vm)
                    SearchView()
                }
            }
        }
        .accentColor(.accent)
        .tint(.accent)
        .foregroundStyle(.accent)
    }
}

#Preview {
    HomeView()
}
