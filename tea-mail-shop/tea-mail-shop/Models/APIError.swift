//
//  APIError.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import Foundation

enum APIError: Error {
    case urlError(String)
    case requestError(String)
    case responseError(String)
    case decodeError(String)
}
