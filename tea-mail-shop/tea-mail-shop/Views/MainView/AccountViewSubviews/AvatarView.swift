//
//  AvatarView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 14.06.24.
//

import SwiftUI

struct AvatarView: View {
    @ObservedObject
    var viewModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            Circle().frame(width: 110, height: 110)
                .foregroundStyle(Color.secondAdditional)
            Circle().frame(width: 100, height: 100)
                .foregroundStyle(Color.additional)
            ZStack {
                AsyncImage(
                    url: viewModel.getAvatar()) { image in
                        image
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                    } placeholder: {
                        ZStack {
                            Circle().frame(width: 90, height: 90)
                                .foregroundStyle(Color.white)
                                .overlay(Color.gray.opacity(0.2))
                            Image(systemName: "person.fill")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .foregroundStyle(.gray)
                                .offset(x: 0, y: 10)
                        }
                    }
            }
            .clipShape(Circle())
        }
    }
}

#Preview {
    AvatarView()
}
