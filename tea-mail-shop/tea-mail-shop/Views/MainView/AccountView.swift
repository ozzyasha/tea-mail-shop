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
    private var newUsername = ""
    @State
    private var showingEditProfileAlert = false
    
    
    init() {
        newUsername = viewModel.getCurrentUsername()
    }
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
                            Text(newUsername)
                                .font(.title)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    Button {
                        //
                    } label: {
                        Text("Tea diary")
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(.secondAdditional)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                            .padding(.vertical)
                    }
                    Button {
                        //
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
//                        let alert = UIAlertController(title: "Edit profile", message: "You can edit your username in the field below.\n When it will be ready, press OK to continue.", preferredStyle: .alert)
//                        alert.addTextField { textField in
//                            textField.delegate = self
//                            textField.placeholder = "Enter new username"
//                        }
//                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//                        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
//                            let newUsername = alert.textFields?.first?.text ?? "nil"
//                            firestore.writeFirestore(username: newUsername)
//                            
//                            firestore.readFirestore() { data in
//                                self.username = data
//                                self.greetingLabel.text = "Привет,\n" + self.username  + "!"
//                                
//                                let greetingLabelText = self.greetingLabel.text ?? "nil"
//                                let attributedGreetingLabel = NSMutableAttributedString(string: greetingLabelText)
//                                let usernameRange = (greetingLabelText as NSString).range(of: self.username)
//                                attributedGreetingLabel.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: self.greetingLabel.font.pointSize), range: usernameRange)
//                                self.greetingLabel.attributedText = attributedGreetingLabel
//                            }
//                        })
//                        
//                        alert.addAction(cancelAction)
//                        alert.addAction(okAction)
//                        
//                        self.present(alert, animated: true)
                    } label: {
                        Text("Edit profile")
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(.secondAdditional)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                            .padding(.vertical)
                    }
                    .alert("Edit profile", isPresented: $showingEditProfileAlert) {
                                TextField("Enter your name", text: $newUsername)
                        Button("OK", action: submit)
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
    
    func submit() {
        firestore.writeFirestore(username: newUsername)
        firestore.fetchUser()
    }
}

#Preview {
    AccountView()
}
