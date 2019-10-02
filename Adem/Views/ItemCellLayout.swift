//
//  ItemCellLayout.swift
//  Adem
//
//  Created by Coleman Coats on 8/15/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


//List Delete protocol
protocol ItemDelegate: class {
    func delete(cell: itemCellLayout)
    func addToList(cell: itemCellLayout)
}

//Pantry Product Cell layout
class itemCellLayout: UICollectionViewCell {
    weak var delegate: ItemDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
   
    
    var gItem: groceryItemCellContent? {
        didSet {
            productImageView.image = UIImage(named: (gItem?.itemImageName)!)
            productName.text = gItem?.itemName
            quantity.text = gItem?.Quantity
            selectedButton.isHidden = !isEditing
            
            print("set")
        }
    }
    
    //Delete now editing button
    let selectedButton: UIButton = {
        let delete = UIButton()
        delete.backgroundColor = UIColor.ademBlue
        delete.layer.cornerRadius = 15
        delete.clipsToBounds = true
        delete.layer.masksToBounds = true
        delete.translatesAutoresizingMaskIntoConstraints = false
        return delete
    }()
    
    var isEditing: Bool = false {
        didSet {
            if isEditing
            {
                //selectedButton.isHidden = !isEditing
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.selectedButton.isHidden = isEditing
                self.selectedButton.backgroundColor = UIColor.ademBlue
            } else {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                selectedButton.isHidden = !isEditing
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
                self.selectedButton.backgroundColor = UIColor.ademBlue
            } else {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.selectedButton.backgroundColor = nil
            }
        }
    }
    
    @objc func selectedButtonDidTap(_ sender: Any) {
        var userChangingLocationForProducts: [IndexPath] = []
        //for (key, value) in
        delegate?.delete(cell: self)
    }
    
    let productImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        print("rounds the corners of the image view")
        return image
    }()
    
    let productName: UILabel = {
        let name = UILabel()
        name.textAlignment = .left
        //name.backgroundColor = UIColor.red
        name.numberOfLines = 1
        //name.adjustsFontSizeToFitWidth = true
        name.translatesAutoresizingMaskIntoConstraints = false
        print("sets the item name")
        return name
    }()
    
    let quantity: UILabel = {
        let Quant = UILabel()
        print("sets the quantity of the items in the cart")
        Quant.font = UIFont(name: "Helvetica", size: 15)
        Quant.textColor = UIColor.black
        Quant.translatesAutoresizingMaskIntoConstraints = false
        return Quant
    }()
    
    func setupViews() {
        
        addSubview(productImageView)
        addSubview(productName)
        addSubview(quantity)
        addSubview(selectedButton)
        
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: self.topAnchor),
            productImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            productImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            productImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2/3),//(equalToConstant: 100),
            productName.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 1),
            productName.trailingAnchor.constraint(equalTo: quantity.leadingAnchor,constant: -5),
            productName.leftAnchor.constraint(equalTo: productImageView.leftAnchor, constant: 5),
            productName.heightAnchor.constraint(equalToConstant: 20),
            quantity.topAnchor.constraint(equalTo: productName.topAnchor),
            quantity.rightAnchor.constraint(equalTo: productImageView.rightAnchor, constant: -5),
            quantity.widthAnchor.constraint(equalToConstant: 10),
            quantity.heightAnchor.constraint(equalTo: productName.heightAnchor),
            selectedButton.topAnchor.constraint(equalTo: productImageView.topAnchor),
            selectedButton.leftAnchor.constraint(equalTo: productImageView.leftAnchor),
            selectedButton.widthAnchor.constraint(equalToConstant: 30),
            selectedButton.heightAnchor.constraint(equalToConstant: 30),
            ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
