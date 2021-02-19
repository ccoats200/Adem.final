//
//  iconLayout.swift
//  Adem
//
//  Created by Coleman Coats on 2/18/21.
//  Copyright © 2021 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


class iconCell: UICollectionViewCell {
    
    
    //weak var delegate: pantryDelegate?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        setupViews()
    }

    
    let pantryItemImageView: UIImageView = {
        let mealImage = UIImageView()
        mealImage.contentMode = .scaleAspectFill
        mealImage.clipsToBounds = true
        mealImage.layer.masksToBounds = true
        mealImage.layer.cornerRadius = CGFloat(smallRound)
        mealImage.translatesAutoresizingMaskIntoConstraints = false
        return mealImage
    }()
    
    
    func setupViews() {
        addSubview(pantryItemImageView)
        
        NSLayoutConstraint.activate([
            pantryItemImageView.topAnchor.constraint(equalTo: self.topAnchor),
            pantryItemImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            pantryItemImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            pantryItemImageView.heightAnchor.constraint(equalTo: self.heightAnchor)

            ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
