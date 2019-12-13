//
//  ProductTagCell.swift
//  AppChallenge
//
//  Created by 박인수 on 12/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductTagCell: UITableViewCell {
    
    let cellID = "cellId2"
    
    let sellerNameTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansCJKkr-Black", size: 12.0)
        label.text = "Seller"
        label.numberOfLines = 1
        label.textColor = UIColor.rgb(r: 74, g: 144, b: 226)
        return label
    }()
    
    let productNameTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansCJKkr-Black", size: 40.0)
        label.text = "ProductName"
        label.numberOfLines = 1
        label.textColor = UIColor.rgb(r: 20, g: 20, b: 40)
        return label
    }()
    
    let priceNameTitle: UILabel = {
        let label = UILabel()
        let attributedTitle = NSMutableAttributedString(string: "-100%  ",
                                                        attributes: [NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Black", size: 20.0)!,
                                                                     NSAttributedString.Key.foregroundColor: UIColor.rgb(r: 255, g: 88, b: 108)])
        attributedTitle.append(NSAttributedString(string: "177,300",
                                                  attributes: [NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Black", size: 20.0)!,
                                                               NSAttributedString.Key.foregroundColor: UIColor.rgb(r: 20, g: 20, b: 40)]))
        attributedTitle.append(NSAttributedString(string: "원  ",
                                                  attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 20.0)!,
                                                               NSAttributedString.Key.foregroundColor: UIColor.rgb(r: 20, g: 20, b: 40)]))
        attributedTitle.append(NSAttributedString(string: "197,000원",
                                                  attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 20.0)!,
                                                               NSAttributedString.Key.foregroundColor: UIColor.rgb(r: 171, g: 171, b: 196)]))
        label.attributedText = attributedTitle
        label.textAlignment = .left
        return label
    }()
    
    let seperatedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(r: 236, g: 236, b: 245)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: cellID)
        self.setupUIComponents()
    }
    
    func setupUIComponents() {
        [sellerNameTitle, productNameTitle, priceNameTitle, seperatedView].forEach { self.contentView.addSubview($0) }
        
        sellerNameTitle.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(24)
            m.leading.equalToSuperview().offset(26)
            m.trailing.equalToSuperview().offset(-22)
            // Intrinsic Content Size
            m.height.equalTo(20)
        }
        
        productNameTitle.snp.makeConstraints { (m) in
            m.top.equalTo(self.sellerNameTitle.snp.bottom).offset(16)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            // Intrinsic Content Size
            m.height.equalTo(48)
        }
        
        priceNameTitle.snp.makeConstraints { (m) in
            m.top.equalTo(self.productNameTitle.snp.bottom).offset(32)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            // Intrinsic Content Size
            m.height.equalTo(24)
        }
        
        seperatedView.snp.makeConstraints { (m) in
            m.top.equalTo(self.priceNameTitle.snp.bottom).offset(32)
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            m.height.equalTo(2)
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
