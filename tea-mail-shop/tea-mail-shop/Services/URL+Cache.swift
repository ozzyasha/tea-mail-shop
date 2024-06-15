//
//  URL+Cache.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import Foundation

extension URL {
    static func cacheDirectory(for filename: String) -> URL? {
        guard var directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        directory.append(component: filename)
        return directory
    }
}
