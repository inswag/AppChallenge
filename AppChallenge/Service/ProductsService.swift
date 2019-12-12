//
//  ProductsService.swift
//  AppChallenge
//
//  Created by 박인수 on 12/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import Foundation
import Alamofire

protocol ProductsServiceType {
    func fetchProducts(since: Int, completion: @escaping (Result<Root>) -> ())
}

enum API {
    static let baseURL = "https://2jt4kq01ij.execute-api.ap-northeast-2.amazonaws.com/prod/"
    static let getProducts = "products?page="
}

enum Result<T> {
    case success(T)
    case failure(Data?, Error)
}

struct ProductsService: ProductsServiceType {
    
    func fetchProducts(since: Int = 1, completion: @escaping (Result<Root>) -> ()) {
        
        let api = "\(API.baseURL)" + "\(API.getProducts)" + "\(since)"
        Alamofire
            .request(api, method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value) :
                    do {
                        let decodableValue = try JSONDecoder().decode(Root.self, from: value)
                        completion(Result.success(decodableValue))
//                        print(decodableValue)
                    } catch {
                        completion(.failure(nil, error))
                    }
                case .failure(let error) :
                    completion(.failure(response.data!, error))
                }
        }
    }
}


