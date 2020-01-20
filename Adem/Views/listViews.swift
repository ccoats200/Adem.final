//
//  listViews.swift
//  Adem
//
//  Created by Coleman Coats on 1/7/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Product name view
class listTableView: UIView {
  
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
    let priceLabel: UILabel = {
        let cost = 2.99
        let price = UILabel()
        price.layer.cornerRadius = 5
        price.layer.masksToBounds = true
        price.text = "$\(cost)"
        price.textColor = UIColor.white
        price.font = UIFont.boldSystemFont(ofSize: 16)
        return price
    }()
    
    lazy var productNameAndBackButton: UIButton = {
        let back = UIButton(type: .system)
        //back.setTitle("Bread", for: .normal)
        back.setTitleColor(UIColor.white, for: .normal)
        back.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        back.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        return back
        
    }()
       
  //common func to init our view
  private func setupView() {
    //self.backgroundColor = UIColor.white.withAlphaComponent(0.10)
    self.addSubview(productNameAndBackButton)
    self.addSubview(priceLabel)
    productNameAndBackButton.translatesAutoresizingMaskIntoConstraints = false
    priceLabel.translatesAutoresizingMaskIntoConstraints = false
    productNameAndBackButton.clipsToBounds = true
    priceLabel.layer.cornerRadius = 20
    productNameAndBackButton.layer.cornerRadius = 20
    
    
    NSLayoutConstraint.activate([
    productNameAndBackButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    productNameAndBackButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    productNameAndBackButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -150),
    productNameAndBackButton.heightAnchor.constraint(equalToConstant: 50),
    
    priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    priceLabel.leadingAnchor.constraint(equalTo: productNameAndBackButton.trailingAnchor, constant: 15),
    priceLabel.widthAnchor.constraint(equalToConstant: 50),
    priceLabel.heightAnchor.constraint(equalToConstant: 50),
        
    ])
    }
}

