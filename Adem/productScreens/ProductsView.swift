//
//  ProductsView.swift
//  Adem
//
//  Created by Coleman Coats on 1/3/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


protocol dynamicNameDelegate: class {
    func setNameForProduct(productName: String?, productPrice: String?)
}

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
    

    //make button later
    var priceLabel: UILabel = {
        let price = UILabel()
        price.layer.cornerRadius = 5
        price.layer.masksToBounds = true
        price.text = "$"
        price.textColor = UIColor.white
        price.font = UIFont.boldSystemFont(ofSize: 16)
        return price
    }()

    let nutritionButton: UIButton = {
        let notify = UIButton()
        let notifyImage = UIImage(named: infoImage)
        notify.setImage(notifyImage, for: .normal)
        notify.translatesAutoresizingMaskIntoConstraints = false
        notify.contentMode = .scaleAspectFit
        //notify.backgroundColor = UIColor.blue
        return notify
    }()
    
    var productNameAndBackButton: UIButton = {
       let back = UIButton(type: .system)
       back.setTitle("Try again", for: .normal)
       back.setTitleColor(UIColor.white, for: .normal)
       back.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
       back.backgroundColor = UIColor.white.withAlphaComponent(0.10)
       return back
       
   }()
    
     var addbacking: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

       
  //common func to init our view
  private func setupView() {
    self.addSubview(productNameAndBackButton)
    self.addSubview(priceLabel)
    self.addSubview(addbacking)
    addbacking.addSubview(nutritionButton)
    nutritionButton.translatesAutoresizingMaskIntoConstraints = false
    addbacking.translatesAutoresizingMaskIntoConstraints = false
    productNameAndBackButton.translatesAutoresizingMaskIntoConstraints = false
    priceLabel.translatesAutoresizingMaskIntoConstraints = false
    productNameAndBackButton.clipsToBounds = true
    priceLabel.layer.cornerRadius = 20
    productNameAndBackButton.layer.cornerRadius = 20
    addbacking.layer.cornerRadius = 20
    nutritionButton.layer.cornerRadius = 20
    
    NSLayoutConstraint.activate([

        
        
        productNameAndBackButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        productNameAndBackButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        productNameAndBackButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -150),
        productNameAndBackButton.heightAnchor.constraint(equalToConstant: 50),
    
        priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        priceLabel.trailingAnchor.constraint(equalTo: productNameAndBackButton.leadingAnchor, constant: 10),
        priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
        priceLabel.heightAnchor.constraint(equalToConstant: 50),
        
        addbacking.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        addbacking.leadingAnchor.constraint(equalTo: productNameAndBackButton.trailingAnchor, constant: 10),
        addbacking.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5),
        addbacking.heightAnchor.constraint(equalToConstant: 50),
        
        nutritionButton.centerYAnchor.constraint(equalTo: addbacking.centerYAnchor),
        nutritionButton.centerXAnchor.constraint(equalTo: addbacking.centerXAnchor),
        nutritionButton.heightAnchor.constraint(equalTo: addbacking.heightAnchor, constant: -2),
        nutritionButton.widthAnchor.constraint(equalTo: addbacking.widthAnchor, constant: -2),
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
//        lightColor.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        lightColor.heightAnchor.constraint(equalToConstant: 300).isActive = true
        lightColor.layer.cornerRadius = 150
//        lightColor.translatesAutoresizingMaskIntoConstraints = false
        return lightColor
    }()
    
    let productImage: UIImageView = {
        let productImageDesign = UIImageView()
        productImageDesign.contentMode = .center
        productImageDesign.contentMode = .scaleAspectFill
        productImageDesign.clipsToBounds = true
        productImageDesign.layer.masksToBounds = true
        productImageDesign.layer.cornerRadius = 25
        productImageDesign.layer.borderWidth = 1
        productImageDesign.layer.borderColor = UIColor.white.cgColor
        
//        productImageDesign.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        productImageDesign.heightAnchor.constraint(equalToConstant: 200).isActive = true //125 also looks good
//        productImageDesign.translatesAutoresizingMaskIntoConstraints = false
        return productImageDesign
    }()
    
    let listButtonBacking: UIView = {
        let lightColor = UIView()
        lightColor.backgroundColor = UIColor.white
        return lightColor
    }()
    
    var listButton: UIButton = {
        let addToPantry = UIButton(type: .system)
        addToPantry.setBackgroundImage(UIImage(named: "greenAddButton"), for: .normal)
        return addToPantry
    }()
    
       
  //common func to init our view
  private func setupView() {
    self.addSubview(imageMatting)
    self.addSubview(productImage)
    self.addSubview(listButtonBacking)
    listButtonBacking.addSubview(listButton)
    listButtonBacking.translatesAutoresizingMaskIntoConstraints = false
    listButton.translatesAutoresizingMaskIntoConstraints = false
    imageMatting.translatesAutoresizingMaskIntoConstraints = false
    productImage.translatesAutoresizingMaskIntoConstraints = false
    imageMatting.clipsToBounds = true
    productImage.clipsToBounds = true
    listButtonBacking.layer.cornerRadius = 20
    
    NSLayoutConstraint.activate([
        //Product Image matting
   
        imageMatting.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        imageMatting.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        imageMatting.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        imageMatting.widthAnchor.constraint(equalToConstant: 300),
        imageMatting.heightAnchor.constraint(equalToConstant: 300),
    
        //Product Image
        productImage.centerXAnchor.constraint(equalTo: imageMatting.centerXAnchor),
        productImage.centerYAnchor.constraint(equalTo: imageMatting.centerYAnchor),
        productImage.widthAnchor.constraint(equalToConstant: 200),
        productImage.heightAnchor.constraint(equalToConstant: 200),
        
        listButtonBacking.centerXAnchor.constraint(equalTo: imageMatting.centerXAnchor),
        listButtonBacking.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 5),
        listButtonBacking.widthAnchor.constraint(equalToConstant: 40),
        listButtonBacking.heightAnchor.constraint(equalToConstant: 40),
        
        listButton.centerYAnchor.constraint(equalTo: listButtonBacking.centerYAnchor),
        listButton.centerXAnchor.constraint(equalTo: listButtonBacking.centerXAnchor),
        listButton.widthAnchor.constraint(equalTo: listButtonBacking.widthAnchor, constant: -10),
        listButton.heightAnchor.constraint(equalTo: listButtonBacking.heightAnchor,constant: -10),
        

        
    ])
  }
}


