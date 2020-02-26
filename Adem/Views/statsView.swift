//
//  statsView.swift
//  Adem
//
//  Created by Coleman Coats on 2/21/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Login text fields view
class statViews: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    let topAndBottomCelllID = "mealsCells"
    let middleCellID = "Middle"
    var mealrecos: UICollectionView!
    //initWithFrame to init view from code
  
    override init(frame: CGRect) {
   
        super.init(frame: frame)
    
    
        let layouts = UICollectionViewFlowLayout()
        mealrecos = UICollectionView(frame: self.frame, collectionViewLayout: layouts)
        mealrecos.isScrollEnabled = false
        mealrecos.dataSource = self
        mealrecos.delegate = self
        layouts.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        mealrecos.register(accountStatsProductCells.self, forCellWithReuseIdentifier: topAndBottomCelllID)
        //    mealrecos.register(accountStatsMiddleCells.self, forCellWithReuseIdentifier: middleCellID)
        mealrecos.backgroundColor = UIColor.white
        mealrecos.layer.cornerRadius = 5
        
        mealrecos.clipsToBounds = true
        mealrecos.layer.masksToBounds = true
        mealrecos.isScrollEnabled = false
        
        setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupView()
  }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        case 2:
            return 3
        default:
            return 3
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch indexPath.section {
        case 0,2:
            return CGSize(width: 100, height: 100)
        case 1:
            return CGSize(width: 160, height: 130)
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let mealRecCell = collectionView.dequeueReusableCell(withReuseIdentifier: topAndBottomCelllID, for: indexPath) as! accountStatsProductCells

    
        
        switch indexPath.section {
        case 0,2:
            mealRecCell.tileLabel.text = "test"
        case 1:
            mealRecCell.tileLabel.text = "middle"
        default:
            mealRecCell.tileLabel.text = "opps"
        }
            return mealRecCell
    }
    
  //common func to init our view
  private func setupView() {

    self.addSubview(mealrecos)
    mealrecos.translatesAutoresizingMaskIntoConstraints = false
    
     NSLayoutConstraint.activate([
        
        mealrecos.topAnchor.constraint(equalTo: self.topAnchor),
        mealrecos.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        mealrecos.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        mealrecos.widthAnchor.constraint(equalTo: self.widthAnchor),
    ])
  }
}
