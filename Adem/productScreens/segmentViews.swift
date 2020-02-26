//
//  segmentViews.swift
//  Adem
//
//  Created by Coleman Coats on 2/22/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Meals segment view
class mealsSegment: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
  
    
    let mealsCelllID = "mealsCells"
    var mealrecos: UICollectionView!
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mealRecCell = collectionView.dequeueReusableCell(withReuseIdentifier: mealsCelllID, for: indexPath) as! recommendedProductCells

        return mealRecCell
    }
    
    
    let segmentLabel: UILabel = {
        let meal = UILabel()
        meal.textColor = UIColor.ademBlue
        meal.text = "You Can Make"
        meal.font = UIFont(name: hNBold, size: 18)
        meal.textAlignment = .center
        meal.layer.cornerRadius = 5
        meal.translatesAutoresizingMaskIntoConstraints = false
        return meal
    }()
    
    
    private func setupCollectionView() {
        
        
        let layouts = UICollectionViewFlowLayout()
        layouts.itemSize = CGSize(width: 100, height: 100)
        mealrecos = UICollectionView(frame: self.frame, collectionViewLayout: layouts)
        mealrecos.isScrollEnabled = false
        mealrecos.dataSource = self
        mealrecos.delegate = self
        mealrecos.register(recommendedProductCells.self, forCellWithReuseIdentifier: mealsCelllID)
        mealrecos.backgroundColor = UIColor.white
        
        mealrecos.clipsToBounds = true
        mealrecos.layer.masksToBounds = true
        mealrecos.isScrollEnabled = true
    }
       
  //common func to init our view
  private func setupView() {
    setupCollectionView()
    self.backgroundColor = UIColor.white
    
    self.addSubview(mealrecos)
    self.addSubview(segmentLabel)
    mealrecos.translatesAutoresizingMaskIntoConstraints = false
    segmentLabel.translatesAutoresizingMaskIntoConstraints = false
    
     NSLayoutConstraint.activate([
        
        segmentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        segmentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        segmentLabel.heightAnchor.constraint(equalToConstant: 30),
        segmentLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50),
        
        mealrecos.topAnchor.constraint(equalTo: segmentLabel.bottomAnchor, constant: 5),
        mealrecos.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        mealrecos.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        mealrecos.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -12),
    ])
  }
}


//MARK: Product name view
class statsSegment: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
  
    let statsCellID = "stats"
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: statsCellID, for: indexPath) as! recommendedProductCells
        
        productCell.backgroundColor = UIColor.white
        
        
        return productCell
    }

       
  //common func to init our view
  private func setupView() {
    self.backgroundColor = UIColor.red
  }
}
