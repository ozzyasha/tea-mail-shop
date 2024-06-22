//
//  ContactsView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 21.06.24.
//

import SwiftUI
import MapKit

struct ContactsView: View {
    
    let phoneNumbers = [
        "clientsPhoneNumber":"+375298543460",
        "warehousePhoneNumber":"+375298495051",
        "wholesalePhoneNumber":"+375298610580"
    ]
    let socialNetworks = [
        "facebook":"https://www.facebook.com/Teamailroom",
        "instagram":"https://www.instagram.com/tea_mail",
        "telegram":"https://t.me/teamailby",
        "vk":"https://vk.com/teamail",
        "youtube":"https://www.youtube.com/channel/UCeFv6gCEL80yvdXCP8iw6dg"
    ]
    
    var body: some View {
        ZStack {
            Color.additional
                .ignoresSafeArea()
            
            VStack {
                VStack() {
                    ScrollView {
                        VStack(alignment: .leading) {
                            Button {
                                if let phoneURL = URL(string: "tel:\(phoneNumbers["clientsPhoneNumber"] ?? "nil")") {
                                    UIApplication.shared.open(phoneURL)
                                }
                            } label: {
                                Text("+375 (29) 854 34 60")
                                    .padding()
                                    .font(.title2)
                                    .foregroundStyle(.accent)
                            }
                            
                            Text("Бронирование мест / чайная консультация с 12:00 до 22:00")
                                .padding(.horizontal)
                                .foregroundStyle(.black)
                            
                            Button {
                                if let phoneURL = URL(string: "tel:\(phoneNumbers["warehousePhoneNumber"] ?? "nil")") {
                                    UIApplication.shared.open(phoneURL)
                                }
                            } label: {
                                Text("+375 (29) 849 50 51")
                                    .padding()
                                    .font(.title2)
                                    .foregroundStyle(.accent)
                            }
                            
                            Text("Вопросы по заказам/склад с 12:00 до 18:00")
                                .padding(.horizontal)
                                .foregroundStyle(.black)
                            
                            Button {
                                if let phoneURL = URL(string: "tel:\(phoneNumbers["warehousePhoneNumber"] ?? "nil")") {
                                    UIApplication.shared.open(phoneURL)
                                }
                            } label: {
                                Text("+375 (29) 861 05 80")
                                    .padding()
                                    .font(.title2)
                                    .foregroundStyle(.accent)
                            }
                            
                            Text("Оптовый заказ чая с 10:00 до 18:00 (пн-пт)")
                                .padding(.horizontal)
                                .foregroundStyle(.black)
                            
                            Text("Адрес чайной и магазина")
                                .padding()
                                .font(.title2)
                                .foregroundStyle(.accent)
                            
                            Text("г. Минск, пр. Независимости 44-3Н\nВход со двора здания «Вечерний Минск», ст.м. Площадь Победы")
                                .foregroundStyle(.black)
                                .padding(.horizontal)
                                .padding(.bottom)
                        }
                    }
                    VStack(alignment: .center) {
                        HStack {
                            ForEach(socialNetworks.keys.sorted(), id: \.self) { pictureName in
                                Image(pictureName)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundStyle(.secondAdditional)
                                    .scaledToFit()
                                    .frame(width: 40)
                                    .padding(5)
                                    .onTapGesture {
                                        if let url = URL(string: socialNetworks[pictureName] ?? "nil") {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
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
    ContactsView()
}
