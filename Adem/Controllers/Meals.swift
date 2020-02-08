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
//import FirebaseFirestore
import AVFoundation


class Meals: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    //TablView
    var tableViewCategories = ["Breakfast", "Lunch", "Dinner"]
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
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
        }
        
        
        
        
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
    
    let segmentContr: UISegmentedControl = {
        let items = ["Breakfast", "Lunch", "Dinner"]
        let segmentContr = UISegmentedControl(items: items)
        segmentContr.tintColor = UIColor.white
        segmentContr.selectedSegmentIndex = 0
        //segmentContr.layer.cornerRadius = 5
        segmentContr.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.ademBlue], for: .selected)
               
        segmentContr.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)

        segmentContr.backgroundColor = UIColor.ademBlue
               segmentContr.addTarget(self, action: #selector(switchSegViews), for: .valueChanged)
        return segmentContr
        
    }()
    
    @objc fileprivate func switchSegViews() {
        print("test")
    }
    //Setting up views
    
    func setUpDifferentViews() {

        //tv
        mealsTableView = UITableView(frame: self.view.bounds)
        
        self.view.addSubview(mealsTableView)
        self.view.addSubview(segmentContr)
        
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        
        mealsTableView.register(mealsTableViewCell.self, forCellReuseIdentifier: mealsCellID)
        mealsTableView.translatesAutoresizingMaskIntoConstraints = false
        segmentContr.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            segmentContr.topAnchor.constraint(equalTo: view.topAnchor),
            segmentContr.heightAnchor.constraint(equalToConstant: 25),
            segmentContr.widthAnchor.constraint(equalTo: view.widthAnchor),
            segmentContr.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mealsTableView.topAnchor.constraint(equalTo: segmentContr.bottomAnchor),
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
}
