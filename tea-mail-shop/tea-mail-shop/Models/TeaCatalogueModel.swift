//
//  TeaCatalogueModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import Foundation

struct TeaCatalogueModel: Codable, Identifiable {
    var id: Int
    let name: String
    let price: String
    let img: String
    let description: String
    let quantity: String
    
    enum TeaCatalogue: String, CodingKey {
        case id
        case name
        case price
        case img
        case description
        case quantity
    }
}

struct TeaCatalogueResponse: Codable {
    let teaCatalogue: [TeaCatalogueModel]
}

