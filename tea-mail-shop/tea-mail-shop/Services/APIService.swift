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
    
    func fetchData<T: Decodable>(endpoint: Endpoint, responseType: T.Type, completionHandler: ((T) -> ())? = nil, errorHandler: ((APIError) -> ())? = nil) {
        DispatchQueue.global().async {
            guard let url = URL(string: endpoint.rawValue) else {
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
                
                guard let decodedResponse = try? JSONDecoder().decode(responseType, from: data) else {
                    errorHandler?(APIError.decodeError(error?.localizedDescription ?? "Decode error"))
                    return
                }
                
                completionHandler?(decodedResponse)
            }
            task.resume()
        }
    }
}

