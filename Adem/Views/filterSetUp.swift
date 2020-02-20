//
//  pantryFilter.swift
//  Adem
//
//  Created by Coleman Coats on 1/21/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class pantryFilter: UICollectionViewCell {

    static var identifier: String = "Cell"

    weak var textLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
        ])
        self.textLabel = textLabel
        self.reset()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }

    func reset() {
        self.textLabel.textAlignment = .center
    }
}


//Pantry Product Cell layout
class filterCellLayout: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupViews()
    }

    
    let productName: UILabel = {
        let name = UILabel()
        name.textAlignment = .left
        name.textColor = UIColor.white
        name.font = UIFont(name: helNeu, size: 15.0)
        name.numberOfLines = 0
//        name.backgroundColor = UIColor.red
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    func setupViews() {
        
        self.addSubview(productName)
        productName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //Product Name
            productName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            productName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
