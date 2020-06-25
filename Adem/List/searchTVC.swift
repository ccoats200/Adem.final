//
//  searchTVC.swift
//  Adem
//
//  Created by Coleman Coats on 6/25/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


class searchTableViewCell: UITableViewCell {
 
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(productName)
        self.addSubview(productImage)
        self.addSubview(productButton)
            
        NSLayoutConstraint.activate([
            
            productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            productImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            productImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 50),
            productImage.widthAnchor.constraint(equalToConstant: 50),
            productName.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 15),
            productName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            productName.bottomAnchor.constraint(equalTo: productButton.topAnchor, constant: -10),
            productName.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productButton.leftAnchor.constraint(equalTo: productName.leftAnchor),
            productButton.topAnchor.constraint(equalTo: productName.bottomAnchor),
            //friendsTitle.heightAnchor.constraint(equalToConstant: 10),
            productButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            productButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            ])
    }
        
    //UIView Profile Pic
        let productImage: UIImageView = {
            let pic = UIImageView()
            pic.contentMode = .scaleAspectFill
            pic.layer.cornerRadius = 15
            pic.layer.masksToBounds = true
            pic.clipsToBounds = true
            pic.layer.shadowColor = UIColor.clear.cgColor
            pic.layer.borderColor = UIColor.white.cgColor
            pic.translatesAutoresizingMaskIntoConstraints = false
            
            return pic
        }()
           
        let productName: UILabel = {
            let nameOfProduct = UILabel()
            nameOfProduct.textAlignment = .left
            nameOfProduct.numberOfLines = 1
            nameOfProduct.adjustsFontSizeToFitWidth = true
            nameOfProduct.font = UIFont.boldSystemFont(ofSize: 20)
            nameOfProduct.textColor = UIColor.ademBlue
            nameOfProduct.translatesAutoresizingMaskIntoConstraints = false
            return nameOfProduct
        }()
           
        let productButton: UIButton = {
            let add = UIButton()
            add.layer.cornerRadius = 5
            add.backgroundColor = UIColor.ademGreen
            add.translatesAutoresizingMaskIntoConstraints = false
            return add
        }()
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
}
