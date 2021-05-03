//
//  WebService.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import UIKit

enum MyError: Error {
    case InvalidURL
    case APIDataEmpty
    case InvalidDecodableObject
    case ErrorWithConnection
}

class WebService {
    
    private init() {}
    static let shared = WebService()
    
    func fetchData<T: Decodable>(url: String,type: T.Type , completionHandler: @escaping (Result<T,MyError>) -> Void) {
       
        guard let url = URL(string: url) else {
            completionHandler(.failure(.InvalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data , res , error) in
            if let _ = error {
                completionHandler(.failure(.ErrorWithConnection))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.APIDataEmpty))
                return
            }
            
            guard let json = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(.failure(.InvalidDecodableObject))
                return
            }
            completionHandler(.success(json))
            
        }.resume()
        
    }
    
    func fetchImageData(url: String , completionHandler: @escaping (Result<Data?,MyError>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(.InvalidURL))
            return }
        URLSession.shared.dataTask(with: url) { (data , res , error) in
            if let _ = error {
                completionHandler(.failure(.ErrorWithConnection))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.APIDataEmpty))
                return
            }
            completionHandler(.success(data))
        }.resume()
    }
    
}
