//
//  ProductsView.swift
//  Adem
//
//  Created by Coleman Coats on 1/3/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Continued info view
class productViews: UIView {
  
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
        back.setTitle("Bread", for: .normal)
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

//MARK: Continued info view
class productImageViews: UIView {
  
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
  
    let imageMatting: UIView = {
        let lightColor = UIView()
        lightColor.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        lightColor.translatesAutoresizingMaskIntoConstraints = false
        lightColor.layer.masksToBounds = true
        lightColor.widthAnchor.constraint(equalToConstant: 300).isActive = true
        lightColor.heightAnchor.constraint(equalToConstant: 300).isActive = true
        lightColor.layer.cornerRadius = 150
        return lightColor
    }()
    
    let productImage: UIImageView = {
        let productImageDesign = UIImageView()
        productImageDesign.image = UIImage(named: "bread")
        productImageDesign.contentMode = .center
        productImageDesign.contentMode = .scaleAspectFill
        productImageDesign.clipsToBounds = true
        productImageDesign.layer.masksToBounds = true
        productImageDesign.layer.cornerRadius = 25
        productImageDesign.layer.borderWidth = 1
        productImageDesign.layer.borderColor = UIColor.white.cgColor
        productImageDesign.translatesAutoresizingMaskIntoConstraints = false
        productImageDesign.widthAnchor.constraint(equalToConstant: 200).isActive = true
        productImageDesign.heightAnchor.constraint(equalToConstant: 200).isActive = true //125 also looks good
        print("Created Image for the product image in the details VC")
        return productImageDesign
    }()
       
  //common func to init our view
  private func setupView() {
    //self.backgroundColor = UIColor.white.withAlphaComponent(0.10)
    self.addSubview(imageMatting)
    self.addSubview(productImage)
    imageMatting.translatesAutoresizingMaskIntoConstraints = false
    productImage.translatesAutoresizingMaskIntoConstraints = false
    imageMatting.clipsToBounds = true

    
    
    NSLayoutConstraint.activate([
    //Product Image matting
    imageMatting.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
    imageMatting.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    
    //Prodcut Image
    productImage.centerXAnchor.constraint(equalTo: imageMatting.centerXAnchor),
    productImage.centerYAnchor.constraint(equalTo: imageMatting.centerYAnchor),

        
    ])
  }
}







