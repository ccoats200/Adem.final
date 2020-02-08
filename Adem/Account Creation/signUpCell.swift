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
class preferenceContent: NSObject {

    var preferenceImage: String?
    var preferencesLabelText: String?
}




class signUpCellDesign: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var accountImage: preferenceContent? {
        didSet {
            preferencesIcon.image = UIImage(named: (accountImage?.preferenceImage)!)
            preferencesLabel.text = accountImage?.preferencesLabelText
            
            print("The Account and Privacy celll layout and UI elements are set")
        }
    }
    
    let preferencesIcon: UIImageView = {
        let prefIcon = UIImageView()
        //prefIcon.image = UIImage(named: "Info")
        prefIcon.image = UIImage(named: "salt_unselected")
        prefIcon.contentMode = .scaleAspectFit
        prefIcon.clipsToBounds = true
        prefIcon.layer.masksToBounds = true
        prefIcon.translatesAutoresizingMaskIntoConstraints = false
        
        return prefIcon
    }()
    
    let preferencesLabel: UILabel = {
        let prefLabel = UILabel()
        prefLabel.textAlignment = .left
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
        
        
        preferencesIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        preferencesIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        preferencesIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        preferencesIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        preferencesLabel.leadingAnchor.constraint(equalTo: preferencesIcon.trailingAnchor, constant: 5).isActive = true
        preferencesLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        preferencesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
    }
}

