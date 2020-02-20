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
    
    let itemQuant: UIView = {
        let quant = UIView()
        quant.backgroundColor = UIColor.ademBlue
        quant.layer.cornerRadius = 5
        
        return quant
    }()
    
    let listQuantityButon: UIButton = {
        let lQuant = UIButton()
        lQuant.translatesAutoresizingMaskIntoConstraints = false
        lQuant.contentMode = .scaleAspectFit
        return lQuant
    }()
    
    let listQuantity: UILabel = {
        let lQuant = UILabel()
        var theMeaningOfLife = 42
        lQuant.textColor = UIColor.white
        lQuant.text = "Qty: \(theMeaningOfLife)"
        lQuant.translatesAutoresizingMaskIntoConstraints = false
        lQuant.contentMode = .scaleAspectFit
        return lQuant
    }()
    
    let qImage: UIImageView = {
        let qimg = UIImageView()
        qimg.image = UIImage(named: "vegan_selected")
        qimg.translatesAutoresizingMaskIntoConstraints = false
        qimg.contentMode = .scaleAspectFit
        return qimg
    }()

    lazy var nutritionDetails: UIButton = {
        let facts = UIButton()
        let image = UIImage(named: "vegan_selected")
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
    
    
    let healthInfoStackView = UIStackView(arrangedSubviews: [nutritionDetails, favoriteProduct, whereToBuy])

        addSubview(healthInfoStackView)
    addSubview(pantryPageControl)
    pantryPageControl.translatesAutoresizingMaskIntoConstraints = false
        
    
        addSubview(itemQuant)
        itemQuant.addSubview(listQuantity)
        itemQuant.addSubview(listQuantityButon)
        itemQuant.addSubview(qImage)

        listQuantityButon.translatesAutoresizingMaskIntoConstraints = false
        qImage.translatesAutoresizingMaskIntoConstraints = false
        listQuantity.translatesAutoresizingMaskIntoConstraints = false
        itemQuant.translatesAutoresizingMaskIntoConstraints = false
    
    
    healthInfoStackView.contentMode = .scaleAspectFit
    healthInfoStackView.spacing = 5
    healthInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    healthInfoStackView.clipsToBounds = true
    healthInfoStackView.layer.masksToBounds = true
    healthInfoStackView.distribution = .fillEqually
    healthInfoStackView.backgroundColor = UIColor.white
    
    NSLayoutConstraint.activate([
        //Product Image matting
        
        healthInfoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        healthInfoStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
        healthInfoStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
        healthInfoStackView.heightAnchor.constraint(equalToConstant: 25),
        
        
        itemQuant.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        itemQuant.widthAnchor.constraint(equalToConstant: 100),
        itemQuant.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
        itemQuant.heightAnchor.constraint(equalToConstant: 25),
        
        listQuantityButon.topAnchor.constraint(equalTo: itemQuant.topAnchor),
        listQuantityButon.widthAnchor.constraint(equalTo: itemQuant.widthAnchor),
        listQuantityButon.heightAnchor.constraint(equalTo: itemQuant.heightAnchor),
        
        listQuantity.topAnchor.constraint(equalTo: itemQuant.topAnchor),
        listQuantity.leftAnchor.constraint(equalTo: itemQuant.leftAnchor,constant: 5),
        listQuantity.rightAnchor.constraint(equalTo: qImage.leftAnchor),
        listQuantity.heightAnchor.constraint(equalTo: itemQuant.heightAnchor),
        
        qImage.topAnchor.constraint(equalTo: itemQuant.topAnchor),
        qImage.widthAnchor.constraint(equalToConstant: 25),
        qImage.rightAnchor.constraint(equalTo: itemQuant.rightAnchor, constant: -5),
        qImage.heightAnchor.constraint(equalTo: itemQuant.heightAnchor),
        
        
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

