//
//  recomendedMeals.swift
//  Adem
//
//  Created by Coleman Coats on 3/10/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//Pantry Product Cell layout
class recMealsCellLayout: UICollectionViewCell {
    
    weak var delegate: mealsItemDelegate?
    var eachCell: UIViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.white
        setupViews()
    }
    
//    var mealItem = meals() {
//            didSet {
//                mealImageView.image = UIImage(named: (mealItem.mealImage)!)
//                mealName.text = mealItem.mealName
//                
//            }
//        }
//    

    
    let mealImageView: UIImageView = {
        let mealImage = UIImageView()
        mealImage.contentMode = .scaleAspectFill
        mealImage.layer.cornerRadius = 5
        mealImage.clipsToBounds = true
        mealImage.layer.masksToBounds = true
        mealImage.translatesAutoresizingMaskIntoConstraints = false
        return mealImage
    }()
    
    let mealName: UILabel = {
        let mealName = UILabel()
        mealName.textAlignment = .left
        mealName.numberOfLines = 0
        mealName.font = UIFont(name: helNeu, size: 20)
        mealName.adjustsFontSizeToFitWidth = true
        mealName.translatesAutoresizingMaskIntoConstraints = false
        return mealName
    }()

   
    func setupViews() {
        
       
        
        self.addSubview(mealImageView)
        self.addSubview(mealName)
       
        
        mealImageView.translatesAutoresizingMaskIntoConstraints = false
        mealName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            mealImageView.topAnchor.constraint(equalTo: self.topAnchor),
            mealImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mealImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mealImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 7/10),
            
            
            mealName.topAnchor.constraint(equalTo: mealImageView.bottomAnchor),
            mealName.rightAnchor.constraint(equalTo: self.rightAnchor),
            mealName.leftAnchor.constraint(equalTo: mealImageView.leftAnchor),
            mealName.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
