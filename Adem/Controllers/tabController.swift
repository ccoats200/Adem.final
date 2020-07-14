//
//  tabController.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.

import Foundation
import UIKit
import Firebase
//import FirebaseFirestore
import AVFoundation

class tabBar: UITabBarController, UICollectionViewDelegateFlowLayout, UITabBarControllerDelegate {
    
    let cellID = "products"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Tab bar is its own delegate
        self.delegate = self
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.barTintColor = UIColor.white
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        setUpTabBAR()
        //determineEditingStateOfViewController()
    }
    var isManager = false
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

//    override func viewWillLayoutSubviews() {
//        <#code#>
//    }
//
//    override func viewDidLayoutSubviews() {
//        <#code#>
//    }
    
    func setUpTabBAR() {
        //List
        //let listLayout = UICollectionViewFlowLayout()
        //let pantryLayout = UICollectionViewFlowLayout()
        //let mealsLayout = UICollectionViewFlowLayout()
        
        //let listController = listCollectionView(collectionViewLayout: listLayout)
        let listController = listViewController()
        let listTabButton = UINavigationController(rootViewController: listController)
        listTabButton.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "list"), tag: 2)
        listTabButton.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        

        //Pantry
        let pantryController = PantryVC()
        let pantryTabButton = UINavigationController(rootViewController: pantryController)
        pantryTabButton.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Pantry_new"), tag: 2)
        pantryTabButton.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        
        //Meals
        //let mealsController = Meals(collectionViewLayout: mealsLayout)
        let mealsController = Meals()
        let mealsTabButton = UINavigationController(rootViewController: mealsController)
        mealsTabButton.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), tag: 2)
        mealsTabButton.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        //Account
        let accountController = AccountVC() //Meals(collectionViewLayout: layout)
        let accountTabButton = UINavigationController(rootViewController: accountController)
        accountTabButton.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "AccountIcon"), tag: 2)
        accountTabButton.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        viewControllers = [listTabButton, pantryTabButton, mealsTabButton, accountTabButton]
    
        self.tabBar.items?[1].badgeValue = "1"
    }
    
    /*
     func getArrayOfViewController() -> [UICollectionViewController] {
     let layout = UICollectionViewFlowLayout()
     let arrayOfVC = [listCollectionView(),PantryVC(),Meals()]
     let tabBarButtonNames = ["Home", "Pantry_new", "lock", "Knife_Lrg"]
     
     for i in 0..<5 {
     
     // customise controllers
     //arrayOfVC.append(vc)
     }
     
     return arrayOfVC
     }
     */
    private func tabControllerTemplate(viewController: UIViewController, imageName: String) -> UINavigationController {
        let viewController = AccountVC()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}


