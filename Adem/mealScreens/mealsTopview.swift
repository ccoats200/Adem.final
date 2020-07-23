//
//  mealsTopview.swift
//  Adem
//
//  Created by Coleman Coats on 2/26/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Product name view
class mealsViews: UIView {
    

  
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
    
     var productNameAndBackButton: UIButton = {
        let back = UIButton(type: .system)
        back.setTitle("Pancakes", for: .normal)
        
        back.setTitleColor(UIColor.white, for: .normal)
        back.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        back.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        return back
        
    }()
    
    //Delete now editing button
    let faveButton: UIButton = {
        let fave = UIButton()
        fave.setBackgroundImage(UIImage(named: "fave-1"), for: .normal)
        fave.setBackgroundImage(UIImage(named: "heart"), for: .highlighted)
        fave.setBackgroundImage(UIImage(named: "heart"), for: .selected)
        fave.clipsToBounds = true
        fave.layer.masksToBounds = true
        fave.translatesAutoresizingMaskIntoConstraints = false
        return fave
    }()

       
  //common func to init our view
  private func setupView() {

    self.addSubview(faveButton)
    self.addSubview(productNameAndBackButton)
    faveButton.translatesAutoresizingMaskIntoConstraints = false
    productNameAndBackButton.translatesAutoresizingMaskIntoConstraints = false
    productNameAndBackButton.clipsToBounds = true
    productNameAndBackButton.layer.cornerRadius = 20
    
    
    NSLayoutConstraint.activate([
        productNameAndBackButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        productNameAndBackButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        productNameAndBackButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -150),
        productNameAndBackButton.heightAnchor.constraint(equalToConstant: 50),
        
        faveButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        faveButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        faveButton.widthAnchor.constraint(equalToConstant: 30),
        faveButton.heightAnchor.constraint(equalToConstant: 30),
    ])
  }
}


//MARK: Product info view
class mealsBottomViews: UIView {
  
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
        let desc = "Add 1 cup of flour"
        let lineBreak = "\n"
        let desc2 = "Add 2 eggs"
        let desc3 = "Add 2 tbsp of almond extract"
        let desc4 = "add 1/2 cup of milk"
        let desc5 = "Mix"
        let paragraph = desc + lineBreak + desc2 + lineBreak + desc3 + lineBreak + desc4 + lineBreak + desc5
        let description = UITextView()
        description.layer.masksToBounds = true
        description.text = "\(paragraph)"
        description.isEditable = false
        description.textColor = UIColor.ademBlue
        description.font = UIFont.boldSystemFont(ofSize: 16)
        return description
    }()


    //common func to init our view
    private func setupView() {
    
        self.backgroundColor = UIColor.white
       
    
       
        self.addSubview(productDescription)
        productDescription.translatesAutoresizingMaskIntoConstraints = false
    
        

        
    
        NSLayoutConstraint.activate([

            productDescription.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            productDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            productDescription.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -12),
    ])
  }
}


//MARK: Product image view
class mealImageViews: UIView {
  
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
        productImageDesign.image = UIImage(named: "pancake")
        productImageDesign.contentMode = .center
        productImageDesign.contentMode = .scaleAspectFill
        productImageDesign.clipsToBounds = true
        productImageDesign.layer.masksToBounds = true
        productImageDesign.layer.cornerRadius = 25
        productImageDesign.layer.borderWidth = 1
        productImageDesign.layer.borderColor = UIColor.white.cgColor
        
        productImageDesign.widthAnchor.constraint(equalToConstant: 200).isActive = true
        productImageDesign.heightAnchor.constraint(equalToConstant: 200).isActive = true //125 also looks good
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