protocol passProduct {
    func relatedProductCollectionView(collectioncell: UICollectionViewCell?, IndexPath: IndexPath)
}

//MARK: Product info view
class productInfoViews: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    let cellID = "cell"
    var listProductCollectionView: UICollectionView!
    var relatedProducts: fireStoreDataClass!
    var productDelegate: passProduct?

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
    
    //MARK: - This needs to be be produst not meals
    //MARK: - Move this the the meals page since it's partially working
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //needs to be a group of 3
        return arrayofProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productIndex = arrayofProducts[indexPath.item]
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! recommendedProductCells
        productCell.productImageView.image = UIImage(named: "\(productIndex.productImage)")
        productCell.backgroundColor = UIColor.white
        
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productCellTap = collectionView.cellForItem(at: indexPath) as? recommendedProductCells
        relatedProducts = relatedProduct(forIndexPath: indexPath)
        productDelegate?.relatedProductCollectionView(collectioncell: productCellTap, IndexPath: indexPath)
        //MARK: for meals
        print("\(relatedProducts.productName.capitalized)")
    }
    
    

    let productDescription: UITextView = {
        let desc = "This goes great at breakfast. I usually don't have time for it but I've only heard good things."
        let description = UITextView()
        description.layer.masksToBounds = true
        description.text = "\(desc)"
        description.isEditable = false
        description.textColor = UIColor.ademBlue
        description.font = UIFont.boldSystemFont(ofSize: 16)
        return description
    }()
    
    //Might want pop up so they know it moves? or move to the image
    var addToPantry: UIButton = {
        let addToPantry = UIButton(type: .system)
        addToPantry.setBackgroundImage(UIImage(named: "greenAddButton"), for: .normal)
        return addToPantry
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
        lQuant.textColor = UIColor.white
        lQuant.font = UIFont(name: hNBold, size: 17)
        lQuant.text = "Qty:"
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
        
        self.addSubview(addToPantry)
        self.addSubview(productDescription)
        self.addSubview(listProductCollectionView)
        self.addSubview(segmentLabel)
        self.addSubview(textFieldSeparator)
        
        addToPantry.translatesAutoresizingMaskIntoConstraints = false
        textFieldSeparator.translatesAutoresizingMaskIntoConstraints = false
        segmentLabel.translatesAutoresizingMaskIntoConstraints = false
        listProductCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productDescription.translatesAutoresizingMaskIntoConstraints = false
    
        

        
    
        self.addSubview(itemQuant)
        itemQuant.addSubview(listQuantity)
        itemQuant.addSubview(listQuantityButon)
        itemQuant.addSubview(qImage)

        listQuantityButon.translatesAutoresizingMaskIntoConstraints = false
        qImage.translatesAutoresizingMaskIntoConstraints = false
        listQuantity.translatesAutoresizingMaskIntoConstraints = false
        itemQuant.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
        
            itemQuant.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            itemQuant.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            itemQuant.widthAnchor.constraint(equalToConstant: 90),//might not want const
            itemQuant.heightAnchor.constraint(equalToConstant: 30),
            
            addToPantry.centerYAnchor.constraint(equalTo: itemQuant.centerYAnchor),
            addToPantry.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            //addToPantry.rightAnchor.constraint(equalTo: itemQuant.leftAnchor, constant: -10),
            addToPantry.heightAnchor.constraint(equalToConstant: 25),
            addToPantry.widthAnchor.constraint(equalToConstant: 25),
            
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
            
            productDescription.topAnchor.constraint(equalTo: itemQuant.bottomAnchor, constant: 5),
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

extension productInfoViews {
    
    func relatedProduct(forIndexPath: IndexPath) -> fireStoreDataClass {
        var product: fireStoreDataClass!
        product = arrayofProducts[forIndexPath.item]
        return product
    }
}
