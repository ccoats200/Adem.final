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
import FirebaseFirestore
import AVFoundation


class Meals: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    //TablView
    var tableViewCategories = ["Breakfast", "Lunch", "Dinner"]
    let mostRecent = "most recent"
    let productRFIDNumber = "3860407808"
    
    //MARK: Food.com API Command
    //kaggle datasets download -d shuyangli94/food-com-recipes-and-user-interactions
    
    var mealsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: NavigationBar setup
        navigationItem.title = "Meals"
        
        /*
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.ademBlue]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
*/
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.ademGreen
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
        }
        
        
        //tv
        mealsTableView = UITableView(frame: self.view.bounds)
        self.mealsTableView.delegate = self
        self.mealsTableView.dataSource = self
        self.view.addSubview(mealsTableView)
        
        mealsTableView.register(mealsTableViewCell.self, forCellReuseIdentifier: mealsCellID)
        mealsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        setUpDifferentViews()
        setUpBarButtonItems()
    }
    
    //Setting up bar buttons
    private func setUpBarButtonItems() {
        self.navigationItem.leftBarButtonItem = editButtonItem
        //self.navigationItem.leftBarButtonItem = edit
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
        //self.navigationItem.rightBarButtonItem = searching
    }
    
    //Setting up views
    
    func setUpDifferentViews() {

        //User interations
//        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(addLongGestureRecognizer))
//        lpgr.minimumPressDuration = 0.35
//        self.collectionView?.addGestureRecognizer(lpgr)
    }
    
    let mealsCellID = "meals"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mealsCell = tableView.dequeueReusableCell(withIdentifier: mealsCellID) as! mealsTableViewCell
        
        
        return mealsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewCategories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewCategories[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleProduct()
    }
    
    //MARK: Button handlers - Start
    @objc func handleProduct() {
        
        //transition testing
        //let transitionCoordinator = TransitionCoordinator()
        
        let cController = productVCLayout()
        cController.hidesBottomBarWhenPushed = true
        //transition testing
        //cController.transitioningDelegate = TransitionCoordinator.self as? UIViewControllerTransitioningDelegate
        cController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(cController, animated: true, completion: nil)
        
        print("Settings Tab is active")
    }

    
    /*
    
    // MARK: - Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if self.isEditing {
            self.navigationItem.rightBarButtonItem = nil
            //self.mealsCollectionView.allowsMultipleSelection = true
            self.tabBarController?.tabBar.isHidden = true
            self.navigationItem.rightBarButtonItems = [added, trashed]
            
        } else {
            
            self.navigationItem.rightBarButtonItems = [searching]
            self.tabBarController?.tabBar.isHidden = false
            //self.mealsCollectionView.allowsMultipleSelection = false
            
        }
        
        if let indexPaths = mealsCollectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = mealsCollectionView?.cellForItem(at: indexPath) as? pantryCellLayout {
                    cell.isEditing = editing
                }
            }
        }
    }
    */
    
    
//    @objc func addLongGestureRecognizer(_ gestureRecognizer: UILongPressGestureRecognizer) {
//        if gestureRecognizer.state != .began { return }
//        let p = gestureRecognizer.location(in: self.mealsCollectionView)
//        if let indexPath = self.mealsCollectionView.indexPathForItem(at: p) {
//            //let cell = self.collectionView.cellForItem(at: indexPath)
//
//            navigationController?.isEditing = true
//
//        } else {
//            print("can't find")
//        }
//    }

}
