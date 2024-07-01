//
//  SearchFieldViewModelTests.swift
//  tea-mail-shopTests
//
//  Created by Наталья Мазур on 1.07.24.
//

import XCTest
@testable import tea_mail_shop


final class SearchFieldViewModelTests: XCTestCase {

    var teaVM: TeaViewModel!
    var searchFieldVM: SearchFieldViewModel!
    
    override func setUp() {
        super.setUp()
        teaVM = TeaViewModel()
        searchFieldVM = SearchFieldViewModel(teaVM: teaVM)
    }
    
    func testSearchResultsEmpty() {
        XCTAssertEqual(searchFieldVM.searchResults.count, teaVM.teaCatalogueModel.count)
    }
    
    func testSearchResultsNotEmpty() {
        let searchText = "Маття"
        searchFieldVM.searchText = searchText
        
        XCTAssertNotEqual(searchFieldVM.searchResults.count, teaVM.teaCatalogueModel.count)
    }
    
    func testSearchResultsCaseInsensitive() {
        let searchText = "маття"
        searchFieldVM.searchText = searchText
        let expectedResults = teaVM.teaCatalogueModel.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        XCTAssertEqual(searchFieldVM.searchResults[0].name, expectedResults[0].name)
    }



}
