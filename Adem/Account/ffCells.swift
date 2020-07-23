//
//  ffCells.swift
//  Adem
//
//  Created by Coleman Coats on 2/29/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Pantry Product Cell layout Final
class ffCell: UICollectionViewCell {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubs()
    }
    
    var friendsInAccount = friendFamily() {
        didSet {
            personImageView.image = UIImage(named: (friendsInAccount.friendImage)!)
            personName.text = friendsInAccount.friendName
        }
    }

    
    let personImageView: UIImageView = {
        let mealImage = UIImageView()
        mealImage.contentMode = .scaleAspectFill
        mealImage.clipsToBounds = true
        mealImage.layer.masksToBounds = true
        return mealImage
    }()
    
    let personName: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.textColor = UIColor.white
        name.textAlignment = .center
        name.font = UIFont(name: helNeu, size: 12)
        return name
    }()
    
    
    
    private func addSubs() {
        
        addSubview(personImageView)
        addSubview(personName)
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        personName.translatesAutoresizingMaskIntoConstraints = false
        personImageView.layer.cornerRadius = 25
//        personImageView.layer.cornerRadius = CGFloat(self.bounds.size.width / 2.0)
        
        setupViews()
    }
    
    func setupViews() {
        
        
        NSLayoutConstraint.activate([
            personImageView.topAnchor.constraint(equalTo: self.topAnchor),
//            personImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            personImageView.widthAnchor.constraint(equalToConstant: 50),

            personImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            personImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 7/10),
             personImageView.heightAnchor.constraint(equalToConstant: 50),
            
            
            personName.topAnchor.constraint(equalTo: personImageView.bottomAnchor),
            personName.widthAnchor.constraint(equalTo: self.widthAnchor),
            personName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            personName.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

