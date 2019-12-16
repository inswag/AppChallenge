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
    let tableView = UITableView()
    
    // purchase Property
    lazy var purchaseButton: UIButton = {
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
        // UI
        self.setupTableView()
        self.setupUIComponents()
        
        // Network
        self.fetchSelectedProduct(productId: self.productId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.purchaseButton.snp.updateConstraints { (m) in
            m.leading.equalToSuperview().offset(42)
            m.trailing.equalToSuperview().offset(-42)
            m.bottom.equalToSuperview().offset(-30)
            m.height.equalTo(52)
        }
        
        UIView.animate(withDuration: 2.0) {
//            self.purchaseButton.frame = CGRect(x: 0, y: 0, width: 60, height: 50)
            
            
            self.view.layoutIfNeeded()
//            self.purchaseButton.backgroundColor = .red
//            self.purchaseButton.center.y -= self.view.bounds.height
//            self.purchaseButton.center.y = 0
        }
    }
    
     
    
    fileprivate func setupUIComponents() {
        [purchaseButton, closeButton].forEach { self.view.addSubview($0) }
        self.purchaseButton.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(42)
            m.trailing.equalToSuperview().offset(-42)
            m.bottom.equalToSuperview().offset(130)
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
        self.tableView.register(ProductImageCell.self, forCellReuseIdentifier: String(describing: ProductImageCell.self))
        self.tableView.register(ProductTagCell.self, forCellReuseIdentifier: String(describing: ProductTagCell.self))
        self.tableView.register(ProductDescriptionCell.self, forCellReuseIdentifier: String(describing: ProductDescriptionCell.self))
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
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductImageCell.self), for: indexPath) as! ProductImageCell
            if let thumbnailList = self.fetchedSelectedProduct.first?.thumbnailList320 {
                cell.configure(content: thumbnailList)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductTagCell.self), for: indexPath) as! ProductTagCell
            
            cell.configure(seller: self.fetchedSelectedProduct.first?.seller ?? "",
                           title: self.fetchedSelectedProduct.first?.title ?? "",
                           discountRate: self.fetchedSelectedProduct.first?.discountRate,
                           discountCost: self.fetchedSelectedProduct.first?.discountCost,
                           cost: self.fetchedSelectedProduct.first?.cost ?? "")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductDescriptionCell.self), for: indexPath) as! ProductDescriptionCell
            cell.configure(description: self.fetchedSelectedProduct.first?.description ?? "")
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
        default:
            return UITableView.automaticDimension
        }
    }
    
}
