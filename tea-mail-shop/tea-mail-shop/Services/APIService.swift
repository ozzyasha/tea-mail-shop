//
//  APIService.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 15.06.24.
//

import Foundation

class APIService {
    
    private init() { }
    
    static let shared = APIService()
    
    func fetchData(completionHandler: (([TeaCatalogueModel]) -> ())? = nil, errorHandler: ((APIError) -> ())? = nil) {
        DispatchQueue.global().async {
            guard let url = URL(string: "https://raw.githubusercontent.com/ozzyasha/tea-api/main/teaCatalogue.json") else {
                errorHandler?(APIError.urlError("URL error"))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard error == nil else {
                    errorHandler?(APIError.requestError(error?.localizedDescription ?? "Request error"))
                    return
                }
                
                guard let data = data else {
                    errorHandler?(APIError.responseError(error?.localizedDescription ?? "Response error"))
                    return
                }
                
                guard let teaResponse = try? JSONDecoder().decode(TeaCatalogueResponse.self, from: data) else {
                    errorHandler?(APIError.decodeError(error?.localizedDescription ?? "Decode error"))
                    return
                }
                
                completionHandler?(teaResponse.teaCatalogue)
            }
            task.resume()
        }
    }
}

