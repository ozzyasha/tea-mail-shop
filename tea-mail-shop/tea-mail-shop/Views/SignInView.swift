//
//  SignInView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 6.06.24.
//

import SwiftUI

struct SignInView: View {
    
    @Binding
    var isActive: Bool
    @State
    private var email: String = ""
    @State
    private var password: String = ""
    @State
    private var errorText: String = ""
    @State
    private var isEmailTextFieldValid = true
    @State
    private var isPasswordTextFieldValid = true
    @ObservedObject
    var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                BackgroundView()
                VStack {
                    Spacer()
                        .frame(height: 60)
                    Image("logo-textfree")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.accent)
                        .background(.additional)
                        .clipShape(Circle())
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    VStack {
                        Text("Sign In")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(Color.accentColor)
                            .padding(.bottom)
                        TextField("e-mail", text: $email)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(isEmailTextFieldValid ? Color.clear : Color.accentColor, lineWidth: 1))
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 300)
                            .padding(.bottom)
                            .environment(\.colorScheme, .light)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                        SecureField("password", text: $password)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(isPasswordTextFieldValid ? Color.clear : Color.accentColor, lineWidth: 1))
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 300)
                            .environment(\.colorScheme, .light)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        Text(errorText)
                            .frame(maxWidth: 290, maxHeight: 70, alignment: .topLeading)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.accentColor)
                        Button {
                            isEmailTextFieldValid = true
                            isPasswordTextFieldValid = true
                            
                            guard !email.isEmpty && !password.isEmpty else {
                                if email.isEmpty && !password.isEmpty {
                                    isEmailTextFieldValid = false
                                    isPasswordTextFieldValid = true
                                    self.errorText = String(localized: "E-mail field is required to be filled")
                                    return
                                } else if password.isEmpty && !email.isEmpty {
                                    isEmailTextFieldValid = true
                                    isPasswordTextFieldValid = false
                                    self.errorText = String(localized: "Password field is required to be filled")
                                    return
                                } else if password.isEmpty && email.isEmpty {
                                    isEmailTextFieldValid = false
                                    isPasswordTextFieldValid = false
                                    self.errorText = String(localized: "All fields are required to be filled")
                                    return
                                }
                                return
                            }
                            
                            self.errorText = ""
                            
                            viewModel.signInWithEmail(email: email, password: password)
                            if let errorMessage = viewModel.errorMessage {
                                self.errorText = (errorMessage)
                            }
                            
                        } label: {
                            Text("Sign In")
                                .foregroundStyle(Color.white)
                                .frame(maxWidth: 300, maxHeight: 50)
                                .background(Color.accentColor)
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                                .padding(.vertical)
                        }
                        Text("or sign in with")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.gray)
                        Button {
                            viewModel.signInWithGoogle()
                            if let errorMessage = viewModel.errorMessage {
                                self.errorText = (errorMessage)
                            }
                        } label: {
                            Image("googleIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 30, maxHeight: 30)
                        }
                        .padding(.vertical)
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.black)
                            Button {
                                self.isActive.toggle()
                            } label: {
                                Text("Sign Up")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 45, trailing: 20))
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 30, height: 30)))
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .top)
            }
        }
    }
}

#Preview {
    SignInView(isActive: .constant(true))
}
