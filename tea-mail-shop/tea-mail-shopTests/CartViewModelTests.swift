//
//  CartViewModelTests.swift
//  tea-mail-shopTests
//
//  Created by Наталья Мазур on 1.07.24.
//

import XCTest
@testable import tea_mail_shop

final class CartViewModelTests: XCTestCase {
    
    func testAddToCart() {
        let viewModel = CartViewModel()
        let tea = TeaCatalogueModel(id: 1, name: "Tea", price: "100 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "100 г.")
        
        let initialCount = viewModel.teaCart.count
        let initialTotalPrice = viewModel.totalPrice
        
        viewModel.addToCart(tea: tea)
        
        XCTAssertEqual(viewModel.teaCart.count, initialCount + 1)
        XCTAssertEqual(viewModel.totalPrice, initialTotalPrice + 100)
        XCTAssertTrue(viewModel.isAddedToCart["1"] ?? false)
    }
    
    func testRemoveOneItemFromCart() {
        let viewModel = CartViewModel()
        let tea = TeaCatalogueModel(id: 1, name: "Tea", price: "100 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "100 г.")
        let secondTea = TeaCatalogueModel(id: 2, name: "Second Tea", price: "100 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "100 г.")

        viewModel.addToCart(tea: tea)
        viewModel.addToCart(tea: secondTea)

        let initialCount = viewModel.teaCart.count
        let initialTotalPrice = viewModel.totalPrice

        viewModel.removeOneItemFromCart(tea: tea)

        XCTAssertEqual(viewModel.teaCart.count, initialCount - 1)
        XCTAssertEqual(viewModel.totalPrice, initialTotalPrice - 100)
        XCTAssertFalse(viewModel.isAddedToCart["1"] ?? true)
    }
    
    func testRemoveGroupFromCart() {
        let viewModel = CartViewModel()
        let tea = TeaCatalogueModel(id: 1, name: "Tea", price: "100 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "100 г.")
        let secondTea = TeaCatalogueModel(id: 2, name: "Second Tea", price: "100 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "100 г.")

        viewModel.addToCart(tea: tea)
        viewModel.addToCart(tea: tea)
        viewModel.addToCart(tea: secondTea)

        let initialTotalPrice = viewModel.totalPrice

        viewModel.removeGroupFromCart(tea: tea)

        XCTAssertEqual(viewModel.teaCart.count, 1)
        XCTAssertEqual(viewModel.totalPrice, initialTotalPrice - 200)
        XCTAssertFalse(viewModel.isAddedToCart["1"] ?? true)
    }
    
    func testRemoveAllFromCart() {
        let viewModel = CartViewModel()
        let tea = TeaCatalogueModel(id: 1, name: "Tea", price: "100 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "100 г.")
        let secondTea = TeaCatalogueModel(id: 2, name: "Second Tea", price: "100 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "100 г.")

        viewModel.addToCart(tea: tea)
        viewModel.addToCart(tea: secondTea)

        viewModel.removeAllFromCart()

        XCTAssertEqual(viewModel.teaCart.count, 0)
        XCTAssertTrue(viewModel.isAddedToCart.isEmpty)
        XCTAssertEqual(viewModel.totalPrice, 0)
    }
    
    func testGetPrice() {
        let viewModel = CartViewModel()
        let tea = TeaCatalogueModel(id: 1, name: "Tea", price: "100 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "100 г.")
        let secondTea = TeaCatalogueModel(id: 2, name: "Second Tea", price: "150 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "100 г.")

        viewModel.addToCart(tea: tea)
        viewModel.addToCart(tea: secondTea)
        viewModel.addToCart(tea: tea)

        XCTAssertEqual(viewModel.getPrice(for: tea), "200 Br")
        XCTAssertEqual(viewModel.getPrice(for: secondTea), "150 Br")
    }
    
    func testGetQuantity() {
        let viewModel = CartViewModel()
        let tea = TeaCatalogueModel(id: 1, name: "Tea", price: "100 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "150 г.")
        let secondTea = TeaCatalogueModel(id: 2, name: "Second Tea", price: "150 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "1 шт.")
        let thirdTea = TeaCatalogueModel(id: 3, name: "Second Tea", price: "150 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "Нет в наличии")
        let fourthTea = TeaCatalogueModel(id: 4, name: "Second Tea", price: "150 Br", img: "https://tea-mail.by/wa-data/public/shop/products/82/83/8382/images/32944/32944.750.jpg", teaDescription: "description", quantity: "127865")

        viewModel.addToCart(tea: tea)
        viewModel.addToCart(tea: secondTea)
        viewModel.addToCart(tea: tea)
        viewModel.addToCart(tea: secondTea)
        viewModel.addToCart(tea: thirdTea)
        viewModel.addToCart(tea: fourthTea)

        XCTAssertEqual(viewModel.getQuantity(for: tea), "300 г.")
        XCTAssertEqual(viewModel.getQuantity(for: secondTea), "2 шт.")
        XCTAssertEqual(viewModel.getQuantity(for: thirdTea), "Нет в наличии")
        XCTAssertEqual(viewModel.getQuantity(for: fourthTea), "Количество неизвестно")
    }
    
    
}
