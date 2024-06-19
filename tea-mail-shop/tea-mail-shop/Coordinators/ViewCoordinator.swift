//
//  ViewCoordinator.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 5.06.24.
//

import SwiftUI

struct ViewCoordinator: View {
    @State
    private var isAppActive = false
    @State
    private var isSignInModeActive = true
    @ObservedObject
    var viewModel = AuthViewModel()
    
    var body: some View {
        if isAppActive {
            NavigationView {
                if viewModel.authState == .authenticated {
                    MainView()
                } else {
                    if isSignInModeActive {
                        SignInView(isActive: $isSignInModeActive)
                    } else {
                        SignUpView(isActive: $isSignInModeActive)
                    }
                }
            }
        } else {
            SplashView(isActive: $isAppActive)
        }
    }
}

#Preview {
    ViewCoordinator()
}
