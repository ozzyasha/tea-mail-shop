//
//  Review.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 30.06.24.
//

import Foundation

struct Review: Identifiable {
    let id, review, reviewDate, teaName: String
    let teaId: Int
}
