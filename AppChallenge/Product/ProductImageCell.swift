//
//  ProductImagesCell.swift
//  AppChallenge
//
//  Created by 박인수 on 12/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductImageCell: UITableViewCell {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.register(ProductImagesCell.self, forCellWithReuseIdentifier: String(describing: ProductImagesCell.self))
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: ProductController.self))

        layer.cornerRadius = 30
        clipsToBounds = true
        // Top Left Corner: .layerMinXMinYCorner
        // Top Right Corner: .layerMaxXMinYCorner
        // Bottom Left Corner: .layerMinXMaxYCorner
        // Bottom Right Corner: .layerMaxXMaxYCorner
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.setupUIComponents()
    }
    
    let progressView: UIProgressView = {
        let pgView = UIProgressView()
        pgView.progressTintColor = UIColor.white
        pgView.trackTintColor = UIColor.rgb(r: 0, g: 0, b: 10, a: 0.36)
        pgView.progress = 0.0
        pgView.setProgress(0.0, animated: true)
        return pgView
    }()
    
    func setupUIComponents() {
        [collectionView, progressView].forEach { self.addSubview($0) }
        self.collectionView.backgroundColor = .black
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        
        self.progressView.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            m.bottom.equalToSuperview().offset(-24)
            m.height.equalTo(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    var imageSet: [String] = []
    
    func configure(content: String) {
        self.imageSet = content.split(separator: "#").map { $0.replacingOccurrences(of: "320", with: "720") }
        self.collectionView.reloadData()
    }
}

extension ProductImageCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductImagesCell.self), for: indexPath) as! ProductImagesCell
        cell.configure(content: self.imageSet[indexPath.row])
        return cell
    }
    
}

extension ProductImageCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.contentView.frame.width
        let height = self.contentView.frame.height
        return CGSize(width: width, height: width)
    }
}
