//
//  SignInView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 6.06.24.
//

import SwiftUI

struct SignInView: View {
    
    @State
    private var email: String = ""
    @State
    private var password: String = ""
    @State
    private var errorText: String = ""
    @State
    private var showDetails = false
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
                        
//                        guard !email.isEmpty && !password.isEmpty else {
//                            isEmailTextFieldValid = false
//                            isPasswordTextFieldValid = false
//                            self.errorText = "All fields should be filled"
//                            return
//                        }
                        
                        isEmailTextFieldValid = true
                        isPasswordTextFieldValid = true
                        
                        guard !email.isEmpty else {
                            isEmailTextFieldValid = false
                            self.errorText = "You should fill the e-mail field to continue"
                            return
                        }
//                        
//                        isEmailTextFieldValid = true
//                        isPasswordTextFieldValid = true
                        
                        guard !password.isEmpty else {
                            isPasswordTextFieldValid = false
                            self.errorText = "You should fill the password field to continue"
                            return
                        }
                        
//                        isPasswordTextFieldValid = true
                        self.errorText = ""
                        //                        AuthService.shared.signInWithEmail(email: email, password: password) { errorText in
                        //                            if errorText == "No errors" {
                        //                                return
                        //                            } else {
                        //                                self.errorLabel.text = errorText
                        //                            }
                        //                        }
                    } label: {
                        Text("Sign In")
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: 300, maxHeight: 50)
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                            .padding(.vertical)
                    }.navigationDestination(isPresented: $showDetails) {
                        // MainView()
                    }
                    Text("or sign in with")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.gray)
                    Button {
                        // google sign in
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
                            // navigation to Sign Up
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
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
        }
    }
}

#Preview {
    SignInView()
}
