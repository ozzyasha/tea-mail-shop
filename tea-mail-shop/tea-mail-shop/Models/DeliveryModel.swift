//
//  DeliveryModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 23.06.24.
//

import Foundation
import SwiftUI

class DeliveryModel: Identifiable {
    let id = UUID()
    var option: String
    var description: String
    var isExpanded: Binding<Bool>

    init(option: String, description: String, isExpanded: Binding<Bool>) {
        self.option = option
        self.description = description
        self.isExpanded = isExpanded
    }
}
