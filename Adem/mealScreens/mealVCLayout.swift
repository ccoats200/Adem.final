//
//  mealVCLayout.swift
//  Adem
//
//  Created by Coleman Coats on 2/26/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import UIKit
import Firebase
import Lottie

protocol mealSelectionCellDelegate {
    func itemCell(cellTapped: IndexPath)
}

class mealVCLayout: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //MEAL info
    
    //MARK: View set up
    var productNameSection = mealsViews()
    var productImageSection = mealImageViews()
    var relatedProductInfoSection = mealsBottomViews()
    var ingrediantsList: UITableView!
    var animationView: AnimationView?
    
    let tableViewCell = "test"
    var acctOptions = ["Flour","Eggs","Milk","Almond Extract","Salt","Syrup","a good"]
    //MARK: Pass data
    //Delegate to pass data
    var delegate: mealSelectionCellDelegate?
    var mealInfo: mealClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.ademBlue
        //testing this
        
        
        
        setUpViews()
        setUpProductButtons()
        setupProductLayoutContstraints()

        self.dismiss(animated: true, completion: nil)
    }
    
    //accept data
    class func detailViewControllerForProduct(_ meal: mealClass) -> UIViewController {
        let viewController = self.init()
        if let detailViewController = viewController as? mealVCLayout {
            detailViewController.mealInfo = meal
        }
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        //Top elements
        productNameSection.productNameAndBackButton.setTitle("\(mealInfo!.mealName)", for: .normal)
        productNameSection.faveButton.isSelected = mealInfo.likedMeal
        //Image elements
        productImageSection.productImage.image = UIImage(named: "\(mealInfo!.mealImage)")
        relatedProductInfoSection.productDescription.text = mealInfo.mealDescription
        

        }

    //MARK: Button engagement
    @objc func handleFacts() {
        //let signUpInfo = circleTest()
        let signUpInfo = Meals()
        self.present(signUpInfo, animated: true)
    }
 
    //product Button
    @objc func handleBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNutritionLabel() {
        let productScreen = nutritionLabelVC()
        productScreen.hidesBottomBarWhenPushed = true
        self.present(productScreen, animated: true, completion: nil)
    }
    
    @objc func handlefave(sender: UIButton) {
        //FIXME: kinda works but is really janky
        if mealInfo.likedMeal == true {
            productNameSection.faveButton.isSelected = false
            userfirebaseMeals.document(mealInfo.mealName).updateData([
                
                "likedMeal": false,

            ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
        } else {
        
            animationView = .init(name: "heartsGif")
            animationView?.frame = view.bounds
            animationView?.animationSpeed = 0.5
            view.addSubview(animationView!)
            animationView?.play()
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                self.animationView?.removeFromSuperview()
                self.productNameSection.faveButton.isSelected = true
            }
            //Save to meal
            userfirebaseMeals.document(mealInfo.mealName).updateData([
                
                "likedMeal": true,

            ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            
            
        }
    }
    
    func fadeOut(withDuration duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.animationView?.alpha = 0.0
        })
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealInfo.mealIngrediants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let friends = tableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath)
        friends.backgroundColor = UIColor.white
        friends.textLabel!.textColor = UIColor.ademBlue
        friends.textLabel!.text = mealInfo.mealIngrediants[indexPath.row]
        
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


extension mealVCLayout: mealSelectionCellDelegate {
    
    func product(forIndexPath: IndexPath) -> mealClass {
        var product: mealClass!
        product = arrayofMeals[forIndexPath.item]
        return product
    }
    
    
    func itemCell(cellTapped: IndexPath) {
        let cellTap = arrayofMeals[cellTapped.row]
    }
}
