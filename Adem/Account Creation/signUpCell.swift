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
class storeContent: NSObject {

    var preferenceImage: String?
    var preferencesLabelText: String?
}


class storeCellDesign: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var accountImage: storeContent? {
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
