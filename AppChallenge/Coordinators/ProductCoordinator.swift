 //
 //  ProductCoordinator.swift
 //  AppChallenge
 //
 //  Created by 박인수 on 23/12/2019.
 //  Copyright © 2019 inswag. All rights reserved.
 //
 
 import UIKit
 
 class ProductCoordinator: Coordinator {
    private let presenter: UINavigationController  // 1
    private var productController: ProductController? // 2
    private var wordProductsController: ProductsController? // 3
    //  private let kanjiStorage: KanjiStorage  // 4
    //  private let kanji: Kanji  // 5
    
    private let product: Int
    
    
    init(presenter: UINavigationController, product: Int) {
        
        //    self.kanji = kanji
        self.presenter = presenter
        //    self.kanjiStorage = kanjiStorage
        self.product = product
    }
    
    func start() {
        let productController = ProductController(nibName: nil, bundle: nil) // 7
        //    kanjiDetailViewController.title = "Kanji details"
        //    kanjiDetailViewController.selectedKanji = kanji
        
        presenter.pushViewController(productController, animated: true) // 8
        self.productController = productController
    }
 }
