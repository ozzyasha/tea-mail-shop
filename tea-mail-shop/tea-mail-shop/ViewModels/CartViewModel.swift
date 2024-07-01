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
    @Published var isAddedToCart: [String: Bool] = [:]
    
    func addToCart(tea: TeaCatalogueModel) {
        teaCart.append(tea)
        isAddedToCart["\(tea.id)"] = true
        totalPrice += Int(tea.price.trimmingCharacters(in: CharacterSet(charactersIn: " Br"))) ?? 0
    }
    
    func removeOneItemFromCart(tea: TeaCatalogueModel) {
        if let index = teaCart.firstIndex(where: { $0.id == tea.id }) {
            teaCart.remove(at: index)
            if !teaCart.contains(where: { $0.id == tea.id }) {
                isAddedToCart["\(tea.id)"] = false
            }
            totalPrice -= Int(tea.price.trimmingCharacters(in: CharacterSet(charactersIn: " Br"))) ?? 0
        }
    }
    
    func removeGroupFromCart(tea: TeaCatalogueModel) {
        let indicesToRemove = teaCart.indices.filter { teaCart[$0].id == tea.id }
        for index in indicesToRemove.reversed() {
            teaCart.remove(at: index)
            isAddedToCart["\(tea.id)"] = false
            totalPrice -= Int(tea.price.trimmingCharacters(in: CharacterSet(charactersIn: " Br"))) ?? 0
        }
    }
    
    func removeAllFromCart() {
        teaCart.removeAll()
        isAddedToCart = [:]
        totalPrice = 0
    }
    
    func getPrice(for tea: TeaCatalogueModel) -> String {
        let count = teaCart.filter { $0.id == tea.id }.count
        let price = Int(tea.price.trimmingCharacters(in: CharacterSet(charactersIn: " Br"))) ?? 0
        return "\(price * count) Br"
    }
    
    func getQuantity(for tea: TeaCatalogueModel) -> String {
        if tea.quantity.contains(" шт.") {
            return "\(teaCart.filter { $0.id == tea.id }.count) шт."
        } else if tea.quantity.contains(" г.") {
            let teaQuantity = Int(tea.quantity.trimmingCharacters(in: CharacterSet(charactersIn: " г."))) ?? 0
            return "\(teaCart.filter { $0.id == tea.id }.count * teaQuantity) г."
        } else if tea.quantity.contains("Нет в наличии") {
            return "Нет в наличии"
        } else {
            return "Количество неизвестно"
        }
    }
}
