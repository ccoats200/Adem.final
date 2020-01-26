//
//  ProductsView.swift
//  Adem
//
//  Created by Coleman Coats on 1/3/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Product name view
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
    
     var productNameAndBackButton: UIButton = {
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

//MARK: Product image view
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
        lightColor.layer.masksToBounds = true
        lightColor.widthAnchor.constraint(equalToConstant: 300).isActive = true
        lightColor.heightAnchor.constraint(equalToConstant: 300).isActive = true
        lightColor.layer.cornerRadius = 150
        lightColor.translatesAutoresizingMaskIntoConstraints = false
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
        
        productImageDesign.widthAnchor.constraint(equalToConstant: 200).isActive = true
        productImageDesign.heightAnchor.constraint(equalToConstant: 200).isActive = true //125 also looks good
        print("Created Image for the product image in the details VC")
        productImageDesign.translatesAutoresizingMaskIntoConstraints = false
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
    productImage.clipsToBounds = true

    
    
    NSLayoutConstraint.activate([
    //Product Image matting
    imageMatting.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
    imageMatting.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    imageMatting.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    
    //Prodcut Image
    productImage.centerXAnchor.constraint(equalTo: imageMatting.centerXAnchor),
    productImage.centerYAnchor.constraint(equalTo: imageMatting.centerYAnchor),

        
    ])
  }
}


//MARK: Product info view
class productInfoViews: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
  
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
    
    let productDescription: UILabel = {
        let desc = "This is a test of the label"
        let description = UILabel()
        description.layer.masksToBounds = true
        description.text = "\(desc)"
        description.textColor = UIColor.ademBlue
        description.font = UIFont.boldSystemFont(ofSize: 16)
        return description
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! recommendedProductCells
        
        productCell.backgroundColor = UIColor.white
        
        
        return productCell
    }
    
    let whereToBuy: UIButton = {
        let notify = UIButton()
        let notifyImage = UIImage(named: infoImage)
        notify.setImage(notifyImage, for: .normal)
        notify.translatesAutoresizingMaskIntoConstraints = false
        notify.contentMode = .scaleAspectFit
        //notify.backgroundColor = UIColor.blue
        return notify
    }()
    
    let favoriteProduct: UIButton = {
        let faveProduct = UIButton()
        let faveImage = UIImage(named: heartImage)
        faveProduct.setImage(faveImage, for: .normal)
        faveProduct.translatesAutoresizingMaskIntoConstraints = false
        faveProduct.contentMode = .scaleAspectFit
        faveProduct.backgroundColor = UIColor.blue
        return faveProduct
    }()
    
    let listQuantity: UIButton = {
        let lQuant = UIButton()
        let lQuantImg = UIImage(named: nutritionFacts)
        lQuant.setImage(lQuantImg, for: .normal)
        lQuant.translatesAutoresizingMaskIntoConstraints = false
        lQuant.contentMode = .scaleAspectFit
        //notify.backgroundColor = UIColor.blue
        return lQuant
    }()

    lazy var nutritionDetails: UIButton = {
        let facts = UIButton()
        let image = UIImage(named: "Vegan")
        //facts.backgroundImage(for: .normal)
        facts.setImage(image, for: .normal)
        facts.translatesAutoresizingMaskIntoConstraints = false
        facts.contentMode = .scaleAspectFit
        return facts
    }()
    
   
    private let pantryPageControl: UIPageControl = {
         let pc = UIPageControl()
          pc.currentPage = 0
          pc.numberOfPages = 3
          pc.currentPageIndicatorTintColor = UIColor.ademGreen
          pc.pageIndicatorTintColor = UIColor.ademBlue
          return pc
      }()
    
  
    var listProductCollectionView: UICollectionView!
    //var productCollectionView = additonalProductCollectionView()
    
    let cellID = "cell"
  
    //common func to init our view
    private func setupView() {
    
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        
        
        let layouts = UICollectionViewFlowLayout()
        let pCollectionView: UICollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layouts)
        
        layouts.itemSize = CGSize(width: 120, height: 120)
        //listProductCollectionView.contentInset = UIEdgeInsets.init(top: 10, left: 5, bottom: 1, right: 5)
        
        
        
        //collectionView
        pCollectionView.dataSource = self
        pCollectionView.delegate = self
        pCollectionView.register(recommendedProductCells.self, forCellWithReuseIdentifier: cellID)
        
        pCollectionView.backgroundColor = UIColor.ademGreen
    
        
        pCollectionView.clipsToBounds = true
        pCollectionView.layer.masksToBounds = true
        pCollectionView.isScrollEnabled = true
    
        self.addSubview(productDescription)
        self.addSubview(pCollectionView)
        
        pCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productDescription.translatesAutoresizingMaskIntoConstraints = false
    
    
    let healthInfoStackView = UIStackView(arrangedSubviews: [nutritionDetails, favoriteProduct, whereToBuy, listQuantity])
    self.addSubview(healthInfoStackView)
    self.addSubview(pantryPageControl)
    pantryPageControl.translatesAutoresizingMaskIntoConstraints = false
    
    
    healthInfoStackView.contentMode = .scaleAspectFit
    healthInfoStackView.spacing = 5
    healthInfoStackView.setCustomSpacing(40, after: whereToBuy)
    healthInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    healthInfoStackView.clipsToBounds = true
    healthInfoStackView.layer.masksToBounds = true
    healthInfoStackView.distribution = .fillEqually
    healthInfoStackView.backgroundColor = UIColor.white
    
    NSLayoutConstraint.activate([
        //Product Image matting
        
        healthInfoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        healthInfoStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        healthInfoStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -12),
        healthInfoStackView.heightAnchor.constraint(equalToConstant: 25),
        
        productDescription.topAnchor.constraint(equalTo: healthInfoStackView.bottomAnchor, constant: 5),
        productDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        productDescription.heightAnchor.constraint(equalToConstant: 50),
        productDescription.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -12),
        
        
        pCollectionView.topAnchor.constraint(equalTo: productDescription.bottomAnchor, constant: 5),
        pCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        pCollectionView.bottomAnchor.constraint(equalTo: pantryPageControl.topAnchor),
        pCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -12),
        
        pantryPageControl.topAnchor.constraint(equalTo: pCollectionView.bottomAnchor),
        pantryPageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        pantryPageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        pantryPageControl.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -12),
        pantryPageControl.heightAnchor.constraint(equalToConstant: 25),
    
        
    ])
  }
}

