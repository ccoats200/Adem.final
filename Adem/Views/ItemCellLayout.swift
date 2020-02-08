//
//  ItemCellLayout.swift
//  Adem
//
//  Created by Coleman Coats on 8/15/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseFirestore


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
            selectedButton.isHidden = !isEditing
        }
    }
    
    
    
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
        return image
    }()
    
    let productName: UILabel = {
        let name = UILabel()
        name.textAlignment = .left
        name.textColor = UIColor.white
        name.font = UIFont(name:"HelveticaNeue", size: 15.0)
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    //Delete now editing button
    let selectedButton: UIButton = {
        let delete = UIButton()
        delete.backgroundColor = UIColor.blue
        delete.clipsToBounds = true
        delete.layer.masksToBounds = true
        delete.translatesAutoresizingMaskIntoConstraints = false
        return delete
    }()
    
    func setupViews() {
        
        addSubview(productImageView)
        addSubview(productName)
        addSubview(selectedButton)
        selectedButton.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            
            //Product Image
            productImageView.topAnchor.constraint(equalTo: self.topAnchor),
            productImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 7/10),//(equalToConstant: 100),
            
            //Product Name
            productName.topAnchor.constraint(equalTo: productImageView.bottomAnchor),
            productName.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor),
            productName.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: 5),
            productName.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor,constant: -5),
            productName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 3/10),
            
            //Selected Button
            selectedButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 5),
            selectedButton.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: 5),
            selectedButton.widthAnchor.constraint(equalToConstant: 20),
            selectedButton.heightAnchor.constraint(equalToConstant: 20),
            
            
            ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Pantry Product Cell layout
class filterCellLayout: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupViews()
    }

    
    let productName: UILabel = {
        let name = UILabel()
        name.textAlignment = .left
        name.textColor = UIColor.white
        name.font = UIFont(name:"HelveticaNeue", size: 15.0)
        name.numberOfLines = 1
        name.text = "test scroll"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    func setupViews() {
        
        
        addSubview(productName)
        self.layer.cornerRadius = 5
        
        NSLayoutConstraint.activate([
            
            //Product Name
            productName.topAnchor.constraint(equalTo: self.bottomAnchor),
            productName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productName.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5),
            productName.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
