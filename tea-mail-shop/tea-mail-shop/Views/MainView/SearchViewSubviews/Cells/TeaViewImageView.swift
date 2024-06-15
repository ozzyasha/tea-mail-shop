//
//  TeaViewImageView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import SwiftUI

struct TeaViewImageView: View {
    @State
    var imageURL: String
    
    var body: some View {
        
        CachedImage(imageUrl: imageURL)
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
    }
}

#Preview {
    TeaViewImageView(imageURL: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg")
}
