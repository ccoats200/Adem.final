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

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        MARK: NavigationBar setup
        navigationItem.title = "What Can I help you find?"

        
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
        
        
        setUpListView()
        
        
        filterTableView.dataSource = self
        filterTableView.delegate = self
        filterTableView.allowsMultipleSelection = true
        filterTableView.backgroundColor = UIColor.white
        filterTableView.allowsMultipleSelectionDuringEditing = true
        filterTableView.allowsSelectionDuringEditing = true
        
        //MARK: Buttons
        buttonsClicked()
    }
    
//    MARK: - Var & Let

//    MARK: FireBase Populate List


//    MARK: Table view
    var filterTableView: UITableView!
    let tableViewCell = "test"
    let cellID = "product"
    let headerID = "collectionViewHeader"

//    MARK: - Var & Let
    
    //MARK: Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpLayouts()
        
        
        self.filterTableView.reloadData()
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
            
            filterTableView = UITableView(frame: self.view.bounds)
            
//          MARK: Subviews
            self.view.addSubview(filterTableView)
            filterTableView.translatesAutoresizingMaskIntoConstraints = false
            filterTableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCell)
            createLayout()
  
        }
    }
    
    private func createLayout() {
//            MARK: Constraints
        NSLayoutConstraint.activate([

            filterTableView.topAnchor.constraint(equalTo: view.topAnchor),
            filterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filterTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
        welcome.text = "What are you looking for?"
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


//MARK: - tableView extension
extension filterViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Table view cell properties - Start
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return productCategories.count

        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productsListCell = filterTableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath)
        productsListCell.textLabel?.text = productCategories[indexPath.row]
        
        return productsListCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    
    }
       
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = 45
        return CGFloat(cellHeight)
       }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
     
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            //Works
            
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let stackView = UIStackView(arrangedSubviews: [cancelbutton, welcomeLabel, clearFilterbutton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.alignment = .fill
        
        
        headerView.addSubview(stackView)
        headerView.addSubview(textFieldSeparator)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        textFieldSeparator.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([

                stackView.topAnchor.constraint(equalTo: headerView.topAnchor),
                stackView.heightAnchor.constraint(equalToConstant: 60),
                stackView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                stackView.widthAnchor.constraint(equalTo: headerView.widthAnchor, constant: -50),
                
                textFieldSeparator.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
                textFieldSeparator.centerXAnchor.constraint(equalTo: welcomeLabel.centerXAnchor),
                textFieldSeparator.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor),
                textFieldSeparator.heightAnchor.constraint(equalToConstant: 1)
            
            
            ])
            return headerView
        }
       
       //Multiple selection
       func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
           
           return true
       }
}
