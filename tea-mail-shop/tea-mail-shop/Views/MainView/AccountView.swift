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
    @State
    private var newUsername = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                Color.additional.ignoresSafeArea()
                VStack {
                    VStack() {
                        HStack(spacing: 20) {
                            AvatarView()
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
                        NavigationLink {
                            OrdersView()
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
                            TextField("Enter your name", text: $newUsername) {
                                if newUsername.count > 20 {
                                    newUsername = String(newUsername.prefix(20))
                                }
                            }
                            .onChange(of: newUsername) {
                                if newUsername.count > 20 {
                                    newUsername = String(newUsername.prefix(20))
                                }
                            }
                            .environment(\.colorScheme, .light)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            
                            Button("OK") {
                                viewModel.currentUsername = newUsername
                                viewModel.firestore.writeFirestore(username: viewModel.currentUsername)
                            }
                            Button("Cancel", role: .cancel) { }
                        } message: {
                            Text("You can edit your username in the field below (no more than 20 symbols). When it will be ready, press OK to continue.")
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
        .accentColor(.accent)
        .tint(.accent)
        .foregroundStyle(.accent)
    }
}

#Preview {
    AccountView()
}
