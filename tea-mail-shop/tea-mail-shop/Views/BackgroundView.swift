//
//  BackgroundView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 6.06.24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        @Environment(\.colorScheme)
        var currentMode
        
        ZStack {
            Color.additional.ignoresSafeArea()
            LazyVGrid(columns: Array(repeating: GridItem(),
                                     count: 7)) {
                ForEach(0..<60) { _ in
                    Image("leaf")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.secondAdditional)
                        .frame(width: 50, height: 50)
                    Spacer()
                }
            }
        }
        .background(.accent)
        
    }
}

#Preview {
    BackgroundView()
}
