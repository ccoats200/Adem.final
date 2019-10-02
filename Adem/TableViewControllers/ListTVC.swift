//
//  ListTVC.swift
//  Adem
//
//  Created by Coleman Coats on 10/1/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class listTableViewCell: UITableViewCell {
    
    var friendName: String?
    var friendImage: UIImage?
    var friendTitle: String?
    
    //UIView Profile Pic
    let listCheckbox: UIImageView = {
        let picOfFriend = UIImageView()
        picOfFriend.contentMode = .scaleAspectFill
        picOfFriend.layer.cornerRadius = 15
        picOfFriend.layer.masksToBounds = true
        picOfFriend.clipsToBounds = true
        picOfFriend.layer.shadowColor = UIColor.clear.cgColor
        picOfFriend.layer.borderColor = UIColor.white.cgColor
        picOfFriend.translatesAutoresizingMaskIntoConstraints = false
        
        return picOfFriend
    }()
    
    let listProductName: UILabel = {
        let nameOfFriend = UILabel()
        nameOfFriend.textAlignment = .left
        nameOfFriend.numberOfLines = 1
        nameOfFriend.adjustsFontSizeToFitWidth = true
        //userName.font = UIFont(name: "Lato", size: 80)
        nameOfFriend.font = UIFont.boldSystemFont(ofSize: 20)
        //nameOfFriend.textColor = UIColor.ademBlue
        nameOfFriend.backgroundColor = UIColor.blue
        nameOfFriend.text = "Coleman"
        nameOfFriend.translatesAutoresizingMaskIntoConstraints = false
        print("sets the item name")
        return nameOfFriend
    }()
    
    let listProductQuantity: UILabel = {
        let access = UILabel()
        access.textAlignment = .left
        access.numberOfLines = 1
        access.adjustsFontSizeToFitWidth = true
        //userName.font = UIFont(name: "Lato", size: 80)
        access.font = UIFont.boldSystemFont(ofSize: 20)
        access.textColor = UIColor.ademBlue
        access.backgroundColor = UIColor.red
        access.translatesAutoresizingMaskIntoConstraints = false
        print("sets the item name")
        return access
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(listProductName)
        self.addSubview(listCheckbox)
        self.addSubview(listProductQuantity)
        
        /*
         let friendsStackView = UIStackView(arrangedSubviews: [friendsName, friendsTitle])
         friendsStackView.contentMode = .scaleAspectFit
         friendsStackView.translatesAutoresizingMaskIntoConstraints = false
         friendsStackView.distribution = .fillEqually
         friendsStackView.layer.masksToBounds = true
         friendsStackView.clipsToBounds = true
         friendsStackView.axis = .vertical
         
         //self.addSubview(friendsName)
         self.addSubview(friendsStackView)
         self.addSubview(friendsPicture)
         //self.addSubview(friendsTitle)
         
         
         
         
         NSLayoutConstraint.activate([
         
         friendsPicture.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
         friendsPicture.topAnchor.constraint(equalTo: self.topAnchor),
         friendsPicture.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         friendsPicture.widthAnchor.constraint(equalTo: self.heightAnchor),
         friendsStackView.leftAnchor.constraint(equalTo: friendsPicture.rightAnchor, constant: 15),
         friendsStackView.topAnchor.constraint(equalTo: self.topAnchor),
         friendsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         friendsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         
         ])
         */
        
        NSLayoutConstraint.activate([
            
            listCheckbox.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            listCheckbox.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            listCheckbox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            listCheckbox.heightAnchor.constraint(equalToConstant: 50),
            listCheckbox.widthAnchor.constraint(equalToConstant: 50),
            
            listProductName.leadingAnchor.constraint(equalTo: listCheckbox.trailingAnchor, constant: 5),
            listProductName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            listProductName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            listProductName.trailingAnchor.constraint(equalTo: listProductQuantity.leadingAnchor, constant: -5),
            
            listProductQuantity.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            listProductQuantity.centerYAnchor.constraint(equalTo: listProductName.centerYAnchor),
            listProductQuantity.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            listProductQuantity.widthAnchor.constraint(equalToConstant: 50),
            
            ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let message = friendName {
            listProductName.text = message
        }
        if let image = friendImage {
            listCheckbox.image = image
        }
        if let title = friendTitle {
            listProductQuantity.text = title
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


