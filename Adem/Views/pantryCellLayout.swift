//
//  pantryCellLayout.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseFirestore


//List Delete protocol
protocol pantryItemDelegate: class {
    func delete(cell: pantryCellLayout)
    func addToList(cell: pantryCellLayout)
}

//Pantry Product Cell layout
class pantryCellLayout: UICollectionViewCell {
    weak var delegate: pantryItemDelegate?
    
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
                //selectedButton.isHidden = !isEditing
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
                //selectedButton.isHidden = !isEditing
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.selectedButton.backgroundColor = UIColor.ademBlue
                //self.tickImageView.isHidden = false
            } else {
                //self.transform = CGAffineTransform.identity
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.selectedButton.backgroundColor = nil
                //print(selectedButton.backgroundColor)
                //self.contentView.backgroundColor = UIColor.blue
                //self.tickImageView.isHidden = true
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
        //image.image = UIImage(named: itemImageName)
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
        //name.text = "\(itemName)"
        name.textAlignment = .left
        name.numberOfLines = 1
        name.adjustsFontSizeToFitWidth = true
        name.translatesAutoresizingMaskIntoConstraints = false
        print("sets the item name")
        return name
    }()
    
    let quantity: UILabel = {
        let Quant = UILabel()
        //Quant.text = "\(Quantity)"
        print("sets the quantity of the items in the cart")
        Quant.font = UIFont(name: "Helvetica", size: 15)
        Quant.textColor = UIColor.black
        Quant.translatesAutoresizingMaskIntoConstraints = false
        return Quant
    }()
    
    func setupViews() {
        
        addSubview(productImageView)
        print("adds the product image subview")
        addSubview(productName)
        print("adds the product name subview")
        addSubview(quantity)
        print("adds the calorie count subview")
        addSubview(selectedButton)
      
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: self.topAnchor),
            productImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            productImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productName.topAnchor.constraint(equalTo: productImageView.bottomAnchor),
            productName.rightAnchor.constraint(equalTo: quantity.leftAnchor),
            productName.leftAnchor.constraint(equalTo: productImageView.leftAnchor),
            productName.heightAnchor.constraint(equalToConstant: 20),
            quantity.topAnchor.constraint(equalTo: productImageView.bottomAnchor),
            quantity.rightAnchor.constraint(equalTo: productImageView.rightAnchor),
            quantity.widthAnchor.constraint(equalToConstant: 20),
            quantity.heightAnchor.constraint(equalToConstant: 20),
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

class addOrDeleteProduct: UIView {

    weak var delegate: pantryItemDelegate?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpAddDismiss()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setUpAddDismiss()
    }
    
    lazy var deleteItemFromPantryButton: UIButton = {
        let login = UIButton(type: .system)
        login.backgroundColor = UIColor.ademBlue
        login.setTitle("Delete", for: .normal)
        login.translatesAutoresizingMaskIntoConstraints = false
        login.layer.masksToBounds = true
        login.clipsToBounds = true
        login.setTitleColor(UIColor.black, for: .normal)
        login.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        login.addTarget(self, action: #selector(deleteProductFromPantry), for: .touchUpInside)
        return login
        
    }()
    
    
    @objc func deleteProductFromPantry() {

        print("User clicked delete button")
    }

    lazy var addProductToListButton: UIButton = {
        let add = UIButton(type: .system)
        add.backgroundColor = UIColor.ademBlue
        add.setTitle("Add", for: .normal)
        add.translatesAutoresizingMaskIntoConstraints = false
        add.layer.masksToBounds = true
        add.clipsToBounds = true
        add.setTitleColor(UIColor.black, for: .normal)
        add.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        add.addTarget(self, action: #selector(addProductToListFromPantry), for: .touchUpInside)
        
        return add
        
    }()
    
    @objc func addProductToListFromPantry() {
        
        print("User clicked add items button. User moved products from their pantry to their list.")
    }
    
    func setUpAddDismiss() {
        
        let alertStackView = UIStackView(arrangedSubviews: [addProductToListButton, deleteItemFromPantryButton])
        alertStackView.contentMode = .scaleAspectFit
        alertStackView.translatesAutoresizingMaskIntoConstraints = false
        alertStackView.distribution = .fillEqually
        alertStackView.layer.masksToBounds = true
        alertStackView.clipsToBounds = true
        
        self.addSubview(alertStackView)
        
        alertStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        alertStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        alertStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        alertStackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
}
