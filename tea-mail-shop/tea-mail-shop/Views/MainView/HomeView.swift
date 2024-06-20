//
//  HomeView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 9.06.24.
//

import SwiftUI

struct HomeView: View {
    @StateObject
    var vm = SliderItemsViewModel()
    var body: some View {
        ZStack(alignment: .center) {
            Color.additional.ignoresSafeArea()
            VStack {
                SliderView(sliderItemsViewModel: vm)
                    .frame(maxHeight: .infinity)
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 10)
                    .background(.accent)
            }
        }
    }
}

#Preview {
    HomeView()
}
