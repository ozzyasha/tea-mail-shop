//
//  CartViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 24.06.24.
//

import Foundation

class CartViewModel: ObservableObject {
    @Published
    var teaCart = [TeaCatalogueModel]()
    @Published
    var totalPrice: Int = 0
    
    func addToCart(tea: TeaCatalogueModel) {
        teaCart.append(tea)
        totalPrice += Int(tea.price.trimmingCharacters(in: CharacterSet(charactersIn: " Br"))) ?? 0
    }
    
    func removeFromCart(tea: TeaCatalogueModel) {
        if let index = teaCart.firstIndex(where: { $0.id == tea.id }) {
            teaCart.remove(at: index)
            totalPrice -= Int(tea.price.trimmingCharacters(in: CharacterSet(charactersIn: " Br"))) ?? 0
        }
    }
    
    func removeAllFromCart() {
        teaCart.removeAll()
        totalPrice = 0
    }
}
