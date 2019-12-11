//
//  ProductListCell.swift
//  AppChallenge
//
//  Created by 박인수 on 10/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductListCell: UICollectionViewCell {
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        // .scaleAspectFill : 사진의 본래에 사이즈에 맞춘다.
        iv.contentMode = .scaleAspectFill
        // .clipsToBounds = true  : 사진을 셀 사이즈까지만 보여주게 자른다.
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 15
        return iv
    }()
    
    let productNameTitle: UILabel = {
        let label = UILabel()
//        label.font = UIFont(name: "NotoSansCJKkr-Black", size: 14.0)!
        label.font = UIFont(name: "Avenir-Black", size: 14.0)!
        label.text = "ProductName\nProductName"
        label.numberOfLines = 2
        label.textColor = UIColor.rgb(r: 20, g: 20, b: 40)
        return label
    }()
    
    let sellerNameTitle: UILabel = {
        let label = UILabel()
//        label.font = UIFont(name: "NotoSansCJKkr-Black", size: 14.0)!
        label.font = UIFont(name: "Avenir-Black", size: 14.0)!
        label.text = "Seller"
        label.numberOfLines = 2
        label.textColor = UIColor.rgb(r: 171, g: 171, b: 196)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    
    func setupUIComponents() {
        [photoImageView, productNameTitle, sellerNameTitle].forEach { self.contentView.addSubview($0) }
        
        photoImageView.snp.makeConstraints { (m) in
            m.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top)
            m.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading)
            m.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing)
            m.height.equalTo(172)
        }
        
        productNameTitle.snp.makeConstraints { (m) in
            m.top.equalTo(self.photoImageView.snp.bottom).offset(4)
            m.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(8)
            m.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing).offset(-8)
            m.height.equalTo(40)
        }
        
        sellerNameTitle.snp.makeConstraints { (m) in
            m.top.equalTo(self.productNameTitle.snp.bottom)
            m.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(8)
            m.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing).offset(-8)
            m.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

