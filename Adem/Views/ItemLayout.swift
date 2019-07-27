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
        ItemVCLayout.image = UIImage(named: "blueBerry")
        ItemVCLayout.contentMode = .center
        ItemVCLayout.contentMode = .scaleAspectFit
        ItemVCLayout.clipsToBounds = true
        ItemVCLayout.layer.masksToBounds = true
        ItemVCLayout.layer.cornerRadius = 5
        ItemVCLayout.layer.borderWidth = 2
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
        //Quant.backgroundColor = UIColor.green
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

