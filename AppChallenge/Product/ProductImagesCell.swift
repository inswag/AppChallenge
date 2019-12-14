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
    }
    
    func setupUIComponents() {
        self.contentView.addSubview(imageView)
        self.imageView.snp.makeConstraints { (m) in
            m.top.equalTo(self.contentView.snp.top)
            m.leading.equalTo(self.contentView.snp.leading)
            m.trailing.equalTo(self.contentView.snp.trailing)
            m.bottom.equalTo(self.contentView.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
