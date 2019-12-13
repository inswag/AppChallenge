//
//  ProductController.swift
//  AppChallenge
//
//  Created by 박인수 on 11/12/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import UIKit
import SnapKit

class ProductController: UIViewController {
    
    // Network Properties
    var productId = 0
    var fetchedSelectedProduct: [Product] = []
    let productService: ProductServiceType = ProductService()
    
    // Tableview Properties
    private let cellId = "cellId"
    private let cellId2 = "cellId2"
    private let cellId3 = "cellId3"
    private let headerId = "headerId"
    private let footerId = "footerId"
    let tableView = UITableView()
    
    // purchase Property
    let purchaseButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.rgb(r: 255, g: 88, b: 108)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("구매하기", for: .normal)
        btn.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Black", size: 18.0)
        btn.layer.cornerRadius = 14
        return btn
    }()
    
    // Button Property
    lazy var closeButton: UIButton = {
        let btn = UIButton()
        let btnImg = UIImage(named: "baseline_close_white")
        btn.setImage(btnImg, for: .normal)
        btn.backgroundColor = UIColor.rgb(r: 24, g: 24, b: 40, a: 0.16)
        btn.addTarget(self, action: #selector(actionClose), for: .touchUpInside)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    @objc func actionClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: View Did Load
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupUIComponents()
        
        // Network
        self.fetchSelectedProduct(productId: self.productId)
//        print(self.fetchedSelectedProduct[0].seller)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIView.animate(withDuration: 2.0) {
            self.purchaseButton.center.y -= self.view.bounds.height
        }
    }
    
    fileprivate func setupUIComponents() {
        [purchaseButton, closeButton].forEach { self.view.addSubview($0) }
        self.purchaseButton.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(42)
            m.trailing.equalToSuperview().offset(-42)
            m.bottom.equalToSuperview().offset(-30)
            m.height.equalTo(52)
        }
        
        self.closeButton.snp.makeConstraints { (m) in
            m.top.equalTo(self.tableView.snp.top).offset(16)
            m.trailing.equalTo(self.tableView.snp.trailing).offset(-16)
            m.width.equalTo(40)
            m.height.equalTo(40)
        }
    }
    
    fileprivate func setupTableView() {
        self.view.backgroundColor = .black
        self.view.addSubview(tableView)
    
        self.tableView.snp.makeConstraints { (m) in
            m.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        
        self.tableView.backgroundColor = .black
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 400

        self.tableView.register(ProductImagesCell.self, forCellReuseIdentifier: cellId)
        self.tableView.register(ProductTagCell.self, forCellReuseIdentifier: cellId2)
        self.tableView.register(ProductDescriptionCell.self, forCellReuseIdentifier: cellId3)
    }
    
    
    
    // MARK:- Networks Methods
    fileprivate func fetchSelectedProduct(productId: Int) {
        productService.fetchSelectedProduct(productId: productId) { (result) in
            switch result {
            case .success(let value):
                self.fetchedSelectedProduct = value.body
                self.tableView.reloadData()
                print(self.fetchedSelectedProduct)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}

extension ProductController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ProductImagesCell
            cell.backgroundColor = .black
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId2", for: indexPath) as! ProductTagCell
            cell.backgroundColor = .white
            
            cell.sellerNameTitle.text = self.fetchedSelectedProduct.first?.seller
            cell.productNameTitle.text = self.fetchedSelectedProduct.first?.title
            
            
            // 할인이 있는 경우와 없는 경우를 따로 처리
            if self.fetchedSelectedProduct.first?.discountRate == nil {
                let attributedTitle = NSMutableAttributedString(string: "\(self.fetchedSelectedProduct.first?.cost ?? "")",
                                                                attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 20.0)!,
                                                                             NSAttributedString.Key.foregroundColor: UIColor.rgb(r: 20, g: 20, b: 40)])
                cell.priceNameTitle.attributedText = attributedTitle
                cell.priceNameTitle.textAlignment = .left
            } else {
                let attributedTitle = NSMutableAttributedString(string: "-\(self.fetchedSelectedProduct.first?.discountRate ?? "")  ",
                                                                attributes: [NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Black", size: 20.0)!,
                                                                             NSAttributedString.Key.foregroundColor: UIColor.rgb(r: 255, g: 88, b: 108)])
                attributedTitle.append(NSAttributedString(string: "\(self.fetchedSelectedProduct.first?.discountCost ?? "")  ",
                                                          attributes: [NSAttributedString.Key.font: UIFont(name: "NotoSansCJKkr-Black", size: 20.0)!,
                                                                       NSAttributedString.Key.foregroundColor: UIColor.rgb(r: 20, g: 20, b: 40)]))
                attributedTitle.append(NSAttributedString(string: "\(self.fetchedSelectedProduct.first?.cost ?? "")",
                                                          attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 20.0)!,
                                                                       NSAttributedString.Key.foregroundColor: UIColor.rgb(r: 171, g: 171, b: 196),
                                                                       NSAttributedString.Key.baselineOffset: 0,
                                                                       NSAttributedString.Key.strikethroughStyle: 1]))
                cell.priceNameTitle.attributedText = attributedTitle
                cell.priceNameTitle.textAlignment = .left
            }
            
            
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId3", for: indexPath) as! ProductDescriptionCell
            cell.backgroundColor = .white
            cell.productDescriptionTitle.text = self.fetchedSelectedProduct.first?.description
            return cell
        default:
            print("indexPath Error")
        }
        return UITableViewCell()
    }
    

}

extension ProductController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 0:
            return self.view.frame.width
        case 1:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    
}
