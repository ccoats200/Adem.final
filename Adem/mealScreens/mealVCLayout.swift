//
//  mealVCLayout.swift
//  Adem
//
//  Created by Coleman Coats on 2/26/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseFirestore

class mealVCLayout: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    //MARK: View set up
    var productNameSection = mealsViews()
    var productImageSection = mealImageViews()
    var relatedProductInfoSection = mealsBottomViews()
    var ingrediantsList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.ademBlue
        
        setUpViews()
        setUpProductButtons()
        setupProductLayoutContstraints()

        self.dismiss(animated: true, completion: nil)
        
        
    }
    
        

    //MARK: Button engagement
    @objc func handleFacts() {
        //let signUpInfo = circleTest()
        let signUpInfo = Meals()
        self.present(signUpInfo, animated: true)
        print("went to new page")
    }
 
    //product Button
    @objc func handleBack() {
        self.dismiss(animated: true, completion: nil)
        print("went back to previous page")
    }
        
    @objc func handleNutritionLabel() {
        let productScreen = nutritionLabelVC()
        productScreen.hidesBottomBarWhenPushed = true
        self.present(productScreen, animated: true, completion: nil)
        
        print("Camera button working")
    }
    
    @objc func handlefave(sender: UIButton) {
        if productNameSection.faveButton.isSelected == true {
          productNameSection.faveButton.isSelected = false
        } else {
          productNameSection.faveButton.isSelected = true
            
        }
    }

    let segmentContr: UISegmentedControl = {
        let items = ["Ingredients", "Steps"]
        let segmentContr = UISegmentedControl(items: items)
        segmentContr.tintColor = UIColor.white
        segmentContr.selectedSegmentIndex = 0
        segmentContr.layer.cornerRadius = 5
        segmentContr.layer.borderWidth = 1
        segmentContr.layer.borderColor = UIColor.white.cgColor
        
        segmentContr.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.ademBlue], for: .selected)
        segmentContr.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)

        segmentContr.addTarget(self, action: #selector(switchViewAction), for: .valueChanged)
        
        segmentContr.backgroundColor = UIColor.ademBlue
        return segmentContr
  
    }()
    
    
    @objc func switchViewAction(_ segmentContr: UISegmentedControl) {
        self.view.bringSubviewToFront(segmentViews[segmentContr.selectedSegmentIndex])
    }
    
    var segmentViews: [UIView]!
    
    func setUpViews() {
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
               
        ingrediantsList = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
               
        ingrediantsList.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCell)
        ingrediantsList.delegate = self
        ingrediantsList.dataSource = self
        ingrediantsList.isScrollEnabled = true
        ingrediantsList.isUserInteractionEnabled = true
        ingrediantsList.layer.cornerRadius = 5
        
        segmentViews = [UIView]()
        segmentViews.append(ingrediantsList)
        segmentViews.append(relatedProductInfoSection)
        view.addSubview(productNameSection)
        view.addSubview(productImageSection)
        
        
        for v in segmentViews {
            view.addSubview(v)
            v.layer.cornerRadius = 10
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.bringSubviewToFront(segmentViews[0])
        
        view.addSubview(segmentContr)
        
        productImageSection.translatesAutoresizingMaskIntoConstraints = false
        productNameSection.translatesAutoresizingMaskIntoConstraints = false
        segmentContr.translatesAutoresizingMaskIntoConstraints = false
        
        productNameSection.faveButton.addTarget(self, action: #selector(handlefave), for: .touchUpInside)
        
    }
    
    var acctOptions = ["Flour","Eggs","Milk","Almond Extract","Salt","Syrup","a good time"]
    
    func setUpProductButtons() {
        //MARK: how to add button interaction
        
        productNameSection.productNameAndBackButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    func setupProductLayoutContstraints() {

        //MARK: Constraints
        NSLayoutConstraint.activate([
            
        productNameSection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        productNameSection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        productNameSection.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
        productNameSection.heightAnchor.constraint(equalToConstant: 50),

        productImageSection.topAnchor.constraint(equalTo: productNameSection.bottomAnchor, constant: 10),
        productImageSection.centerXAnchor.constraint(equalTo: productNameSection.centerXAnchor),
        
        segmentContr.topAnchor.constraint(equalTo: productImageSection.bottomAnchor, constant: 10),
        segmentContr.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        segmentContr.widthAnchor.constraint(equalTo: relatedProductInfoSection.widthAnchor),
        segmentContr.heightAnchor.constraint(equalToConstant: 25),
        
        relatedProductInfoSection.topAnchor.constraint(equalTo: segmentContr.bottomAnchor, constant: 5),
        relatedProductInfoSection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        relatedProductInfoSection.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
        relatedProductInfoSection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        ingrediantsList.topAnchor.constraint(equalTo: relatedProductInfoSection.topAnchor),
        ingrediantsList.centerXAnchor.constraint(equalTo: relatedProductInfoSection.centerXAnchor),
        ingrediantsList.widthAnchor.constraint(equalTo: relatedProductInfoSection.widthAnchor),
        ingrediantsList.bottomAnchor.constraint(equalTo: relatedProductInfoSection.bottomAnchor),

        ])
            
    }
    
    let tableViewCell = "test"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acctOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let friends = tableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath)
        friends.backgroundColor = UIColor.white
        friends.textLabel!.textColor = UIColor.ademBlue
        friends.textLabel!.text = acctOptions[indexPath.row]
        
        if indexPath.row == 4 {
            friends.backgroundColor = UIColor.ademRed
            friends.textLabel!.textColor = UIColor.white
        }
        
        return friends
    }
    
    
    //MARK: Swipe actions
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->   UISwipeActionsConfiguration? {
        //If the product in not in the list and they are searching they can swipe to the left to add it to their list
      // Get current state from data source https://useyourloaf.com/blog/table-swipe-actions/
        let checkedAsInBasket = UIContextualAction(style: .normal, title: "Add") { (contextualAction, view, boolValue) in
            boolValue(true) // pass true if you want the handler to allow the action
            print("User has added the product to their basket in the store")
        }
        
        checkedAsInBasket.backgroundColor = UIColor.ademGreen
        
        let swipeActions = UISwipeActionsConfiguration(actions: [checkedAsInBasket])

        return swipeActions
    }
}


