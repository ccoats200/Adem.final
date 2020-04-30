//
//  meals save.swift
//  Adem
//
//  Created by Coleman Coats on 2/27/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import UIKit
import Foundation
//MARK: Meals segment view

//MARK: might delete
class mealsSegmenta: UIView, UITableViewDataSource, UITableViewDelegate {
  
    
    let mealsCelllID = "mealsCells"
    var mealrecos: UITableView!
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productsListViewLayout = tableView.dequeueReusableCell(withIdentifier: self.mealsCelllID, for: indexPath)
        return productsListViewLayout
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
        
        mealrecos.dataSource = self
        mealrecos.delegate = self
        mealrecos.register(UITableViewCell.self, forCellReuseIdentifier: mealsCelllID)
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
