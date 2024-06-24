//
//  DeliveryAndPaymentModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 23.06.24.
//

import Foundation

class DeliveryAndPaymentModel: Identifiable {
    let id = UUID()
    var option: String
    var description: String

    init(option: String, description: String) {
        self.option = option
        self.description = description
    }
}
