//
//  ViewCoordinator.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 5.06.24.
//

import SwiftUI

struct ViewCoordinator: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            SignInView()
        } else {
            SplashView(isActive: $isActive)
        }
    }
}

#Preview {
    ViewCoordinator()
}
