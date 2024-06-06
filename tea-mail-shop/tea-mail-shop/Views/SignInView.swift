//
//  SignInView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 6.06.24.
//

import SwiftUI

struct SignInView: View {
   
    @State
    private var username: String = ""
    @State
    private var password: String = ""
    @State
    private var errorText: String = ""
    @State
    private var showDetails = false
    
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
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                
                VStack {
                    Text("Вход")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(Color.accentColor)
                        .padding(.bottom)
                    TextField(text: $username, prompt: Text("e-mail")) {
                        Text("Username")
                    }
                    .textFieldStyle(.roundedBorder)
                    
                    .frame(maxWidth: 300)
                    .padding(.bottom)
                    .environment(\.colorScheme, .light)
                    SecureField(text: $password, prompt: Text("password")) {
                        Text("Password")
                           
                    }
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 300)
                    .padding(.bottom)
                    .environment(\.colorScheme, .light)
                    Text(errorText)
                        .frame(width: 300, height: 100, alignment: .topLeading)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.accentColor)
                    Button {
                        showDetails = true
                    } label: {
                        Text("Sign In")
                            .foregroundStyle(Color.white)
                            .frame(width: 300, height: 50)
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                            .padding(.vertical)
                    }.navigationDestination(isPresented: $showDetails) {
//                        MainView()
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
                            .frame(width: 30, height: 30)
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
