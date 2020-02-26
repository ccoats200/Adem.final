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
    

    let productDescription: UITextView = {
        let desc = "This is a test of the label"
        let description = UITextView()
        description.layer.masksToBounds = true
        description.text = "\(desc)"
        description.isEditable = false
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
        var theMeaningOfLife = 1
        lQuant.textColor = UIColor.white
        lQuant.font = UIFont(name: hNBold, size: 17)
        lQuant.text = "Qty: \(theMeaningOfLife)"
        lQuant.translatesAutoresizingMaskIntoConstraints = false
        lQuant.contentMode = .scaleAspectFit
        return lQuant
    }()
    
    let qImage: UIImageView = {
        let qimg = UIImageView()
        qimg.image = UIImage(named: "arrow")
        qimg.contentMode = .scaleAspectFit
        qimg.translatesAutoresizingMaskIntoConstraints = false
        return qimg
    }()

    
    let segmentLabel: UILabel = {
        let meal = UILabel()
        meal.textColor = UIColor.ademBlue
        meal.text = "You May Also Like"
        meal.font = UIFont(name: hNBold, size: 18)
        meal.textAlignment = .center
        meal.layer.cornerRadius = 5
        meal.translatesAutoresizingMaskIntoConstraints = false
        return meal
    }()
    
    
    var listProductCollectionView: UICollectionView!
    
    let cellID = "cell"

    
    private func setUPCollection() {
        
        let layouts = UICollectionViewFlowLayout()
        layouts.itemSize = CGSize(width: 100, height: 100)
          
        listProductCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layouts)
        listProductCollectionView.isScrollEnabled = false
        listProductCollectionView.dataSource = self
        listProductCollectionView.delegate = self
        listProductCollectionView.register(recommendedProductCells.self, forCellWithReuseIdentifier: cellID)
        listProductCollectionView.backgroundColor = UIColor.white
               
        listProductCollectionView.clipsToBounds = true
        listProductCollectionView.layer.masksToBounds = true
        listProductCollectionView.isScrollEnabled = true
        
    }
  
    //common func to init our view
    private func setupView() {
    
        self.backgroundColor = UIColor.white
        setUPCollection()
       
    
        //MARK: Text line
        let textFieldSeparator = UIView()
        textFieldSeparator.backgroundColor = UIColor.ademBlue
        
        self.addSubview(productDescription)
        self.addSubview(listProductCollectionView)
        self.addSubview(segmentLabel)
        self.addSubview(textFieldSeparator)
        
        textFieldSeparator.translatesAutoresizingMaskIntoConstraints = false
        segmentLabel.translatesAutoresizingMaskIntoConstraints = false
        listProductCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productDescription.translatesAutoresizingMaskIntoConstraints = false
    
        

        self.addSubview(whereToBuy)
        
    
        self.addSubview(itemQuant)
        itemQuant.addSubview(listQuantity)
        itemQuant.addSubview(listQuantityButon)
        itemQuant.addSubview(qImage)

        listQuantityButon.translatesAutoresizingMaskIntoConstraints = false
        qImage.translatesAutoresizingMaskIntoConstraints = false
        listQuantity.translatesAutoresizingMaskIntoConstraints = false
        itemQuant.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
        
            whereToBuy.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            whereToBuy.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            whereToBuy.widthAnchor.constraint(equalToConstant: 30),
            whereToBuy.heightAnchor.constraint(equalToConstant: 30),
            
            itemQuant.centerYAnchor.constraint(equalTo: whereToBuy.centerYAnchor),
            itemQuant.widthAnchor.constraint(equalToConstant: 90),
            itemQuant.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            itemQuant.heightAnchor.constraint(equalTo: whereToBuy.heightAnchor),
            
            listQuantityButon.topAnchor.constraint(equalTo: itemQuant.topAnchor),
            listQuantityButon.widthAnchor.constraint(equalTo: itemQuant.widthAnchor),
            listQuantityButon.heightAnchor.constraint(equalTo: itemQuant.heightAnchor),
            
            listQuantity.topAnchor.constraint(equalTo: itemQuant.topAnchor),
            listQuantity.leftAnchor.constraint(equalTo: itemQuant.leftAnchor,constant: 5),
            listQuantity.rightAnchor.constraint(equalTo: qImage.leftAnchor),
            listQuantity.heightAnchor.constraint(equalTo: itemQuant.heightAnchor),
            
            qImage.centerYAnchor.constraint(equalTo: itemQuant.centerYAnchor),
            qImage.widthAnchor.constraint(equalToConstant: 25),
            qImage.rightAnchor.constraint(equalTo: itemQuant.rightAnchor, constant: -5),
            qImage.heightAnchor.constraint(equalTo: itemQuant.heightAnchor, multiplier: 1/2),
            
            productDescription.topAnchor.constraint(equalTo: whereToBuy.bottomAnchor, constant: 5),
            productDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productDescription.bottomAnchor.constraint(equalTo: segmentLabel.topAnchor, constant: -5),
            productDescription.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -12),
            
            segmentLabel.bottomAnchor.constraint(equalTo: textFieldSeparator.topAnchor, constant: -3),
            segmentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            segmentLabel.heightAnchor.constraint(equalToConstant: 30),
            segmentLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50),
            
            textFieldSeparator.bottomAnchor.constraint(equalTo: listProductCollectionView.topAnchor, constant: -10),
            textFieldSeparator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textFieldSeparator.heightAnchor.constraint(equalToConstant: 1),
            textFieldSeparator.widthAnchor.constraint(equalTo: segmentLabel.widthAnchor),
            
            listProductCollectionView.heightAnchor.constraint(equalToConstant: 120),
            listProductCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            listProductCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            listProductCollectionView.widthAnchor.constraint(equalTo: productDescription.widthAnchor),

    ])
  }
}

