//
//  ProductsCoordinator.swift
//  AppChallenge
//
//  Created by 박인수 on 23/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class ProductsCoordinator: Coordinator {
    
    private let presenter: UINavigationController  // 1
    private var productsController: ProductsController? // 3
    
//    private var product: Int
    
    //  private let allKanjiList: [Kanji]  // 2
    //  private let kanjiStorage: KanjiStorage // 4

    private var productCoordinator: ProductCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
//        self.product = product
    }
    
    func start() {
        let productsController = ProductsController(nibName: nil, bundle: nil) // 6
        productsController.delegate = self
        //    productsController.title = "Kanji list"
        //    kanjiListViewController.kanjiList = allKanjiList
        presenter.pushViewController(productsController, animated: true)  // 7
        self.productsController = productsController
    }
}

// MARK: - KanjiListViewControllerDelegate
extension ProductsCoordinator: ProductsControllerDelegate {
    
    func productsControllerDidSelectNumber(_ selectedProduct: Int) {
        let productCoordinator = ProductCoordinator(presenter: presenter, product: selectedProduct)
        productCoordinator.start()

        self.productCoordinator = productCoordinator
    }
    
}
