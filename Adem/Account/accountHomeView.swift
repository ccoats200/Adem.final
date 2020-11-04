//
//  accountHomeView.swift
//  Adem
//
//  Created by Coleman Coats on 2/29/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase


//MARK: Login button view
class homeView: UIView {
  
    //MARK: Views
//    var friendsAndFamily = fAndFView()
    var friendsAndFamily: UICollectionView!
    var accountTableView: UITableView!
    var logOutButton = navigationButton()

    //var friendsAssociated = friends
    //let collectionViewHeaderFooterReuseIdentifier = "MyHeaderFooterClass"
    
    //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
  
    setupView()
    setUpButtons()
  }
  
  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
    
    
    private func setUpButtons() {
        //MARK: login button
        logOutButton.largeNextButton.backgroundColor = UIColor.ademBlue
        logOutButton.largeNextButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.largeNextButton.layer.masksToBounds = true
        logOutButton.largeNextButton.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    func setUpTableView() {
        let displayWidth: CGFloat = self.frame.width
        let displayHeight: CGFloat = self.frame.height
        
        accountTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        accountTableView.rowHeight = 50
        
//        accountTableView.rowHeight = UITableView.automaticDimension
//        accountTableView.estimatedRowHeight = 100
        
        
        let friendsAndFamilyLayouts = UICollectionViewFlowLayout()
        friendsAndFamily = UICollectionView(frame: self.bounds, collectionViewLayout: friendsAndFamilyLayouts)
        friendsAndFamily.contentInset = UIEdgeInsets(top: 15, left: 5, bottom: -5, right: 5)
    }
    
  //common func to init our view
  private func setupView() {
    
    self.backgroundColor = UIColor.white
    setUpTableView()
    
    self.addSubview(friendsAndFamily)
    self.addSubview(accountTableView)
    self.addSubview(logOutButton)
    
    friendsAndFamily.backgroundColor = UIColor.ademBlue
    friendsAndFamily.layer.cornerRadius = 5
    accountTableView.backgroundColor = UIColor.red
    friendsAndFamily.translatesAutoresizingMaskIntoConstraints = false
    accountTableView.translatesAutoresizingMaskIntoConstraints = false
    logOutButton.translatesAutoresizingMaskIntoConstraints = false

    
        NSLayoutConstraint.activate([
            
            friendsAndFamily.topAnchor.constraint(equalTo: self.topAnchor),
            friendsAndFamily.heightAnchor.constraint(equalToConstant: 100),
            friendsAndFamily.widthAnchor.constraint(equalTo: self.widthAnchor),
            friendsAndFamily.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            accountTableView.topAnchor.constraint(equalTo: friendsAndFamily.bottomAnchor, constant: 15),
            accountTableView.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -15),
            accountTableView.widthAnchor.constraint(equalTo: self.widthAnchor),
            accountTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            logOutButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            logOutButton.heightAnchor.constraint(equalToConstant: 30),
            logOutButton.widthAnchor.constraint(equalTo: self.widthAnchor),
            logOutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
  }
}

//extension homeView: UICollectionViewDelegateFlowLayout {
//    //do I need to put stuff here?
//}
