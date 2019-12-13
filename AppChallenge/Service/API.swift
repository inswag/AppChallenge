//
//  API.swift
//  AppChallenge
//
//  Created by 박인수 on 12/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import Foundation

enum API {
    static let baseURL = "https://2jt4kq01ij.execute-api.ap-northeast-2.amazonaws.com/prod/"
    static let getProducts = "products?page="
    static let getSelectedProduct = "products/"
}

enum Result<T> {
    case success(T)
    case failure(Data?, Error)
}
