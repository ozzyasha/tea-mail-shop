//
//  SplashView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 5.06.24.
//

import SwiftUI

struct SplashView: View {
    @State private var scale = 0.7
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(Color.accentColor)
            Image("logo")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 90)
                .foregroundStyle(.white)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView(isActive: .constant(true))
}
