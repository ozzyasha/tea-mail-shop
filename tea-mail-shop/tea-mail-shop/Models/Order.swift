//
//  Order.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 27.06.24.
//

import Foundation

struct Order: Identifiable {
    let id: Int
    var orderedTeasArray: [OrderedTea]
}
