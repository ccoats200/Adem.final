//
//  ItemLayout.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//


import UIKit
import Firebase

//Item Cell layout
class ItemLayout: CellBasics {
    
    
    let Item: UIImageView = {
        let ItemVCLayout = UIImageView()
        ItemVCLayout.image = UIImage(named: "bread")
        ItemVCLayout.contentMode = .center
        ItemVCLayout.contentMode = .scaleAspectFit
        ItemVCLayout.clipsToBounds = true
        ItemVCLayout.layer.masksToBounds = true
        ItemVCLayout.layer.cornerRadius = 5
        ItemVCLayout.layer.borderWidth = 1
        ItemVCLayout.layer.borderColor = UIColor.white.cgColor
        print("Created Image for the product image in the details VC")
        
        return ItemVCLayout
    }()
    
    let tableView: UITableView = {
        let tView = UITableView()
        //name.text = "\(itemName)"
        print("sets the item name")
        return tView
    }()
    
    
    let ItemName: UILabel = {
        let iname = UILabel()
        //name.text = "\(itemName)"
        iname.textAlignment = .center
        iname.numberOfLines = 1
        iname.adjustsFontSizeToFitWidth = true
        print("sets the item name")
        return iname
    }()
    
    let quantityTicker: UILabel = {
        let QuantTicker = UILabel()
        //Quant.text = "\(Quantity)"
        print("sets the quantity of the items in the cart")
        QuantTicker.font = UIFont(name: "Helvetica", size: 12)
        QuantTicker.textColor = UIColor.rgb(red: 57, green: 94, blue: 102)
        QuantTicker.translatesAutoresizingMaskIntoConstraints = false
        QuantTicker.backgroundColor = UIColor.green
        return QuantTicker
    }()
    
    let sView: UIView = {
        let seperate = UIView()
        seperate.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        print("sets the seperator color")
        return seperate
    }()
    
    let infoView: UIView = {
        let ingredientsLBL = UITextView()
        ingredientsLBL.font = UIFont(name: "Helvetica", size: 15)
        ingredientsLBL.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 253)
        ingredientsLBL.isEditable = false
        ingredientsLBL.text = "This is a test to see if I can pre populate the text with the ingrediants"
        ingredientsLBL.textAlignment = .left
        ingredientsLBL.layer.cornerRadius = 2
        ingredientsLBL.layer.borderWidth = 0.1
        
        return ingredientsLBL
    }()
    
    
    
    
    override func setupViews() {
        addSubview(Item)
        addSubview(sView)
        //addSubview(quantityTicker)
        addSubview(ItemName)
        addSubview(infoView)
        
        
        setUpAddButton()
        
        //Horizontral Constaints
        addConstraintsWithFormats(format: "H:|-25-[v0]-25-|", views: Item)
        addConstraintsWithFormats(format: "H:|-25-[v0]-25-|", views: ItemName)
        addConstraintsWithFormats(format: "H:|-15-[v0]-15-|", views: infoView)
        
        //addConstraintsWithFormats(format: "H:|-3-[v0]-3-[v1(50)]-8-[v2(40)]", views: productName, price, quantityTicker)
        
        //Vertical Constraints (productImageView = 105)
        addConstraintsWithFormats(format: "V:|-2-[v0(150)]-1-[v1(20)]-3-|", views: Item, ItemName)
        
        //addConstraintsWithFormats(format: "V:|-2-[v0(100)]-1-[v1(20)]-3-[v2(1)]-2-[v3(200)]-|", views: Item, ItemName, sView, infoView)
        //addConstraintsWithFormats(format: "V:|-3-[v0(105)]-4-[v1(20)]-8-[v2(1)]|", views: productImageView, productName, seperatorView)
        
        //Seperator Constraint
        addConstraintsWithFormats(format: "H:|-15-[v0]-15-|", views: sView)
        
        //Constraints: Only use if multiple constraints needed on same view
        
        //Top Constraints Quantity
        addConstraint(NSLayoutConstraint(item: sView, attribute: .top, relatedBy: .equal, toItem: ItemName, attribute: .top, multiplier: 1, constant: 5))
        
        //Right Constraints Quantity
        addConstraint(NSLayoutConstraint(item: sView, attribute: .right, relatedBy: .equal, toItem: ItemName, attribute: .right, multiplier: 1, constant: -5))
        
        //Height Constraint Quantity
        addConstraint(NSLayoutConstraint(item: sView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 1))
        
        //Width Constraint
        addConstraint(NSLayoutConstraint(item: sView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 1))
        
        //Top Constraints Quantity
        addConstraint(NSLayoutConstraint(item: infoView, attribute: .top, relatedBy: .equal, toItem: sView, attribute: .top, multiplier: 1, constant: 15))
        
        //Right Constraints Quantity
        addConstraint(NSLayoutConstraint(item: infoView, attribute: .right, relatedBy: .equal, toItem: sView, attribute: .right, multiplier: 1, constant: -5))
        
        //Height Constraint Quantity
        addConstraint(NSLayoutConstraint(item: infoView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 100))
        
        //Width Constraint
        addConstraint(NSLayoutConstraint(item: infoView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 100))
    }
    
    func setUpAddButton(){
        print(123)
    }
    
    @objc func handleAdd() {
        print(123)
    }
}

