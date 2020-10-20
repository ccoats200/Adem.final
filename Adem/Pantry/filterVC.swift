//
//  filterVC.swift
//  Adem
//
//  Created by Coleman Coats on 6/16/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


import Foundation
import UIKit
import Firebase
import AVFoundation
import CoreData
import FirebaseFirestoreSwift

class filterViewController: UIViewController {

    //This needs to be a collection view???
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        MARK: NavigationBar setup

        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.ademGreen
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

//            MARK: Opt out of dark mode
//            overrideUserInterfaceStyle = .light
        } else {
            
        }
        
        setUpCollectionView()

        //MARK: Buttons
        buttonsClicked()
    }
    
//    MARK: - Var & Let

//    MARK: FireBase Populate List


//    MARK: Table view
    var filterTableView: UITableView!
    var filterCollectionView: UICollectionView!
    let tableViewCell = "test"
    let cellID = "product"
    let headerID = "collectionViewHeader"

//    MARK: - Var & Let
    
    //MARK: Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpLayouts()
        
        self.filterCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpLayouts()
    }
    
    func setUpLayouts() {
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
    }
//    MARK: - Table View
    func setUpListView() {
        
        //TODO: If empty
        switch productsGlobal?.isEmpty {
        case true:
            
            let footerView = UIView()
            footerView.backgroundColor = UIColor.ademRed
            self.view.addSubview(footerView)
            footerView.translatesAutoresizingMaskIntoConstraints = false
            
            //MARK: tableView constraints
            NSLayoutConstraint.activate([
                footerView.topAnchor.constraint(equalTo: view.topAnchor),
                footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                ])
            
        default:

            createLayout()
  
        }
    }
    
    func setUpCollectionView() {
        let mealsCollectionViewlayouts = UICollectionViewFlowLayout()
        mealsCollectionViewlayouts.scrollDirection = .vertical
        
        self.filterCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: mealsCollectionViewlayouts)

          
        filterCollectionView.showsHorizontalScrollIndicator = false
        self.filterCollectionView.dataSource = self
        self.filterCollectionView.delegate = self
        self.filterCollectionView.register(pantryCollectioViewFilter.self, forCellWithReuseIdentifier: tableViewCell)
        if #available(iOS 13.0, *) {
            self.filterCollectionView.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        self.filterCollectionView.isUserInteractionEnabled = true
        self.filterCollectionView.isScrollEnabled = true
        
        //CollectionView spacing
        filterCollectionView.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        
        self.filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //adding subviews to the view controller
        self.view.addSubview(filterCollectionView)
        
    }
    
    private func createLayout() {
//            MARK: Constraints
        NSLayoutConstraint.activate([

            filterCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            filterCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
 
            ])
    }
    //MARK: - Table view cell properties - End
    
    
    //MARK: Button Functions - Start

    func buttonsClicked() {
        cancelbutton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        clearFilterbutton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
   
    //Edit Button
    @objc func handleBack() {
        self.dismiss(animated: true, completion: nil)
        print("went back to previous page")
    }
    
    @objc func clearFilters() {
        print("Edit button was clicked")
    }
    
   
    //product Button
    @objc func handleSearch() {

        if #available(iOS 13.0, *) {
            let productScreen = camVC()
            productScreen.hidesBottomBarWhenPushed = true
            productScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(productScreen, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    //Button Functions - End
    
    //MARK: - Filter header
    let welcomeLabel: UILabel = {
        var welcome = UILabel()
        welcome.text = "What can I help you find?"
        welcome.textAlignment = .center
        welcome.numberOfLines = 0
        welcome.textColor = UIColor.ademBlue
        welcome.backgroundColor = UIColor.white
        welcome.font = UIFont(name: helNeu, size: 20.0)
        welcome.translatesAutoresizingMaskIntoConstraints = false
        return welcome
    }()
    
    let cancelbutton: UIButton = {
        let cancel = UIButton()
        cancel.setTitle("X", for: .normal)
        cancel.setTitleColor(.black, for: .normal)
        cancel.clipsToBounds = true
        cancel.layer.masksToBounds = true
        cancel.translatesAutoresizingMaskIntoConstraints = false
        return cancel
    }()
    
    let clearFilterbutton: UIButton = {
        let clear = UIButton()
        clear.setTitle("!", for: .normal)
        clear.setTitleColor(.ademBlue, for: .normal)
        clear.clipsToBounds = true
        clear.layer.masksToBounds = true
        clear.translatesAutoresizingMaskIntoConstraints = false
        return clear
    }()
    
    let textFieldSeparator: UIView = {
        let textSeparator = UIView()
        textSeparator.backgroundColor = UIColor.ademBlue
        textSeparator.translatesAutoresizingMaskIntoConstraints = false
        return textSeparator
    }()

    
//MARK: - class end dont delete this }
}

extension filterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productsListCell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: self.tableViewCell, for: indexPath) as! pantryCollectioViewFilter
        productsListCell.pantryItemName.text = productCategories[indexPath.row]
        productsListCell.layer.cornerRadius = 5
        
        return productsListCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("test the selection")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //MARK: Changes the size of the image in pantry
        return CGSize(width: 75, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}
