//
//  ProductCell.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//List Delete protocol
protocol recItemDelegate: class {
    func notInterested(cell: recommendedProductCells)
    func interested(cell: recommendedProductCells)
}

class recommendedProductCells: UICollectionViewCell {
    //MARK: This cell is for all the free cells
    
    weak var delegate: recItemDelegate?
    
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
      super.init(frame: frame)
        setupView()
        setUpConstraintsForCell()
    }
    
//    var recItem = recomend() {
//        didSet {
//            productImageView.image = UIImage(named: (recItem.itemImage)!)
//        }
//    }
//
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    let productImageView: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(named: "blueBerry")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor.ademBlue
        return image
    }()
    
     private func setupView() {
        
        addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
            
    }
    
    private func setUpConstraintsForCell() {
        
        NSLayoutConstraint.activate([
            
            productImageView.topAnchor.constraint(equalTo: self.topAnchor),
            productImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: self.heightAnchor)
            
    ])
        
    }
}