class listProductImageLayout: UIView {
    
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
        productImageDesign.image = UIImage(named: "blueBerry")
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.addSubview(productImage)
        self.addSubview(imageMatting)
        
        imageMatting.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageMatting.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        //login Fields
        //productImage.topAnchor.constraint(equalTo: backgrounLightColor.topAnchor, constant: 5).isActive = true
        productImage.centerXAnchor.constraint(equalTo: imageMatting.centerXAnchor).isActive = true
        productImage.centerYAnchor.constraint(equalTo: imageMatting.centerYAnchor).isActive = true
    }
    
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
}

/*
class listProductInfoLayout: UIView {
    
    let calorieLabel: UILabel = {
        let calories = UILabel()
        //calories.backgroundColor = UIColor.blue
        calories.translatesAutoresizingMaskIntoConstraints = false
        calories.layer.cornerRadius = 5
        calories.layer.masksToBounds = true
        calories.text = "Calories: "
        return calories
    }()
    
    let productCostLabel: UILabel = {
        let cost = 2.99
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.layer.cornerRadius = 5
        price.layer.masksToBounds = true
        price.text = "$\(cost)"
        price.font = UIFont.boldSystemFont(ofSize: 16)
        return price
    }()
    
    let NurtritionLabel: UIView = {
        let NutLbl = UITextView()
        NutLbl.font = UIFont(name: "Helvetica", size: 15)
        NutLbl.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 253)
        NutLbl.isEditable = false
        NutLbl.text = "This is a test to see if I can pre populate the text with the ingrediants"
        NutLbl.textAlignment = .left
        NutLbl.layer.cornerRadius = 2
        NutLbl.layer.borderWidth = 0.1
        NutLbl.translatesAutoresizingMaskIntoConstraints = false
        
        return NutLbl
    }()
    
    let alwaysNotify: UIButton = {
        let notify = UIButton()
        let notifyImage = UIImage(named: "fave")
        notify.setImage(notifyImage, for: .normal)
        notify.translatesAutoresizingMaskIntoConstraints = false
        notify.contentMode = .scaleAspectFit
        //notify.backgroundColor = UIColor.blue
        return notify
    }()
    
    
    lazy var healthfFacts: UIButton = {
        let facts = UIButton()
        let image = UIImage(named: "Vegan")
        //facts.backgroundImage(for: .normal)
        facts.setImage(image, for: .normal)
        facts.translatesAutoresizingMaskIntoConstraints = false
        facts.contentMode = .scaleAspectFit
        facts.addTarget(self, action: #selector(handleFacts), for: .touchUpInside)
        return facts
    }()
    
    //product Button
    @objc func handleFacts() {
        let signUpInfo = login()
        //self.present(signUpInfo, animated: true)
        print("went to new page")
    }
    
    
    
    func productInfoViewSetUp() {
        
        self.addSubview(NurtritionLabel)
        self.addSubview(calorieLabel)
        self.addSubview(productCostLabel)
        
        let healthInfoStackView = UIStackView(arrangedSubviews: [healthfFacts, alwaysNotify])
        healthInfoStackView.contentMode = .scaleAspectFit
        healthInfoStackView.spacing = 5
        healthInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        healthInfoStackView.distribution = .fillEqually
        
        
        scrolling.addSubview(healthInfoStackView)
        
        
        productInfoHolder.topAnchor.constraint(equalTo: imageMatting.bottomAnchor, constant: 15).isActive = true
        productInfoHolder.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        productInfoHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25).isActive = true
        productInfoHolder.heightAnchor.constraint(equalToConstant: 350).isActive = true
        productInfoHolder.layer.cornerRadius = 10
        
        healthInfoStackView.topAnchor.constraint(equalTo: productInfoHolder.topAnchor, constant: 5).isActive = true
        healthInfoStackView.leadingAnchor.constraint(equalTo: productInfoHolder.leadingAnchor, constant: 5).isActive = true
        //healthInfoStackView.trailingAnchor.constraint(equalTo: productInfoHolder.trailingAnchor, constant: -5).isActive = true
        healthInfoStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        healthInfoStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        //calories
        calLabel.topAnchor.constraint(equalTo: alwaysNotify.bottomAnchor, constant: 5).isActive = true
        calLabel.leftAnchor.constraint(equalTo: productInfoHolder.leftAnchor, constant: 12).isActive = true
        calLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        calLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        //calories
        priceLabel.topAnchor.constraint(equalTo: productInfoHolder.topAnchor, constant: 5).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: productInfoHolder.rightAnchor, constant: 10).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    func setupproductNutritionLabel() {
        
        NurtritionLabel.topAnchor.constraint(equalTo: productInfoHolder.bottomAnchor, constant: 5).isActive = true
        NurtritionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        NurtritionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25).isActive = true
        NurtritionLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        NurtritionLabel.layer.cornerRadius = 10
        
    }
    
    
    
    
}
*/
