//
//  accountComponents.swift
//  Adem
//
//  Created by Coleman Coats on 1/2/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


class searchView: UIView {
    
        override init(frame: CGRect){
            super.init(frame: frame)
            setUpAddDismiss()
        }
        
        
        lazy var deleteItemFromPantryButton: UIButton = {
            let login = UIButton(type: .system)
            login.backgroundColor = UIColor.ademBlue
            login.setTitle("Delete", for: .normal)
            login.translatesAutoresizingMaskIntoConstraints = false
            login.layer.masksToBounds = true
            login.clipsToBounds = true
            login.setTitleColor(UIColor.black, for: .normal)
            login.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            login.addTarget(self, action: #selector(deleteProductFromPantry), for: .touchUpInside)
            login.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            return login
            
        }()
        
        
        @objc func deleteProductFromPantry() {

            print("User clicked delete button")
        }

        lazy var addProductToListButton: UIButton = {
            let add = UIButton(type: .system)
            add.backgroundColor = UIColor.ademBlue
            add.setTitle("Add", for: .normal)
            add.translatesAutoresizingMaskIntoConstraints = false
            add.layer.masksToBounds = true
            add.clipsToBounds = true
            add.setTitleColor(UIColor.black, for: .normal)
            add.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            add.addTarget(self, action: #selector(addProductToListFromPantry), for: .touchUpInside)
            
            return add
            
        }()
        
        @objc func addProductToListFromPantry() {
            
            print("User clicked add items button. User moved products from their pantry to their list.")
        }
        
        func setUpAddDismiss() {
            
            let alertStackView = UIStackView(arrangedSubviews: [addProductToListButton, deleteItemFromPantryButton])
            alertStackView.contentMode = .scaleAspectFit
            alertStackView.translatesAutoresizingMaskIntoConstraints = false
            alertStackView.distribution = .fillEqually
            alertStackView.layer.masksToBounds = true
            alertStackView.clipsToBounds = true
            
            self.addSubview(alertStackView)
            
            alertStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            alertStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            alertStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            alertStackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        }
        
        override func updateConstraints() {
            super.updateConstraints()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

//MARK: Continued info view
class continuedInfo: UIView {
  
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
  
    let searchBar: UISearchBar = {
        let searchBars = UISearchBar()
        searchBars.searchBarStyle = .minimal
        searchBars.layer.cornerRadius = 5
        return searchBars
    }()
    
    let expandButton: UIButton = {
        let expand = UIButton()
        expand.backgroundColor = UIColor.blue
        expand.layer.cornerRadius = 5
        expand.translatesAutoresizingMaskIntoConstraints = false
        return expand
    }()
       
  //common func to init our view
  private func setupView() {
    self.backgroundColor = UIColor.white
    self.addSubview(searchBar)
    self.addSubview(expandButton)
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.clipsToBounds = true
    
    NSLayoutConstraint.activate([
    searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
    searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 1),
    searchBar.widthAnchor.constraint(equalToConstant: 275),
    searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 1),
    
    expandButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
    expandButton.leftAnchor.constraint(equalTo: searchBar.rightAnchor),
    expandButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -1),
    expandButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 1),
        
    ])
  }
}



