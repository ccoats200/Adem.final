//
//  listProduct.swift
//  Adem
//
//  Created by Coleman Coats on 1/6/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestoreSwift

protocol ItemTableViewCellDelegate {
    func itemCell(cellTapped: IndexPath)
}

class listProductVCLayout: UIViewController {
    
    //Delegate to pass data
    var delegate: ItemTableViewCellDelegate?
    var product: fireStoreDataClass!
    var meal: mealClass!
    
    //MARK: View set up
    var productNameSection = productViews()
    var productImageSection = productImageViews()
    var relatedProductInfoSection = productInfoViews()
    //If not in cart use quantity as add button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.ademBlue
        
        
        setUpViews()
        setUpProductButtons()
        setupProductLayoutContstraints()
        
        self.dismiss(animated: true, completion: nil)
    }
    
   
    //Needed for sending to the right item selected
    class func detailViewControllerForProduct(_ product: fireStoreDataClass) -> UIViewController {
        let viewController = self.init()
        if let detailViewController = viewController as? listProductVCLayout {
            detailViewController.product = product
        }
        return viewController
    }
    
    //might need to move to the nxt screen
    class func pallatteTested(_ product: mealClass) -> UIViewController {
        let viewController = self.init()
        if let detailViewController = viewController as? listProductVCLayout {
            detailViewController.meal = product
        }
        return viewController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Top elements
        productNameSection.productNameAndBackButton.setTitle(product!.productName, for: .normal)
        productNameSection.priceLabel.text = "$ \(product!.productPrice)"
        //Image elements
        
        //Detail elements
        relatedProductInfoSection.productDescription.text = "\(product!.productDescription)"
        relatedProductInfoSection.listQuantity.text = "Qty: \(product!.productQuantity)"
        
        //statsPage.collectionView(statsPage.stats, cellForItemAt: <#T##IndexPath#>)
        
        //Stats elements
        //This might be like the above
//        statsPage.collectionView(statsPage.stats, cellForItemAt: IndexPath).
        
    }
    
    func assignCollec() {
        
        //statsPage.collectionView(statsPage.stats, cellForItemAt: forIndexPath)
    }


    //MARK: Button engagement
    //product Button
    @objc func handleFacts() {
        let signUpInfo = Meals()
        self.present(signUpInfo, animated: true)
        print("went to new page")
    }
 
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
    
    @objc func switchViewAction(_ segmentContr: UISegmentedControl) {
        self.view.bringSubviewToFront(segmentViews[segmentContr.selectedSegmentIndex])
    }
    //MARK: Button engagement
    
    let segmentContr: UISegmentedControl = {
        let items = ["Description", "Meals"]//, "Stats"]
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
    
    
    
    
    let mealsPage = mealsSegment()
    let statsPage = statsSegment()
    var segmentViews: [UIView]!
    
    func setUpViews() {
        
        segmentViews = [relatedProductInfoSection,mealsPage]//,statsPage]

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
        
        relatedProductInfoSection.listQuantityButon.addTarget(self, action: #selector(updateQuantity), for: .touchDown)
    }

    //MARK: Quantity
    let actionTest = [1: 1,2: 2,3: 3,4 :4,5: 5]
    @objc func updateQuantity() {
       
        let sorted = actionTest.sorted {$0.key > $1.key}
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        for actions in sorted {
            
            let quantity: UIAlertAction = UIAlertAction(title: String(actions.value), style: .default) { action -> Void in
                
                //kinda works don't trust that much
                for i in arrayofProducts where i.id == self.product!.id {
                    self.relatedProductInfoSection.listQuantity.text = "Qty: \(actions.value)"
                    self.updateProductQuantityValue(id: i.id!, quantity: actions.value)
                }
            }
            actionSheetController.addAction(quantity)
        }
        
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
//        updateQuantity()
//        let updateQuantity = quantityAlert()
//        updateQuantity.modalPresentationStyle = UIModalPresentationStyle.formSheet
//        self.present(updateQuantity, animated: true, completion: nil)

        
    }
    
    
/*
    func updateQuantity() {
        
        let sorted = actionTest.sorted {$0.key > $1.key}
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        for actions in sorted {
            
            let quantity: UIAlertAction = UIAlertAction(title: String(actions.value), style: .default) { action -> Void in
                
                //kinda works don't trust that much
                for i in arrayofProducts where i.id == self.productNameSection.idlabel.text {
                    //below was outside of for statement
                    self.relatedProductInfoSection.listQuantity.text = "Qty: \(actions.value)"
                    self.updateProductQuantityValue(id: i.id!, quantity: actions.value)
                }
            }
            actionSheetController.addAction(quantity)
        }
        
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }

    */
    
    func setUpProductButtons() {
        //MARK: how to add button interaction
        
        productNameSection.productNameAndBackButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        relatedProductInfoSection.nutritionLabel.addTarget(self, action: #selector(handleNutritionLabel), for: .touchUpInside)
        
        
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
        
        mealsPage.topAnchor.constraint(equalTo: relatedProductInfoSection.topAnchor),
        mealsPage.centerXAnchor.constraint(equalTo: relatedProductInfoSection.centerXAnchor),
        mealsPage.widthAnchor.constraint(equalTo: relatedProductInfoSection.widthAnchor),
        mealsPage.bottomAnchor.constraint(equalTo: relatedProductInfoSection.bottomAnchor),
        
//        statsPage.heightAnchor.constraint(equalTo: relatedProductInfoSection.heightAnchor),
//        statsPage.centerXAnchor.constraint(equalTo: relatedProductInfoSection.centerXAnchor),
//        statsPage.widthAnchor.constraint(equalTo: relatedProductInfoSection.widthAnchor),
//        statsPage.centerYAnchor.constraint(equalTo: relatedProductInfoSection.centerYAnchor),
        ])
    }
}



extension listProductVCLayout: ItemTableViewCellDelegate {
    func itemCell(cellTapped: IndexPath) {
        let cellTap = arrayofProducts[cellTapped.row]
    }
    
    func mealsView(collectioncell: UICollectionViewCell?, IndexPath: IndexPath) {
        //https://slicode.com/collectionview-inside-tableview-cell-part-3/

        //FIXME: This is where I need to pass the info
        let selectedMeal: mealClass!
        selectedMeal = relatedProductInfoSection.relatedMeal(forIndexPath: IndexPath)
        let detail = listProductVCLayout.pallatteTested(selectedMeal)
        //detail.modalPresentationStyle = .overFullScreen
        self.present(detail, animated: true, completion: nil)
    }
}

