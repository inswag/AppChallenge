//
//  ProductListController.swift
//  AppChallenge
//
//  Created by 박인수 on 10/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductListController: UIViewController {
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    private let footerId = "footerId"
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavi()
        self.setupCollectionView()
        self.setupUIComponents()
        
    }
    
    fileprivate func setupNavi() {
        self.navigationItem.titleView = storefrontImageView
//        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    
    fileprivate func setupCollectionView() {
        self.collectionView.backgroundColor = .white
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView.register(ProductListFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
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
    
}

extension ProductListController: UICollectionViewDataSource {
    
    // Handle Collection View Number Of Items In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    // Handle Collection View Cell For Item AT
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductListCell
        cell.backgroundColor = .yellow
        return cell
    }
    
    // Handle Collection View Header & Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
            return footer
        default:
            return UICollectionReusableView()
        }
        
        
    }
    
}

extension ProductListController: UICollectionViewDelegateFlowLayout {
    
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
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailController = ProductDetailController()
        productDetailController.modalPresentationStyle = .fullScreen
        self.present(productDetailController, animated: true)
    }
    
}
