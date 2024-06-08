//
//  SignUpView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 6.06.24.
//

import SwiftUI

struct SignUpView: View {
    
    @State
    private var username: String = ""
    @State
    private var email: String = ""
    @State
    private var password: String = ""
    @State
    private var errorText: String = ""
    @State
    private var showDetails = false
    @State
    private var isUsernameTextFieldValid = true
    @State
    private var isEmailTextFieldValid = true
    @State
    private var isPasswordTextFieldValid = true
    
    var body: some View {
        ZStack(alignment: .center) {
            BackgroundView()
            VStack {
                Image("logo-textfree")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.accent)
                    .background(.additional)
                    .clipShape(Circle())
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 20, trailing: 0))
                VStack {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(Color.accentColor)
                        .padding(.bottom)
                    TextField("username", text: $username)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(isUsernameTextFieldValid ? Color.clear : Color.accentColor, lineWidth: 1))
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 300)
                        .padding(.bottom)
                        .environment(\.colorScheme, .light)
                    TextField("e-mail", text: $email)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(isEmailTextFieldValid ? Color.clear : Color.accentColor, lineWidth: 1))
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 300)
                        .padding(.bottom)
                        .environment(\.colorScheme, .light)
                    SecureField("password", text: $password)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                                        .stroke(isPasswordTextFieldValid ? Color.clear : Color.accentColor, lineWidth: 1))
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 300)
                        .environment(\.colorScheme, .light)
                    Text(errorText)
                        .frame(maxWidth: 290, maxHeight: 70, alignment: .topLeading)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.accentColor)
                    Button {
                        showDetails = true
                        
                        isEmailTextFieldValid = true
                        isPasswordTextFieldValid = true
                        
                        guard !email.isEmpty && !password.isEmpty else {
                            if email.isEmpty && !password.isEmpty {
                                isEmailTextFieldValid = false
                                isPasswordTextFieldValid = true
                                self.errorText = "E-mail field is required to be filled"
                                return
                            } else if password.isEmpty && !email.isEmpty {
                                isEmailTextFieldValid = true
                                isPasswordTextFieldValid = false
                                self.errorText = "Password field is required to be filled"
                                return
                            } else if password.isEmpty && email.isEmpty {
                                isEmailTextFieldValid = false
                                isPasswordTextFieldValid = false
                                self.errorText = "All fields are required to be filled"
                                return
                            }
                            return
                        }
                        
                        self.errorText = ""
                        AuthService.shared.signUpWithEmail(email: email, username: username, password: password) { errorText in
                            if errorText == "No errors" {
                                return
                            } else {
                                self.errorText = errorText
                            }
                        }
                    } label: {
                        Text("Sign Up")
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                            .padding(.vertical)
                    }.navigationDestination(isPresented: $showDetails) {
                        // MainView()
                    }
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.black)
                        Button {
                            // navigation to Sign In
                        } label: {
                            Text("Sign In")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.accentColor)
                        }
                    }
                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 45, trailing: 20))
                .background(.white)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 30, height: 30)))
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
        }
    }
}

#Preview {
    SignUpView()
}
