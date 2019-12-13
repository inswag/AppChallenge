//
//  ProductList.swift
//  AppChallenge
//
//  Created by 박인수 on 12/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import Foundation

struct ProductsRoot: Decodable {
    
    let body: [Products]
    
    enum CodingKeys: String, CodingKey {
        case body
    }
    
}

struct Products: Decodable {
    
    let thumbnail: String
    let id: Int
    let seller: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case thumbnail = "thumbnail_520"
        case id, seller, title
    }
    
}
