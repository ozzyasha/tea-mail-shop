//
//  CachedImageViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import Foundation

class CachedImageViewModel: ObservableObject {
    
    @Published
    var isCached = false
    @Published
    var cachedFilename = ""
    @Published
    var imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        if let filename = RealmService.shared.getCachedImage(for: imageUrl)?.filename,
           URL.cacheDirectory(for: filename) != nil {
            self.cachedFilename = filename
            self.isCached = true
        } else {
            CachedImageViewModel.getCacheUrlOfImage(from: imageUrl) { filename in
                guard let filename else { return }
                DispatchQueue.main.async {
                    self.cachedFilename = filename
                    RealmService.shared.addCachedImage(url: imageUrl, filename: filename)
                    self.isCached = true
                }
            }
        }
    }
    
    static func getCacheUrlOfImage(from url: String, completion: ((String?) -> Void)? = nil) {
        guard let url = URL(string: url) else { return }
        
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            let filename = getFilenameOfCached(data: data)
            completion?(filename)
        }
    }
    
    static func getFilenameOfCached(data: Data) -> String? {
        let filename = UUID().uuidString
        guard let directory = URL.cacheDirectory(for: filename) else {
            return nil
        }
        
        do {
            try data.write(to: directory)
            return filename
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
