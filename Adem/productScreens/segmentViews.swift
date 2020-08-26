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
    var myMeals: [meals] = []
    var makableMeals = mealsMaster
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        for i in makableMeals {
                myMeals.append(i)
        }
        return myMeals.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mealRecCell = collectionView.dequeueReusableCell(withReuseIdentifier: mealsCelllID, for: indexPath) as! recMealsCellLayout
        for i in makableMeals {
                myMeals.append(i)
            mealRecCell.mealItem = myMeals[indexPath.item]
            }
        return mealRecCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("this is on the you can make page")
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
        mealrecos.register(recMealsCellLayout.self, forCellWithReuseIdentifier: mealsCelllID)
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
class statsSegment: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    let statsCelllID = "statsCells"
    var stats: UICollectionView!
    //initWithFrame to init view from code
  
    override init(frame: CGRect) {
   
        super.init(frame: frame)
    
    
        let layouts = UICollectionViewFlowLayout()
        stats = UICollectionView(frame: self.frame, collectionViewLayout: layouts)
        stats.isScrollEnabled = false
        stats.dataSource = self
        stats.delegate = self
        layouts.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stats.register(accountStatsProductCells.self, forCellWithReuseIdentifier: statsCelllID)
        stats.backgroundColor = UIColor.white
        
        stats.layer.cornerRadius = 10
        stats.clipsToBounds = true
        stats.layer.masksToBounds = true
        stats.isScrollEnabled = false
        
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
            return 2
        case 1:
            return 2
        default:
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let heights = (self.frame.height - 20)/2
        let width = (self.frame.width - 20)/2
        
        return CGSize(width: width, height: heights)
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellSection = indexPath.section
        let cellItem = indexPath.item

        let mealRecCell = collectionView.dequeueReusableCell(withReuseIdentifier: statsCelllID, for: indexPath) as! accountStatsProductCells

        
        switch cellSection {
        case 0:
            switch cellItem {
            case 0:
                mealRecCell.statLabel.text = "5"
                mealRecCell.tileLabel.text = "Days left"
            case 1:
                mealRecCell.statLabel.text = "$3"
                mealRecCell.tileLabel.text = "Avg. Cost"
            default:
                mealRecCell.tileLabel.text = "ops"
            }
            
        case 1:
            switch cellItem {
            case 0:
                mealRecCell.statLabel.text = "129"
                mealRecCell.tileLabel.text = "Calories eaten"
            case 1:
                mealRecCell.statLabel.text = "10%"
                mealRecCell.tileLabel.text = "Avg. waste"
            default:
                mealRecCell.statLabel.text = "Set up"
            }
            
        default:
            mealRecCell.tileLabel.text = "opps"
        }
            return mealRecCell
    }
    
  //common func to init our view
  private func setupView() {

    self.addSubview(stats)
    stats.translatesAutoresizingMaskIntoConstraints = false
    
     NSLayoutConstraint.activate([
        
        stats.topAnchor.constraint(equalTo: self.topAnchor),
        stats.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        stats.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        stats.widthAnchor.constraint(equalTo: self.widthAnchor),
    ])
  }
}
