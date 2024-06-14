//
//  AccountView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject
    var viewModel = AuthViewModel()
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.additional.ignoresSafeArea()
            VStack {
                VStack {
                    HStack() {
                        Button {
                            
                        } label: {
                            AvatarView()
                        }
                        Spacer()
                        Text("Anonymous")
                            .font(.title)
                    }
                    .frame(maxWidth: 300)
                    Divider()
                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Sign Out")
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                            .padding(.vertical)
                    }
                }
                .padding()
                .frame(maxHeight: .infinity)
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 10)
                    .background(.secondAdditional)
            }
        }
    }
}

#Preview {
    AccountView()
}
