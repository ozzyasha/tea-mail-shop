//
//  LottieView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 25.06.24.
//

import SwiftUI
import UIKit
import Lottie

struct LottieView: UIViewRepresentable {
    let animationView = LottieAnimationView()
    let animationUrl = URL(string: "https://lottie.host/35032767-af98-44ab-922c-ff220b9b01e3/0rZCwG2xrU.json")
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
    
        LottieAnimation.loadedFrom(url: animationUrl!,
                                   closure: { animation in
            
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .autoReverse
            animationView.play()
            
        }, animationCache: nil)
        
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
