//
//  ProductService.swift
//  AppChallenge
//
//  Created by 박인수 on 12/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import Foundation
import Alamofire

protocol ProductServiceType {
    func fetchSelectedProduct(productId: Int, completion: @escaping (Result<ProductRoot>) -> ())
}



struct ProductService: ProductServiceType {
    
    func fetchSelectedProduct(productId: Int, completion: @escaping (Result<ProductRoot>) -> ()) {
        let api = "\(API.baseURL)" + "\(API.getSelectedProduct)" + "\(productId)"
        Alamofire
            .request(api, method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value) :
                    do {
                        let decodableValue = try JSONDecoder().decode(ProductRoot.self, from: value)
                        completion(Result.success(decodableValue))
                        
                    } catch {
                        completion(.failure(nil, error))
                    }
                case .failure(let error) :
                    completion(.failure(response.data!, error))
                }
        }
    }
}
