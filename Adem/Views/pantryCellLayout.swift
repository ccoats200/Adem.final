//
//  pantryCellLayout.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


//List Delete protocol
protocol pantryItemDelegate: class {
    func delete(cell: pantryCellLayout)
}

//Pantry Product Cell layout
class pantryCellLayout: CellBasics {
    
    
    weak var delegate: pantryItemDelegate?
    
    
    var gItem: groceryItemCellContent? {
        didSet {
            productImageView.image = UIImage(named: (gItem?.itemImageName)!)
            productName.text = gItem?.itemName
            quantity.text = gItem?.Quantity
            selectedButton.isHidden = !isEditing
            deleteButton.isHidden = !isEditing
            
            print("set")
        }
    }
    
    //Allowing editing button
    let selectedButton: UIButton = {
        let selected = UIButton()
        selected.backgroundColor = UIColor.white
        //selected.alpha = 0.50
        selected.layer.cornerRadius = 15
        selected.translatesAutoresizingMaskIntoConstraints = false
        return selected
    }()
    
    //Delet now editing button
    let deleteButton: UIButton = {
        let delete = UIButton()
        delete.backgroundColor = UIColor.ademBlue
        delete.layer.cornerRadius = (15/2)
        delete.clipsToBounds = true
        delete.layer.masksToBounds = true
        delete.translatesAutoresizingMaskIntoConstraints = false
        return delete
    }()
    
    var isEditing: Bool = false {
        
        didSet {
            if isEditing
            {
                //self.selectedButton.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 255)
                self.layer.cornerRadius = 10
                selectedButton.isHidden = isEditing
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.deleteButton.isHidden = !isEditing
                self.deleteButton.backgroundColor = UIColor.ademBlue
            } else {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                selectedButton.isHidden = !isEditing
                deleteButton.isHidden = !isEditing
                
            }
            
        }
    }
    
    override var isSelected: Bool {
        
        didSet {
            /*
             if isEditing && isSelected {
             selectedButton.isHidden = !isEditing
             self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
             self.selectedButton.backgroundColor = UIColor.red
             //print(selectedButton.backgroundColor)
             }*/
            
            if isSelected {
                selectedButton.isHidden = !isEditing
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.selectedButton.backgroundColor = UIColor.ademGreen
                
                //self.tickImageView.isHidden = false
            }
                
            else {
                //self.transform = CGAffineTransform.identity
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.selectedButton.backgroundColor = nil
                
                //print(selectedButton.backgroundColor)
                //self.contentView.backgroundColor = UIColor.blue
                //self.tickImageView.isHidden = true
            }
            
        }
    }
    
    
    
    @objc func selectedButtonDidTap(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
    let productImageView: UIImageView = {
        let image = UIImageView()
        //image.image = UIImage(named: itemImageName)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        print("rounds the corners of the image view")
        return image
    }()
    
    let productName: UILabel = {
        let name = UILabel()
        //name.text = "\(itemName)"
        name.textAlignment = .center
        name.numberOfLines = 1
        name.adjustsFontSizeToFitWidth = true
        print("sets the item name")
        return name
    }()
    
    let quantity: UILabel = {
        let Quant = UILabel()
        //Quant.text = "\(Quantity)"
        print("sets the quantity of the items in the cart")
        Quant.font = UIFont(name: "Helvetica", size: 12)
        Quant.textColor = UIColor.rgb(red: 57, green: 94, blue: 102)
        Quant.translatesAutoresizingMaskIntoConstraints = false
        return Quant
    }()
    
    override func setupViews() {
        addSubview(productImageView)
        print("adds the product image subview")
        addSubview(productName)
        print("adds the product name subview")
        addSubview(quantity)
        print("adds the calorie count subview")
        addSubview(selectedButton)
        addSubview(deleteButton)
        
        
        
        //Horizontral Constaints
        addConstraintsWithFormats(format: "H:|[v0]|", views: productImageView)
        addConstraintsWithFormats(format: "H:|-8-[v0]-8-|", views: productName)
        //addConstraintsWithFormats(format: "H:|-3-[v0]-3-[v1(50)]-8-[v2(40)]", views: productName, price, Quantity)
        
        //Vertical Constraints (productImageView = 105)
        addConstraintsWithFormats(format: "V:|[v0(100)]-1-[v1(20)]-3-|", views: productImageView, productName)
        //addConstraintsWithFormats(format: "V:|-3-[v0(105)]-4-[v1(20)]-8-[v2(1)]|", views: productImageView, productName, seperatorView)
        
        
        //Constraints: Only use if multiple constraints needed on same view
        
        //Top Constraints Quantity
        addConstraint(NSLayoutConstraint(item: quantity, attribute: .top, relatedBy: .equal, toItem: productImageView, attribute: .top, multiplier: 1, constant: 5))
        //Right Constraints Quantity
        addConstraint(NSLayoutConstraint(item: quantity, attribute: .right, relatedBy: .equal, toItem: productImageView, attribute: .right, multiplier: 1, constant: -5))
        //Height Constraint Quantity
        addConstraint(NSLayoutConstraint(item: quantity, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 15))
        //Width Constraint
        addConstraint(NSLayoutConstraint(item: quantity, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 15))
        
        
        //Top Constraints Quantity
        //addConstraint(NSLayoutConstraint(item: selectedButton, attribute: .top, relatedBy: .equal, toItem: productImageView, attribute: .top, multiplier: 1, constant: 0))
        //Bottom Constraints Quantity
        addConstraint(NSLayoutConstraint(item: selectedButton, attribute: .bottom, relatedBy: .equal, toItem: productImageView, attribute: .bottom, multiplier: 1, constant: -5))
        //Left Constraints Quantity
        //addConstraint(NSLayoutConstraint(item: selectedButton, attribute: .left, relatedBy: .equal, toItem: productImageView, attribute: .left, multiplier: 1, constant: 0))
        //RightConstraints Quantity
        addConstraint(NSLayoutConstraint(item: selectedButton, attribute: .right, relatedBy: .equal, toItem: productImageView, attribute: .right, multiplier: 1, constant: -5))
        //Height Constraint Quantity
        addConstraint(NSLayoutConstraint(item: selectedButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        //Width Constraint
        addConstraint(NSLayoutConstraint(item: selectedButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 30))
        
        
        
        
        //Delete button
        //top
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .top, relatedBy: .equal, toItem: productImageView, attribute: .top, multiplier: 1, constant: 5))
        //left
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .left, relatedBy: .equal, toItem: productImageView, attribute: .left, multiplier: 1, constant: 5))
        //Height Constraint Quantity
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 15))
        //Width Constraint
        addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 15))
        
        
    }
}

