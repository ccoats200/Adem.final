//
//  accountStatsCells.swift
//  Adem
//
//  Created by Coleman Coats on 2/27/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//List Delete protocol
protocol accountStatsDelegate: class {
    func notInterested(cell: accountStatsProductCells)
    func interested(cell: accountStatsProductCells)
}

class accountStatsProductCells: UICollectionViewCell {
    //MARK: This cell is for all the free cells
    
    weak var delegate: accountStatsDelegate?
    
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
      super.init(frame: frame)
        
        self.backgroundColor = UIColor.ademGreen
        self.layer.cornerRadius = 5
        setupView()
        setUpConstraintsForCell()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    let statLabel: UILabel = {
        let stat = UILabel()
        stat.text = "50"
        stat.textAlignment = .center
        stat.font = UIFont(name: hNBold, size: 25)
        stat.textColor = UIColor.white
        stat.layer.cornerRadius = 5
        stat.translatesAutoresizingMaskIntoConstraints = false
        return stat
    }()
    
    let tileLabel: UILabel = {
        let text = UILabel()
        text.text = "Meals"
        text.textAlignment = .center
        text.textColor = UIColor.white
        text.font = UIFont(name: hNBold, size: 15)
        text.layer.cornerRadius = 5
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
     private func setupView() {
        
        addSubview(tileLabel)
        addSubview(statLabel)
        statLabel.translatesAutoresizingMaskIntoConstraints = false
        tileLabel.translatesAutoresizingMaskIntoConstraints = false
            
    }
    
    private func setUpConstraintsForCell() {
        
        NSLayoutConstraint.activate([
            
            
            statLabel.bottomAnchor.constraint(equalTo: tileLabel.topAnchor),
            statLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            statLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            statLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
            
            
            tileLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tileLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            tileLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4),
            tileLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
    ])
        
    }
}


//MARK: Might delete
//List Delete protocol
protocol accountStatsMiddelDelegate: class {
    func notInterested(cell: accountStatsMiddleCells)
    func interested(cell: accountStatsMiddleCells)
}

class accountStatsMiddleCells: UICollectionViewCell {
    //MARK: This cell is for all the free cells
    
    weak var delegate: accountStatsMiddelDelegate?
    
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
      super.init(frame: frame)
        setupView()
        setUpConstraintsForCell()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    let productImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor.red
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
