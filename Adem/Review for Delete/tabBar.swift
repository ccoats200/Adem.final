//
//  tabBar.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Foundation



/*
 
 class menuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
 let buttonCellID = "buttonCell"
 let tabBarImages = [
 ["Home", "Pantry", "lock", "Knife_Lrg"],
 ["Home_Fill", "Pantry", "lock", "Knife_Lrg"]
 ]
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 
 
 tabBarButtons.register(tabCell.self, forCellWithReuseIdentifier: buttonCellID)
 
 addSubview(tabBarButtons)
 addConstraintsWithFormats(format: "H:|[v0]|", views: tabBarButtons)
 addConstraintsWithFormats(format: "V:|[v0]|", views: tabBarButtons)
 let selectedItemIndexPath = NSIndexPath(item: 0, section: 0)
 tabBarButtons.selectItem(at: selectedItemIndexPath as IndexPath, animated: false, scrollPosition: .centeredHorizontally)
 tabBarButtons.isScrollEnabled = false
 }
 
 //background color
 lazy var tabBarButtons: UICollectionView = {
 let TBBSLayout = UICollectionViewFlowLayout()
 let TBBS = UICollectionView(frame: .zero, collectionViewLayout: TBBSLayout)
 TBBS.backgroundColor = UIColor.ademGreen
 TBBS.dataSource = self
 TBBS.delegate = self
 
 return TBBS
 
 }()
 
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 print("makes 4 cells")
 
 return tabBarImages[0].count
 
 }
 
 @objc func handleTabCell() {
 let IC = PantryVC()
 IC.navigationController?.pushViewController(IC, animated: true)
 
 
 }
 
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCellID, for: indexPath) as! tabCell
 
 buttonCell.tabButtonView.image = UIImage(named: tabBarImages[0][indexPath.item])?.withRenderingMode(.alwaysTemplate)
 //buttonCell.tintColor = UIColor.rgb(red: 54, green: 147, blue: 111)
 buttonCell.tintColor = UIColor.white
 handleTabCell()
 
 
 return buttonCell
 
 
 
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 return CGSize(width: frame.width / CGFloat(integerLiteral: tabBarImages[0].count), height: frame.height)
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
 return 0
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
 }
 
 class tabCell: CellBasics {
 
 let tabButtonView: UIImageView = {
 let TBV = UIImageView()
 TBV.image = UIImage(named: "Home")?.withRenderingMode(.alwaysTemplate)
 //TBV.tintColor = UIColor.rgb(red: 54, green: 147, blue: 111)
 TBV.tintColor = UIColor.white
 
 return TBV
 }()
 
 
 override var isHighlighted: Bool {
 didSet {
 
 tabButtonView.tintColor = isHighlighted ? UIColor.rgb(red: 38, green: 96, blue: 164) : UIColor.white
 print("Tab bar item is highlighted")
 //tabButtonView.image = isSelected ? UIImage(named: "Home") : UIImage(named: "Home_Fill")
 }
 }
 
 
 override var isSelected : Bool {
 
 
 didSet {
 tabButtonView.tintColor = isSelected  ? UIColor.rgb(red: 38, green: 96, blue: 164) : UIColor.white
 print("Tab bar item is selected")
 
 //tabButtonView.image = isSelected ? UIImage(named: "Home") : UIImage(named: "Home_Fill")
 }
 }
 
 override func setupViews() {
 super.setupViews()
 addSubview(tabButtonView)
 
 addConstraintsWithFormats(format: "H:[v0(28)]", views: tabButtonView)
 addConstraintsWithFormats(format: "V:[v0(28)]", views: tabButtonView)
 
 addConstraint(NSLayoutConstraint(item: tabButtonView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
 addConstraint(NSLayoutConstraint(item: tabButtonView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
 }
 
 }
 */
