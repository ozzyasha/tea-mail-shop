//
//  SliderItemsRealmModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 20.06.24.
//

import Foundation
import RealmSwift

class SliderItemsRealmModel: Object {
    
    @Persisted(primaryKey: true) var _id: String
    @Persisted var img: String
    @Persisted var url: String
    
    convenience init(item: SliderItemsModel) {
        self.init()
        self._id = item.id
        self.img = item.img
        self.url = item.url
    }
    
}
