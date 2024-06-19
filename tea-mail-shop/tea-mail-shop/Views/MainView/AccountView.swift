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
    @State
    private var showingEditProfileAlert = false
    
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
                            Text(viewModel.currentUsername)
                                .font(.title)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    Button {
                        // navigate to Tea diary
                    } label: {
                        Text("Tea diary")
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(.secondAdditional)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                            .padding(.vertical)
                    }
                    Button {
                        // navigate to orders
                    } label: {
                        Text("Orders")
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(.secondAdditional)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                            .padding(.vertical)
                    }
                    Button {
                        showingEditProfileAlert.toggle()
                    } label: {
                        Text("Edit profile")
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(.secondAdditional)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                            .padding(.vertical)
                    }
                    .alert("Edit profile", isPresented: $showingEditProfileAlert) {
                        TextField("Enter your name", text: $viewModel.currentUsername)
                        Button("OK") {
                            viewModel.firestore.writeFirestore(username: viewModel.currentUsername)
                        }
                        Button("Cancel", role: .cancel) { }
                            } message: {
                                Text("You can edit your username in the field below. When it will be ready, press OK to continue.")
                            }
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
