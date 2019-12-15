//
//  ProductImagesCellCollectionViewCell.swift
//  AppChallenge
//
//  Created by 박인수 on 14/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class ProductImagesCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = .white
        return imgView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    
    func configure(content: String) {
        let urlString = URL(string: content)
        self.imageView.kf.setImage(with: urlString)
        
//        self.scrollView.contentSize
    }
    
    func setupUIComponents() {
        self.contentView.addSubview(imageView)
        self.imageView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.bottom.equalToSuperview()
//            m.top.equalTo(self.scrollView.snp.top)
//            m.leading.equalTo(self.scrollView.snp.leading)
//            m.trailing.equalTo(self.scrollView.snp.trailing)
//            m.bottom.equalTo(self.scrollView.snp.bottom)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
