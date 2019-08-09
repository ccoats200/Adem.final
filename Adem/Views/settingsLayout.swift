//
//  settingsLayout.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

//Account and Privacy Image Product Cell layout
class accountPrivacyCellDesign: CellBasics {
    
    var accountImage: profileContent? {
        didSet {
            accountPrivacyImages.image = UIImage(named: (accountImage?.accountImage)!)
            accountPrivacyLabels.text = accountImage?.userNameLabel
            
            print("The Account and Privacy celll layout and UI elements are set")
        }
    }
    
    let accountPrivacyImages: UIImageView = {
        let aPImages = UIImageView()
        //aPImages.image = UIImage(named: "Gear")
        aPImages.backgroundColor = UIColor.black
        aPImages.contentMode = .scaleAspectFit
        aPImages.clipsToBounds = true
        aPImages.layer.masksToBounds = true
        print("rounds the corners of the image view")
        aPImages.translatesAutoresizingMaskIntoConstraints = false
        
        return aPImages
    }()
    
    let accountPrivacyLabels: UILabel = {
        let aPLabels = UILabel()
        aPLabels.textAlignment = .center
        //aPLabels.text = "Settings"
        aPLabels.textColor
            = UIColor.blue
        aPLabels.numberOfLines = 1
        aPLabels.adjustsFontSizeToFitWidth = true
        //aPLabels.backgroundColor = UIColor.red
        aPLabels.clipsToBounds = true
        aPLabels.layer.masksToBounds = true
        aPLabels.font = UIFont.boldSystemFont(ofSize: 20)
        aPLabels.translatesAutoresizingMaskIntoConstraints = false
        print("sets the item name")
        return aPLabels
    }()
    
    
    
    
    override func setupViews() {
        addSubview(accountPrivacyImages)
        print("adds the product image subview")
        addSubview(accountPrivacyLabels)
        print("adds the product name subview")
        
        
        accountPrivacyImages.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        accountPrivacyImages.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        accountPrivacyLabels.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        accountPrivacyLabels.topAnchor.constraint(equalTo: accountPrivacyImages.bottomAnchor, constant: 5).isActive = true
        accountPrivacyLabels.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        accountPrivacyLabels.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}


