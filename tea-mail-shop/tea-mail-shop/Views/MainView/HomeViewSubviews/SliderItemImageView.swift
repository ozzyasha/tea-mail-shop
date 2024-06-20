//
//  SliderItemImageView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 20.06.24.
//

import SwiftUI

struct SliderItemImageView: View {
    let imageURL: String
    let linkURL: String
    @Binding var currentIndex: Int
    
    var body: some View {
        
        CachedImage(imageUrl: imageURL)
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width - 20, height: 123)
            .background(Color.secondAdditional)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            .onTapGesture {
                if let url = URL(string: linkURL) {
                    UIApplication.shared.open(url)
                }
            }
        
    }
}

#Preview {
    SliderItemImageView(imageURL: "https://tea-mail.by/wa-data/public/shop/promos/69/00/69/promo_6529392c1bbc3416951405.jpg?v=1697200427", linkURL: "https://www.instagram.com/p/CygNZGvIv6N/?igshid=cW85ZHAyaHQzc3Bj", currentIndex: .constant(0))
}
