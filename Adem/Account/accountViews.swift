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
//import FirebaseFirestore

class ProfileView: UIView {
    
    let urlImage = URL(string: "gs://adem-f0007.appspot.com/blueBerry.jpg")!
    
    //let task = URLSession.shared.dataTask(with: <#T##URLRequest#>)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    //UIView Profile Pic
    var coverPhoto: UIImageView = {
        let cover = UIImageView()
        //cover.image = UIImage(named: "coverPhotos")//coverPhotoL
        cover.backgroundColor = UIColor.ademBlue
        cover.layer.masksToBounds = true
        cover.clipsToBounds = true
        return cover
    }()
    
    //UIView Profile Pic
    var userProfileImage: UIImageView = {
        let profPic = UIImageView()
        profPic.image = UIImage(named: "me")
        profPic.contentMode = .scaleAspectFill
        profPic.layer.cornerRadius = 50
        profPic.layer.masksToBounds = true
        profPic.clipsToBounds = true
        profPic.layer.borderWidth = 4
        profPic.layer.shadowColor = UIColor.clear.cgColor
        profPic.layer.borderColor = UIColor.white.cgColor
        
        return profPic
    }()
    
    
//    var nameofUser: UILabel = {
//        let userName = UILabel()
//        userName.textAlignment = .center
//        userName.numberOfLines = 1
//        userName.adjustsFontSizeToFitWidth = true
//        userName.font = UIFont.boldSystemFont(ofSize: 20)
//        userName.textColor = UIColor.ademBlue
//        print("sets the item name")
//        return userName
//    }(){
    let nameofUser = navigationButton()
    
    func nameButtonSetUp() {
        nameofUser.largeNextButton.setTitleColor(UIColor.ademBlue, for: .normal)
        nameofUser.largeNextButton.backgroundColor = UIColor.clear
        
    }
    

  
    
    func setupViews() {
        
        nameButtonSetUp()
        
        
        self.addSubview(coverPhoto)
        self.addSubview(userProfileImage)
        self.addSubview(nameofUser)
        
        coverPhoto.translatesAutoresizingMaskIntoConstraints = false
        userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        nameofUser.translatesAutoresizingMaskIntoConstraints = false

        
        //CoverPhoto
        NSLayoutConstraint.activate([
            
        coverPhoto.widthAnchor.constraint(equalTo: self.widthAnchor),
        coverPhoto.topAnchor.constraint(equalTo: self.topAnchor), // height
        coverPhoto.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 6/10),
        
        //Profile Pic
        userProfileImage.centerXAnchor.constraint(equalTo: coverPhoto.centerXAnchor), //set the location of collection view
        userProfileImage.centerYAnchor.constraint(equalTo: coverPhoto.bottomAnchor), //set the location of collection view
        userProfileImage.heightAnchor.constraint(equalToConstant: 100), // width
        userProfileImage.widthAnchor.constraint(equalToConstant: 100),
        
        //Users Name
        nameofUser.centerXAnchor.constraint(equalTo: userProfileImage.centerXAnchor),
        nameofUser.topAnchor.constraint(equalTo: userProfileImage.bottomAnchor, constant: 5),
        nameofUser.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -125),
        nameofUser.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
    
        ])
    }
    
    /*
    override func updateConstraints() {
        super.updateConstraints()
    }
 */
}

class fAndFView: UIView {
    
    //let urlImage = URL(string: "gs://adem-f0007.appspot.com/blueBerry.jpg")!
    
    //let task = URLSession.shared.dataTask(with: <#T##URLRequest#>)
    
    let maxFriends = 4
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupViews()
    }
    
   //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupViews()
    }
    
    //UIView Profile Pic
    let addButton: UIButton = {
        let newFriend = UIButton()
        //newFriend.backgroundColor = UIColor.ademGreen
        newFriend.setTitle("+", for: .normal)
        newFriend.setTitleColor(UIColor.white, for: .normal)
        newFriend.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        
        return newFriend
    }()
    
    //UIView Profile Pic
    let userProfileImage: UIImageView = {
        let profPic = UIImageView()
        profPic.image = UIImage(named: "bread")
        profPic.contentMode = .scaleAspectFill
        profPic.layer.cornerRadius = 2
        profPic.layer.masksToBounds = true
        profPic.clipsToBounds = true
        //profPic.layer.borderWidth = 4
        profPic.layer.shadowColor = UIColor.clear.cgColor
        profPic.layer.borderColor = UIColor.white.cgColor
        
        return profPic
    }()
    
    let nameofUser: UILabel = {
        let userName = UILabel()
        //userName.text = "Kitchen Staff"
        //userName.backgroundColor = UIColor.ademGreen
        //userName.font = UIFont(name: "Lato", size: 80)
        userName.font = UIFont.boldSystemFont(ofSize: 15)
        userName.textColor = UIColor.white
        print("sets the item name")
        return userName
    }()
    
    private func setupViews() {
        
        self.backgroundColor = UIColor.ademBlue
        self.layer.cornerRadius = 5
        self.addSubview(addButton)
        self.addSubview(userProfileImage)
        self.addSubview(nameofUser)
        
        addButton.clipsToBounds = true
        addButton.layer.masksToBounds = true
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        nameofUser.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
        
        addButton.centerYAnchor.constraint(equalTo: nameofUser.centerYAnchor),
        addButton.widthAnchor.constraint(equalToConstant: 30),
        addButton.heightAnchor.constraint(equalToConstant: 30),
        //addButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50),
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
        
        //Users Name
        nameofUser.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        nameofUser.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
        nameofUser.rightAnchor.constraint(equalTo: addButton.leftAnchor),
        nameofUser.heightAnchor.constraint(equalToConstant: 25),
        
        
        //Top Friends
        userProfileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        userProfileImage.topAnchor.constraint(equalTo: addButton.bottomAnchor),
        userProfileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        //userProfileImage.heightAnchor.constraint(equalToConstant: 50),
        userProfileImage.widthAnchor.constraint(equalToConstant: 50),
        
        
    ])
    }
}
