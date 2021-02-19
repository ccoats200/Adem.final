//
//  editUserInfo.swift
//  Adem
//
//  Created by Coleman Coats on 2/18/21.
//  Copyright © 2021 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Firebase


class editUserInfoPage: UIViewController {
    
    let iconOptions = ["spatula", "nut", "spicy", "spoon", "veg", "salt","chop", "pot"]
    var userIcons: UICollectionView!
    let iconCCellID = "Cmeals"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.ademBlue
        
        

        fetchHomeSettings()
        setUpAddDismiss()
    }
    
   
    
    let usersName: UILabel = {
        var welcome = UILabel()
        welcome.text = "I Identify as..."//"\(fireBaseUsersName!)"
        welcome.textAlignment = .center
        welcome.textColor = UIColor.white
        welcome.font = UIFont(name: helNeu, size: 20.0)
        welcome.translatesAutoresizingMaskIntoConstraints = false
        return welcome
    }()

    
    func fetchHomeSettings() {
        
        userfirebasehome.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
            print("Error fetching document: \(error!)")
            return
            }
            guard let data = document.data() else {
            print("Document data was empty.")
            return
            }
        print("Current data: \(data)")
        }
    }
    
    func setUpAddDismiss() {
        
        let iconCollectionFlow = UICollectionViewFlowLayout()
        iconCollectionFlow.scrollDirection = .vertical
        
        self.userIcons = UICollectionView(frame: self.view.bounds, collectionViewLayout: iconCollectionFlow)

          
        userIcons.showsVerticalScrollIndicator = false
        self.userIcons.dataSource = self
        self.userIcons.delegate = self
        self.userIcons.register(iconCell.self, forCellWithReuseIdentifier: iconCCellID)
        self.userIcons.backgroundColor = .clear
        self.userIcons.isUserInteractionEnabled = true
        self.userIcons.isScrollEnabled = true
        
        //CollectionView spacing
        userIcons.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        view.addSubview(usersName)
        view.addSubview(userIcons)
        
        usersName.translatesAutoresizingMaskIntoConstraints = false
        userIcons.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            usersName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usersName.topAnchor.constraint(equalTo: view.topAnchor, constant: -10),
            usersName.widthAnchor.constraint(equalTo: view.widthAnchor),
            usersName.heightAnchor.constraint(equalToConstant: 50),
           
            userIcons.topAnchor.constraint(equalTo: usersName.bottomAnchor, constant: -10),
            userIcons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userIcons.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            userIcons.widthAnchor.constraint(equalTo: view.widthAnchor),
            

            
        ])
    }
}


extension editUserInfoPage: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconOptions.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pantryItemsCell = collectionView.dequeueReusableCell(withReuseIdentifier: iconCCellID, for: indexPath) as! iconCell
        pantryItemsCell.layer.cornerRadius = 5
        pantryItemsCell.pantryItemImageView.image = UIImage(named: iconOptions[indexPath.item])
        return pantryItemsCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        var icon = iconOptions[indexPath.item]
        //need to change automatically like the name
        defaults.set(icon, forKey: "icon")
        userfirebaseHomeSettings.updateData([
                                                "icon" : icon])
        print(icon)
        
        
        //This needs to change the value in firestore
        //default value should be the chefs hat
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //MARK: Changes the size of the image in pantry
        return CGSize(width: 112.5, height: 125)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

