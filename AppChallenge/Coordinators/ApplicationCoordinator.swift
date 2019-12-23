//
//  ApplicationCoordinator.swift
//  AppChallenge
//
//  Created by 박인수 on 23/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    //  let kanjiStorage: KanjiStorage //  1
    let window: UIWindow  // 2
    let rootViewController: UINavigationController  // 3
    let productsCoordinator: ProductsCoordinator
    
    init(window: UIWindow) { //4
        self.window = window
        //    kanjiStorage = KanjiStorage()
        rootViewController = UINavigationController()
        //    rootViewController.navigationBar.prefersLargeTitles = true
        
        
        productsCoordinator = ProductsCoordinator(presenter: rootViewController)
    }
    
    func start() {  // 6
        window.rootViewController = rootViewController
        productsCoordinator.start()
        window.makeKeyAndVisible()
    }
}

