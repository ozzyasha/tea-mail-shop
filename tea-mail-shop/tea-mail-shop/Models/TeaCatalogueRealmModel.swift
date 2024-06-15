//
//  TeaCatalogueRealmModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import Foundation
import RealmSwift

class TeaCatalogueRealmModel: Object {
    
    @Persisted(primaryKey: true) var _id: Int
    @Persisted var name: String
    @Persisted var price: String
    @Persisted var img: String
    @Persisted var teaDescription: String
    @Persisted var quantity: String
    
    convenience init(tea: TeaCatalogueModel) {
        self.init()
        self._id = tea.id
        self.name = tea.name
        self.price = tea.price
        self.img = tea.img
        self.teaDescription = tea.description
        self.quantity = tea.quantity
    }
    
}
