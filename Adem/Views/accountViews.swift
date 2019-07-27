//
//  accountViews.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class ProfileView: UIView {
    
    //UIView Profile Pic
    var coverPhoto: UIImageView = {
        let cover = UIImageView()
        cover.image = UIImage(named: "eggs")
        cover.layer.masksToBounds = true
        cover.clipsToBounds = true
        cover.translatesAutoresizingMaskIntoConstraints = false
        return cover
    }()
    
    //UIView Profile Pic
    var userProfileImage: UIImageView = {
        let profPic = UIImageView()
        profPic.image = UIImage(named: "bread")
        profPic.contentMode = .scaleAspectFill
        profPic.layer.cornerRadius = 50
        profPic.layer.masksToBounds = true
        profPic.clipsToBounds = true
        profPic.layer.borderWidth = 4
        profPic.layer.shadowColor = UIColor.clear.cgColor
        profPic.layer.borderColor = UIColor.white.cgColor
        profPic.translatesAutoresizingMaskIntoConstraints = false
        
        return profPic
    }()
    
    var nameofUser: UILabel = {
        let userName = UILabel()
        userName.textAlignment = .center
        userName.numberOfLines = 1
        userName.adjustsFontSizeToFitWidth = true
        //userName.font = UIFont(name: "Lato", size: 80)
        userName.font = UIFont.boldSystemFont(ofSize: 20)
        userName.textColor = UIColor.ademBlue
        userName.translatesAutoresizingMaskIntoConstraints = false
        print("sets the item name")
        return userName
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setupViews()
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setupViews()
        updateConstraints()
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.addSubview(coverPhoto)
        self.addSubview(userProfileImage)
        self.addSubview(nameofUser)
        
        //CoverPhoto
        coverPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true //set the location of collection view
        coverPhoto.trailingAnchor.constraint(equalTo:  self.trailingAnchor).isActive = true // top anchor of collection view
        coverPhoto.topAnchor.constraint(equalTo: self.topAnchor).isActive = true // height
        coverPhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true // width
        
        //Profile Pic
        userProfileImage.centerXAnchor.constraint(equalTo: coverPhoto.centerXAnchor).isActive = true //set the location of collection view
        userProfileImage.centerYAnchor.constraint(equalTo: coverPhoto.bottomAnchor).isActive = true //set the location of collection view
        userProfileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true // width
        userProfileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //Users Name
        nameofUser.centerXAnchor.constraint(equalTo: userProfileImage.centerXAnchor).isActive = true
        nameofUser.topAnchor.constraint(equalTo: userProfileImage.bottomAnchor, constant: 5).isActive = true
        nameofUser.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true // width
        nameofUser.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    
    
    override func updateConstraints() {
        super.updateConstraints()
        setupViews()
    }
    
}
