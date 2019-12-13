//
//  ProductImagesCell.swift
//  AppChallenge
//
//  Created by 박인수 on 12/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductImagesCell: UITableViewCell {
    
    let cellID = "cellId"
    
    let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .red
        imgView.layer.cornerRadius = 30
        imgView.clipsToBounds = true
        imgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: cellID)
        
        
//        self.contentView.layer.cornerRadius = 50
//        self.contentView.clipsToBounds = true
        
        // Top Left Corner: .layerMinXMinYCorner
        // Top Right Corner: .layerMaxXMinYCorner
        // Bottom Left Corner: .layerMinXMaxYCorner
        // Bottom Right Corner: .layerMaxXMaxYCorner
//        self.contentView.layer.maskedCorners = []
        //        self.setupUIDesign()
        
        self.setupUIComponents()
    }
    
    func setupUIComponents() {
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.bottom.equalToSuperview()
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
