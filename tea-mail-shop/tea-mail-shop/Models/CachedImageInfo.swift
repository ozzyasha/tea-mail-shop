//
//  CachedImageInfo.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import Foundation
import RealmSwift

class CachedImageInfo: Object {
    
    @Persisted(primaryKey: true) var _id = UUID()
    @Persisted var url: String
    @Persisted var filename: String
}
