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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mealRecCell = collectionView.dequeueReusableCell(withReuseIdentifier: mealsCelllID, for: indexPath) as! recommendedProductCells
        
        
        
        return mealRecCell
    }
    
    

    
    private func setupCollectionView() {
        
        
        let layouts = UICollectionViewFlowLayout()
        layouts.scrollDirection = .horizontal
        layouts.itemSize = CGSize(width: 120, height: 120)
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
    self.backgroundColor = UIColor.red
    setupCollectionView()
    
    self.addSubview(mealrecos)
    mealrecos.translatesAutoresizingMaskIntoConstraints = false
    
     NSLayoutConstraint.activate([
        
        mealrecos.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
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
