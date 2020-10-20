//
//  collectionViewFilter.swift
//  Adem
//
//  Created by Coleman Coats on 10/7/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class pantryCollectioViewFilter: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        addSubs()
    }

    let pantryItemName: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.textAlignment = .left
        name.font = name.font.withSize(15)
        name.textColor = UIColor.ademBlue
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private func addSubs() {
        
        addSubview(pantryItemName)
        setupViews()
    }
    
    func setupViews() {
        
        NSLayoutConstraint.activate([
            pantryItemName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pantryItemName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pantryItemName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 6.5/10),

            ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
