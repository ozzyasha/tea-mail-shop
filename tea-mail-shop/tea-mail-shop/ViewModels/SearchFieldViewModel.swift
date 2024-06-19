//
//  SearchFieldViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 19.06.24.
//
import SwiftUI

class SearchFieldViewModel: ObservableObject {
    
    @ObservedObject
    var teaVM: TeaViewModel
    
    @Published
    var searchText = ""
    
    init(teaVM: TeaViewModel) {
        self.teaVM = teaVM
    }
    
    
    var searchResults: [TeaCatalogueModel] {
        if searchText.isEmpty {
            return teaVM.teaCatalogueModel
        } else {
            return teaVM.teaCatalogueModel.filter { $0.name.contains(searchText) }
        }
    }
}
