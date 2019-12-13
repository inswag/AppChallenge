//
//  Product.swift
//  AppChallenge
//
//  Created by 박인수 on 12/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import Foundation

struct ProductRoot: Decodable {
    
    let body: [Product]
    
    enum CodingKeys: String, CodingKey {
        case body
    }
    
}

struct Product: Decodable {
    
    let id: Int                     // 상품 코드
    let thumbnail720: String        // 썸네일 이미지(720 size)
    let thumbnailList320: String    // 썸네일 이미지(320 size)
    let title: String               // 게시글 제목
    let seller: String              // 게시글 작성자
    let cost: String                // 상품 원가
    let discountCost: String?       // 상품 할인가
    let discountRate: String?       // 상품 할인율
    let description: String         // 상품 설명
    
    enum CodingKeys: String, CodingKey {
        case thumbnail720 = "thumbnail_720"
        case thumbnailList320 = "thumbnail_list_320"
        case discountCost = "discount_cost"
        case discountRate = "discount_rate"
        case id, title, seller, cost, description
    }
    
}
