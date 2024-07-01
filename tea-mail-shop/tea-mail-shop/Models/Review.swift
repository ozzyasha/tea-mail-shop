//
//  Review.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 30.06.24.
//

import Foundation

struct Review: Identifiable {
    let id: String
    let review: String
    let reviewDate: String
    let teaName: String
    let username: String
    let avatar: String
    let teaId: Int
}
