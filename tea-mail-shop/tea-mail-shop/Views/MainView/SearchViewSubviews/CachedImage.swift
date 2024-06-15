//
//  CachedImage.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import SwiftUI

struct CachedImage: View {
    
    @ObservedObject
    var vm: CachedImageViewModel
    
    init(imageUrl: String) {
        self.vm = CachedImageViewModel(imageUrl: imageUrl)
    }
    
    var body: some View {
        if vm.isCached {
            AsyncImage(url: URL.cacheDirectory(for: vm.cachedFilename)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
        } else {
            AsyncImage(url: URL(string: vm.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
        }
    }
}

#Preview {
    CachedImage(imageUrl: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg")
}
