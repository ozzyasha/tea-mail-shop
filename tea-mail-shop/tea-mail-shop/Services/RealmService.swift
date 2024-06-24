//
//  RealmService.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import Foundation
import RealmSwift

class RealmService {
    static let shared = RealmService()
    
    private init() { }
    
    var teaCatalogue: [TeaCatalogueModel] = []
    var sliderItems: [SliderItemsModel] = []
    
    lazy var realm: Realm? = {
        do {
            let _realm = try Realm()
            return _realm
        } catch {
            print(error.localizedDescription) // алерт
            return nil
        }
    }()
    
    func addCachedImage(url: String, filename: String) {
        let imageInfo = CachedImageInfo()
        imageInfo.filename = filename
        imageInfo.url = url
        
        guard let realm else {
            print("Something went wrong with database") // алерт
            return
        }
        realm.writeAsync {
            if let previousCache = self.getCachedImage(for: url) {
                realm.delete(previousCache)
            }
            realm.add(imageInfo, update: .all)
        }
    }
    
    func getCachedImage(for url: String) -> CachedImageInfo? {
        guard let realm else {
            print("Can't get saved values") // алерт
            return nil
        }
        return realm.objects(CachedImageInfo.self).filter{ $0.url == url }.last
    }
    
    func saveOrUpdateTea(teaModel: TeaCatalogueModel) {
        let teaObject = TeaCatalogueRealmModel(tea: teaModel)
        
        guard let realm else {
            print("Something went wrong with database") // алерт
            return
        }
        
        realm.writeAsync {
            realm.add(teaObject, update: .all)
        }
    }
    
    func readAllTeaCatalogueFromDatabase() -> [TeaCatalogueModel] {
        guard let realm else {
            print("Can't get saved values") // алерт
            return []
        }
        realm.objects(TeaCatalogueRealmModel.self).map { $0 }.forEach({ tea in
            teaCatalogue.append(TeaCatalogueModel(id: tea._id, name: tea.name, price: tea.price, img: tea.img, description: tea.description, quantity: tea.quantity))
        })
        return teaCatalogue
    }
    
    func deleteAllTeaCatalogueFromDatabase() {
        guard let realm else {
            print("Can't get saved values") // алерт
            return
        }
        realm.writeAsync {
            realm.deleteAll()
            self.teaCatalogue.removeAll()
        }
    }
    
    func saveOrUpdateSliderItem(sliderItem: SliderItemsModel) {
        let sliderItemObject = SliderItemsRealmModel(item: sliderItem)
        
        guard let realm else {
            print("Something went wrong with database") // алерт
            return
        }
        
        realm.writeAsync {
            realm.add(sliderItemObject, update: .all)
        }
    }
    
    func readAllSliderItemsFromDatabase() -> [SliderItemsModel] {
        guard let realm else {
            print("Can't get saved values") // алерт
            return []
        }
        realm.objects(SliderItemsRealmModel.self).map { $0 }.forEach({ item in
            sliderItems.append(SliderItemsModel(id: item._id, img: item.img, url: item.url))
        })
        return sliderItems
    }

    
}
