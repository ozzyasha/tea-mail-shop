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
    @ObservedObject
    var firestore = FirestoreService()
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.additional.ignoresSafeArea()
            VStack {
                VStack() {
                    HStack(spacing: 20) {
                        Button {
                            
                        } label: {
                            AvatarView()
                        }
                        VStack(alignment: .leading) {
                            Text(firestore.teamailUser?.username ?? "Anonymous")
                                .font(.title)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    Spacer()
                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Sign Out")
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(.accent)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                            .padding(.vertical)
                    }
                }
                .foregroundStyle(.accent)
                .padding()
                .frame(maxHeight: .infinity)
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 10)
                    .background(.accent)
            }
        }
    }
}

#Preview {
    AccountView()
}
