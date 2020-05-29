//
//  Meals.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVFoundation


class Meals: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    
    //TablView
    var tableViewCategories = ["Breakfast"]
    let mostRecent = "most recent"
    let productRFIDNumber = "3860407808"
    
    //MARK: Food.com API Command
    //https://www.kaggle.com/shuyangli94/food-com-recipes-and-user-interactions
    //kaggle datasets download -d shuyangli94/food-com-recipes-and-user-interactions
    
    var mealsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: NavigationBar setup
        navigationItem.title = "Meals"
        
        setUpNavigationBar()
        setUpSearchBar()
        setUpDifferentViews()
        
        refressss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        mealsSearchController.searchBar.becomeFirstResponder()

    }
    
    //MARK: Pull to refresh
    var refreshControl = UIRefreshControl()
    func refressss() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        mealsTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        //https://stackoverflow.com/questions/24475792/how-to-use-pull-to-refresh-in-swift

        //need delay
        refreshControl.endRefreshing()
    }

    
    func setUpNavigationBar() {
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.ademBlue]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false

        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.ademGreen
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.largeTitleDisplayMode = .always
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        //MARK: Search bar
//        setUpSearchBar()

    }
    
    
    lazy var searching = UIBarButtonItem(image: UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    let mealsSearchController = UISearchController(searchResultsController: nil)

    private func setUpSearchBar() {
        mealsSearchController.searchResultsUpdater = self
        mealsSearchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.navigationItem.searchController = mealsSearchController
        mealsSearchController.hidesNavigationBarDuringPresentation = false
        mealsSearchController.searchBar.tintColor = UIColor.white
        mealsSearchController.searchBar.delegate = self
        mealsSearchController.searchBar.autocorrectionType = .default
        mealsSearchController.searchBar.enablesReturnKeyAutomatically = true
        mealsSearchController.searchBar.placeholder = "What would you like to Make?"
        
        //filter
        self.navigationItem.leftBarButtonItem = searching
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func handleSearch() {
        print("filter tapped")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("test")
    }
    
    //Setting up views
    
    func setUpDifferentViews() {

        //tv
        mealsTableView = UITableView(frame: self.view.bounds, style: .grouped)
        
        self.view.addSubview(mealsTableView)
        
        mealsTableView.delegate = self
        mealsTableView.dataSource = self

        
        
        mealsTableView.register(mealsTableViewCell.self, forCellReuseIdentifier: mealsCellID)
        mealsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            mealsTableView.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        
        
        NSLayoutConstraint.activate([

            mealsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mealsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mealsTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mealsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    let mealsCellID = "meals"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mealsCell = tableView.dequeueReusableCell(withIdentifier: mealsCellID) as! mealsTableViewCell
        
        mealsCell.cellDelegate = self
        
        return mealsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 220
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return tableViewCategories.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let he = tableViewHeader()
        return he
    }
    
}

extension Meals: CustomCollectionCellDelegate {
   
    

    func collectionView(collectioncell: UICollectionViewCell?, didTappedInTableview TableCell: UITableViewCell) {
        //https://slicode.com/collectionview-inside-tableview-cell-part-3/
        let mealRecipe = mealVCLayout()
//        let mealRecipe = listProductVCLayout()
        mealRecipe.modalPresentationStyle = .overFullScreen
        self.present(mealRecipe, animated: true, completion: nil)
    }
}
