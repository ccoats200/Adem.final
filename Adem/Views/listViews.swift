//
//  listViews.swift
//  Adem
//
//  Created by Coleman Coats on 1/7/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Product name view
class listTableViewCells: UITableViewCell {
  
  var friendName: String?
  var friendImage: UIImage?
  var friendTitle: String?
  
  //UIView Profile Pic
  let friendsPicture: UIImageView = {
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
  
  let friendsName: UILabel = {
      let nameOfFriend = UILabel()
      nameOfFriend.textAlignment = .left
      nameOfFriend.numberOfLines = 1
      nameOfFriend.adjustsFontSizeToFitWidth = true
      //userName.font = UIFont(name: "Lato", size: 80)
      nameOfFriend.font = UIFont.boldSystemFont(ofSize: 20)
      nameOfFriend.textColor = UIColor.ademBlue
      //nameOfFriend.backgroundColor = UIColor.blue
      //userName.text = "Coleman"
      nameOfFriend.translatesAutoresizingMaskIntoConstraints = false
      print("sets the item name")
      return nameOfFriend
  }()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
      self.addSubview(friendsName)
      self.addSubview(friendsPicture)
      
      NSLayoutConstraint.activate([
          
          friendsPicture.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
          friendsPicture.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
          friendsPicture.centerYAnchor.constraint(equalTo: self.centerYAnchor),
          friendsPicture.heightAnchor.constraint(equalToConstant: 50),
          friendsPicture.widthAnchor.constraint(equalToConstant: 50),
          
          friendsName.leadingAnchor.constraint(equalTo: friendsPicture.trailingAnchor, constant: 5),
          friendsName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
          friendsName.heightAnchor.constraint(equalToConstant: 20),
          friendsName.trailingAnchor.constraint(equalTo: self.trailingAnchor),
          
          ])
  }
  
  override func layoutSubviews() {
      super.layoutSubviews()
      if let message = friendName {
          friendsName.text = message
      }
      if let image = friendImage {
          friendsPicture.image = image
      }
     
  }
  
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}

