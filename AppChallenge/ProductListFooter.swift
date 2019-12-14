//
//  ProductListFooterCell.swift
//  AppChallenge
//
//  Created by 박인수 on 10/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit

class ProductListFooter: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
//        imgView.tintColor = UIColor.rgb(r: 171, g: 171, b: 196)
        imgView.image = UIImage(named: "baseline_navigation_black")
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.setupUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUIComponents() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (m) in
            m.width.equalTo(20)
            m.height.equalTo(20)
            m.centerX.equalToSuperview()
            m.centerY.equalToSuperview()
        }
    }
}
