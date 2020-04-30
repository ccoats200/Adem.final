//
//  signUpCell.swift
//  Adem
//
//  Created by Coleman Coats on 1/29/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//Profile attributes
struct preferenceContent {

    var preferenceImage: String?
    var preferenceImageSelected: String?
    var preferencesLabelText: String?
}

var preferencesAttributes = [
    preferenceContent(preferenceImage: "fish", preferenceImageSelected: "fish_selected", preferencesLabelText: "Pescaterian"),
    preferenceContent(preferenceImage: "veg", preferenceImageSelected: "veg_selected", preferencesLabelText: "Vegetarian"),
    preferenceContent(preferenceImage: "veganIcon", preferenceImageSelected: "vegan_selected", preferencesLabelText: "Vegan"),
    preferenceContent(preferenceImage: "nut", preferenceImageSelected: "nut_selected", preferencesLabelText: "Nuts"),
    preferenceContent(preferenceImage: "dairy", preferenceImageSelected: "dairy_selected", preferencesLabelText: "Lactose"),
    preferenceContent(preferenceImage: "other", preferenceImageSelected: "other", preferencesLabelText: "Other"),
    preferenceContent(preferenceImage: "none", preferenceImageSelected: "none_selected", preferencesLabelText: "None")
]

//Profile attributes
struct flavorsContent {

    var flavorImage: String?
    var flavorImageSelected: String?
    var flavorLabelText: String?
}

var flavorsAttributes = [
    flavorsContent(flavorImage: "salt_unselected", flavorImageSelected: "salt", flavorLabelText: "Salty"),
    flavorsContent(flavorImage: "sweet", flavorImageSelected: "sweet_selected", flavorLabelText: "Sweet"),
    flavorsContent(flavorImage: "spicy", flavorImageSelected: "spicy_selected", flavorLabelText: "Spicy"),
    flavorsContent(flavorImage: "bitter", flavorImageSelected: "bitter_selected", flavorLabelText: "Biter"),
    flavorsContent(flavorImage: "fruity", flavorImageSelected: "fruity_selected", flavorLabelText: "Fruity")
]

class signUpCellDesign: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var preferencesElements = preferenceContent() {
        didSet {
            if isSelected {
            preferencesIcon.image = UIImage(named: (preferencesElements.preferenceImageSelected)!)
            } else {
            preferencesIcon.image = UIImage(named: (preferencesElements.preferenceImage)!)
            preferencesLabel.text = preferencesElements.preferencesLabelText
        }
        }
    }
    
    var flavorsElements = flavorsContent() {
        didSet {
            if isSelected {
                preferencesIcon.image = UIImage(named: (flavorsElements.flavorImageSelected)!)
            } else {
                preferencesIcon.image = UIImage(named: (flavorsElements.flavorImage)!)
                preferencesLabel.text = flavorsElements.flavorLabelText
        }
        }
    }
    
    let preferencesIcon: UIImageView = {
        let prefIcon = UIImageView()
        prefIcon.contentMode = .scaleAspectFit
        prefIcon.clipsToBounds = true
        prefIcon.layer.masksToBounds = true
        prefIcon.translatesAutoresizingMaskIntoConstraints = false
        
        return prefIcon
    }()
    
    let preferencesLabel: UILabel = {
        let prefLabel = UILabel()
        prefLabel.textAlignment = .center
        prefLabel.text = "Opps"
        prefLabel.textColor = UIColor.ademBlue
        //prefLabel.backgroundColor = UIColor.red
        prefLabel.font = UIFont(name: productFont, size: 20)
        prefLabel.clipsToBounds = true
        prefLabel.layer.masksToBounds = true
        prefLabel.translatesAutoresizingMaskIntoConstraints = false
        return prefLabel
    }()
    

    func setupViews() {
        
        addSubview(preferencesIcon)
        addSubview(preferencesLabel)
        //preferencesIcon.layer.cornerRadius = 25
        
        
        NSLayoutConstraint.activate([
            preferencesIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            preferencesIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        preferencesIcon.widthAnchor.constraint(equalToConstant: 50),
        preferencesIcon.heightAnchor.constraint(equalToConstant: 50),
        
        preferencesLabel.topAnchor.constraint(equalTo: preferencesIcon.bottomAnchor, constant: 5),
        preferencesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        preferencesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        preferencesLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
        
        ])
    }
}


//Profile attributes
struct storeContent {

    var storeIcon: String?
    var storeIconSelected: String?
    var storeName: String?
}
var stores = [
    //MARK: Arrays
    storeContent(storeIcon: "store_unselected", storeIconSelected: "store", storeName: "Walmart"),
storeContent(storeIcon: "store_unselected", storeIconSelected: "store", storeName: "Wegmans"),
storeContent(storeIcon: "store_unselected", storeIconSelected: "store", storeName: "Vons"),
storeContent(storeIcon: "store_unselected", storeIconSelected: "store", storeName: "Stater Bros"),
storeContent(storeIcon: "store_unselected", storeIconSelected: "store", storeName: "Other"),
storeContent(storeIcon: "store_unselected", storeIconSelected: "store", storeName: "None")

]



class storeCellDesign: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var accountImage = storeContent() {
        didSet {
            if isSelected {
                storeIcon.image = UIImage(named: (accountImage.storeIconSelected)!)
            } else {
            storeIcon.image = UIImage(named: (accountImage.storeIcon)!)
            storeName.text = accountImage.storeName
            }
        }
    }
    
    let storeIcon: UIImageView = {
        let prefIcon = UIImageView()
//        prefIcon.image = UIImage(named: "store_unselected")
        prefIcon.contentMode = .scaleAspectFit
        prefIcon.clipsToBounds = true
        prefIcon.layer.masksToBounds = true
        prefIcon.translatesAutoresizingMaskIntoConstraints = false
        
        return prefIcon
    }()
    
    let storeName: UILabel = {
        let prefLabel = UILabel()
        prefLabel.textAlignment = .center
        prefLabel.text = "Opps"
        prefLabel.textColor = UIColor.ademBlue
        //prefLabel.backgroundColor = UIColor.red
        prefLabel.font = UIFont(name: productFont, size: 20)
        prefLabel.clipsToBounds = true
        prefLabel.layer.masksToBounds = true
        prefLabel.translatesAutoresizingMaskIntoConstraints = false
        return prefLabel
    }()
    

    func setupViews() {
        
        addSubview(storeIcon)
        addSubview(storeName)
        //preferencesIcon.layer.cornerRadius = 25
        
        NSLayoutConstraint.activate([
            storeIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            storeIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        storeIcon.widthAnchor.constraint(equalToConstant: 50),
        storeIcon.heightAnchor.constraint(equalToConstant: 50),
        
        storeName.topAnchor.constraint(equalTo: storeIcon.bottomAnchor, constant: 5),
        storeName.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        storeName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        storeName.widthAnchor.constraint(equalTo: self.widthAnchor),
        
        ])
    }
}
