//
//  SliderItemsModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 20.06.24.
//

import Foundation

struct SliderItemsModel: Codable, Identifiable {
    var id: String
    let img: String
    let url: String
    
    enum SliderItems: String, CodingKey {
        case id
        case img
        case url
    }
}

struct SliderItemsResponse: Codable {
    let sliderItems: [SliderItemsModel]
}

