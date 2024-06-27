//
//  OrdersFirebaseFields.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 26.06.24.
//

import Foundation

enum OrdersFirebaseFields: String {
    case collection = "orders"
    case id = "id"
}

enum TeasFirebaseFields: String {
    case collection = "orderedTeaItems"
    case id = "id"
    case name = "name"
    case price = "price"
    case quantity = "quantity"
}
