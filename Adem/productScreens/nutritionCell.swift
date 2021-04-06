//
//  nutritionCell.swift
//  Adem
//
//  Created by Coleman Coats on 4/1/21.
//  Copyright © 2021 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class nutritionCell: UICollectionViewCell {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        addSubs()
    }
    
    let nutriName: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.font = name.font.withSize(15)
        name.textColor = UIColor.ademBlue
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let nutriAmount: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.font = name.font.withSize(15)
        name.textColor = UIColor.ademBlue
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    private func addSubs() {
        
        addSubview(nutriName)
        //addSubview(units)
        addSubview(nutriAmount)
        
        setupViews()
    }
    
    func setupViews() {
        
        NSLayoutConstraint.activate([
            
            nutriName.topAnchor.constraint(equalTo: self.topAnchor),
            nutriName.widthAnchor.constraint(equalTo: self.widthAnchor),
            nutriName.rightAnchor.constraint(equalTo: self.rightAnchor),
            nutriName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
            
            nutriAmount.topAnchor.constraint(equalTo: nutriName.bottomAnchor),
            nutriAmount.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nutriAmount.leftAnchor.constraint(equalTo: self.leftAnchor),
            nutriAmount.widthAnchor.constraint(equalTo: self.widthAnchor),
      
            
            ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
