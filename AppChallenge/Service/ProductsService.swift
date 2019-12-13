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
    func fetchProducts(since: Int, completion: @escaping (Result<ProductsRoot>) -> ())
}

struct ProductsService: ProductsServiceType {
    
    func fetchProducts(since: Int = 1, completion: @escaping (Result<ProductsRoot>) -> ()) {
        
        let api = "\(API.baseURL)" + "\(API.getProducts)" + "\(since)"
        Alamofire
            .request(api, method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value) :
                    do {
                        let decodableValue = try JSONDecoder().decode(ProductsRoot.self, from: value)
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


