//
//  ProductsController.swift
//  AppChallenge
//
//  Created by 박인수 on 10/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

protocol ProductsControllerDelegate: class {
    func productsControllerDidSelectNumber(_ selectedProduct: Int)
}

class ProductsController: UIViewController {

    weak var delegate: ProductsControllerDelegate?
    
    // Network Property
    let productsService: ProductsServiceType = ProductsService()
    var fetchedProducts: [Products] = []
    var since: Int = 2
    
    // CollectionView Property
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.setCollectionViewLayout(layout, animated: true)
        return cv
    }()
    
    // Navigation
    let storefrontImageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 18))
        imgView.image = UIImage(named: "storefront_black")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavi()
        self.setupCollectionView()
        self.setupUIComponents()
        
        self.fetchProducts()
        
        
    }
    
    fileprivate func setupNavi() {
        self.navigationItem.titleView = storefrontImageView
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.shadowColor = UIColor.black
    }
    
    fileprivate func setupCollectionView() {
        self.collectionView.backgroundColor = .white
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(ProductsCell.self, forCellWithReuseIdentifier: String(describing: ProductsCell.self))
        self.collectionView.register(ProductsFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: ProductsFooter.self))
    }
    
    fileprivate func setupUIComponents() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.bottom.equalToSuperview()
        }
    }
    

    
    // MARK:- Networks Methods
    fileprivate func fetchProducts(since: Int = 1) { 
        productsService.fetchProducts(since: since) { (result) in
            switch result {
            case .success(let value):
                value.body.forEach {
                    self.fetchedProducts.append($0)
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
//                self.since = 0
                
            }
        }
    }
    
    fileprivate func paginateProducts() {
        print("will Paginate User List!")
        print("pageNumber: ", since)
        fetchProducts(since: since)
        since += 1
    }
}

extension ProductsController: UICollectionViewDataSource {
    
    // Handle Collection View Number Of Items In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfRowsInSection: \(fetchedProducts.count)")
        return self.fetchedProducts.count
    }
    
    // Handle Collection View Cell For Item AT
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductsCell.self), for: indexPath) as! ProductsCell
        cell.configure(imageUrl: self.fetchedProducts[indexPath.row].thumbnail,
                       productName: self.fetchedProducts[indexPath.row].title,
                       seller: self.fetchedProducts[indexPath.row].seller)
        return cell
    }
    
    // Handle Collection View Header & Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: ProductsFooter.self), for: indexPath) as! ProductsFooter
            
            
            return footer
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.fetchedProducts.count - 1 {
            self.paginateProducts()
        }
    }
    
    
}

extension ProductsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bothSideEdgeInset: CGFloat = 12 * 2
        let interItemSpacing: CGFloat = 7
        let width: CGFloat = (self.view.frame.width - interItemSpacing - bothSideEdgeInset) / 2
        let imgViewHeight: CGFloat = 172
        let Padding: CGFloat = 4
        let productTitleHeight: CGFloat = 40
        let sellerTitleHeight: CGFloat = 20
        let bottomPadding: CGFloat = 24
        let height: CGFloat = (imgViewHeight + Padding + productTitleHeight + sellerTitleHeight + bottomPadding)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width: CGFloat = self.view.frame.width
        let height: CGFloat = 20
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let productController = ProductController()
//        productController.modalPresentationStyle = .fullScreen
//        productController.productId = (indexPath.row + 1)
//        self.present(productController, animated: true)
        let productNumber = indexPath.row + 1
        delegate?.productsControllerDidSelectNumber(productNumber)
        
    
    }
    
}
