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

class listProductVCLayout: UIViewController {
    //MARK: ALL ITEMS NEED PRIVATE
    
    //Delegate to pass data
    var product: fireStoreDataClass!
    let storage = Storage.storage()
    
    //MARK: View set up
    var productNameSection = productViews()
    var productImageSection = productImageViews()
    var relatedProductInfoSection = productInfoViews()
    var nutrition = nutritionLabelVC()
    //If not in cart use quantity as add button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.ademBlue
        
        //MARK: Needed to pass the item
        mealsPage.mealDelegate = self
        //MARK: This will need to change be a search or search and add the first result
        relatedProductInfoSection.productDelegate = self
        
        setUpViews()
        setUpProductButtons()
        setupProductLayoutContstraints()
        
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: meals pass
   
    //MARK: Needed for sending to the right item selected
    class func detailViewControllerForProduct(_ product: fireStoreDataClass) -> UIViewController {
        let viewController = self.init()
        if let detailViewController = viewController as? listProductVCLayout {
            detailViewController.product = product
        }
        return viewController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Top elements
        productNameSection.productNameAndBackButton.setTitle(product!.productName, for: .normal)
        productNameSection.priceLabel.text = "$\(product!.productPrice)"
        
        //FIXME: Why wont this pass to the next screen?
        //This will be the way to get nutrition info
        nutritionPage.nutritionIngredientsTextView.text = "\(product!.productIngredientList ?? "We're sorry this product doesn't currently have nutrition information. We are working on ensuring accurate nutrition information for all products.")"
        if product!.nutrition?.nutrients == nil {
            arrayofNutrients.append(nutrients(name: "Not Available", title: "Not Available", amount: 0.00, unit: "N/A", percentOfDailyNeeds: 0.0))
        } else {
            for i in product!.nutrition!.nutrients {
                arrayofNutrients.append(i)
            }
        }
        
        //Image elements
        //MARK this this so the data can be used
        if product.productImageImage == nil {
            productImageSection.productImage.image = UIImage(named: product!.productImage)
        } else {
            productImageSection.productImage.image = UIImage(data: product!.productImageImage!)
        }
        
        //Detail elements
        relatedProductInfoSection.productDescription.text = "\(product!.productDescription)"
        relatedProductInfoSection.listQuantity.text = "Qty: \(product!.productQuantity)"

        NewProduct()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arrayofNutrients.removeAll()
    }
    
    func NewProduct() {
        
        //MARK: needs to indicate that the item is added
        switch self.product.productList {
        case true:
            self.relatedProductInfoSection.addToPantry.setBackgroundImage(UIImage(named: "greenAddButton"), for: .normal)
            self.productImageSection.listButtonBacking.isHidden = true
        case false:
            switch self.product.productPantry {
            case true:
                self.productImageSection.listButtonBacking.isHidden = true
                self.relatedProductInfoSection.addToPantry.setBackgroundImage(UIImage(named: "addButton"), for: .normal)
            case false:
                self.relatedProductInfoSection.addToPantry.isHidden = true
            default:
                print("good")
            }
        default:
            print("good")
        }
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
//        let productScreen = nutritionLabelVC()
//        productScreen.hidesBottomBarWhenPushed = true
//        self.present(productScreen, animated: true, completion: nil)
        print("testi")
    }
    
    let mealsPage = mealsSegment()
    let statsPage = statsSegment()
    let nutritionPage = nutritionLabelVC()
    var segmentViews: [UIView]!
    
    @objc func switchViewAction(_ segmentContr: UISegmentedControl) {
        //https://www.tutorialspoint.com/how-to-programmatically-add-a-uisegmentedcontrol-to-a-container-view
        
        self.view.bringSubviewToFront(segmentViews[segmentContr.selectedSegmentIndex])
    }
    
    //MARK: Button engagement
    let segmentContr: UISegmentedControl = {
        let items = ["Description", "Meals", "Nutrition"]//, "Stats"]
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
    
    
    
    func setUpViews() {
        
        //Add back stats when its time
        segmentViews = [relatedProductInfoSection, mealsPage, nutritionPage]//,statsPage]

        view.addSubview(productNameSection)
        view.addSubview(productImageSection)
        
        for viewSegments in segmentViews {
            view.addSubview(viewSegments)
            viewSegments.layer.cornerRadius = 10
            viewSegments.translatesAutoresizingMaskIntoConstraints = false
        }
        view.bringSubviewToFront(segmentViews[0])
        view.addSubview(segmentContr)
        productImageSection.translatesAutoresizingMaskIntoConstraints = false
        productNameSection.translatesAutoresizingMaskIntoConstraints = false
        segmentContr.translatesAutoresizingMaskIntoConstraints = false
        relatedProductInfoSection.listQuantityButon.addTarget(self, action: #selector(updateQuantity), for: .touchDown)
        relatedProductInfoSection.addToPantry.addTarget(self, action: #selector(addToOpposite), for: .touchUpInside)
        productImageSection.listButton.addTarget(self, action: #selector(addToAnything), for: .touchUpInside)
    }
    
    @objc func addToAnything() {
        //FIXME: This cant be an index
        let productToAdd = arrayofSearchEngaged[0]
        let alertController = UIAlertController(title: nil, message: "Where do you want this?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Add to List", style: .default, handler: { action -> Void in
            //Code to add to list
            
            if (arrayofProducts.contains { $0.productUPC == productToAdd.productUPC}) {
                self.updateQuantitySearch(location: "List")
            } else {
                productToAdd.productList = true
                self.addToFirebase(dabest: productToAdd)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Add to Pantry", style: .default, handler: { action -> Void in
            //Code to add to Pantry
            
            if (arrayofPantry.contains { $0.productUPC == productToAdd.productUPC}) {
                self.updateQuantitySearch(location: "Pantry")
            } else {
                productToAdd.productPantry = true
                self.addToFirebase(dabest: productToAdd)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action -> Void in
            //Delay on sign out button
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func addToFirebase(dabest: fireStoreDataClass) {
        do {
            let _ = try listfirebaseProducts.document("\(currentListID!)").collection("list").addDocument(from: dabest)
          }
          catch {
            print(error)
          }
    }
    
    @objc func updateQuantitySearch(location: String) {
        let sorted = actionTest.sorted {$0.key > $1.key}
        let actionSheetController: UIAlertController = UIAlertController(title: "This Item is Already in your \(location)", message: nil, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Done", style: .cancel) { action -> Void in }
        
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)

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
                if arrayofProducts.contains(where: { $0.fireBId == self.product.fireBId}) {
                    self.relatedProductInfoSection.listQuantity.text = "Qty: \(actions.value)"
                    self.updateProductQuantityValue(id: self.product.fireBId!, quantity: actions.value)
                } else if arrayofPantry.contains(where: { $0.fireBId == self.product.fireBId}) {
                    self.relatedProductInfoSection.listQuantity.text = "Qty: \(actions.value)"
                    self.updateProductQuantityValue(id: self.product.fireBId!, quantity: actions.value)
                }
            }
            actionSheetController.addAction(quantity)
        }
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)

    }
    
    @objc func addToOpposite() {
        
        //FIXME: Might be able to delete the commeentted code below for this
        switch self.product.productList {
        case true:
            self.updateProductLocationValues(indexPath: self.product.fireBId!, pantry: true, list: false)
            self.addTimeStamp(id: self.product.fireBId!, action: engagements.pantry.rawValue)
        case false:
            switch self.product.productPantry {
            case true:
                let find = self.product.fireBId!
                let actionTest = [1: 100,2: 75,3: 50,4 : 25,5: 0]
                let sorted = actionTest.sorted {$0.key < $1.key}
                let actionSheetController: UIAlertController = UIAlertController(title: "How Much Was Left?", message: "This helps us learn how to help you!", preferredStyle: .actionSheet)
                let cancelAction: UIAlertAction = UIAlertAction(title: "Not Done Yet", style: .cancel) { action -> Void in }
                for actions in sorted {
                    let quantity: UIAlertAction = UIAlertAction(title: "\(actions.value)%", style: .default) { action -> Void in
                        self.addWasteAmount(id: find, amount: actions.value)
                        self.updateProductLocationValues(indexPath: find, pantry: false, list: true)
                        self.addTimeStamp(id: find, action: engagements.list.rawValue)
                    }
                    actionSheetController.addAction(quantity)
                }
                actionSheetController.addAction(cancelAction)
                self.present(actionSheetController, animated: true, completion: nil)
            default:
                print("quant updated")
            }
        default:
            print("quant updated in list")
        }
        
        
//        if arrayofProducts.contains(where: { $0.fireBId == self.product.fireBId}) {
//            self.updateProductLocationValues(indexPath: self.product.fireBId!, pantry: true, list: false)
//            self.addTimeStamp(id: self.product.fireBId!, action: engagements.pantry.rawValue)
//                //Might dismiss here
//            //self.dismiss(animated: true, completion: nil)
//        } else if arrayofPantry.contains(where: { $0.fireBId == self.product.fireBId}) {
//            let find = self.product.fireBId!
//            let actionTest = [1: "100%",2: "75%",3: "50%",4 :"25%",5: "0%"]
//            let sorted = actionTest.sorted {$0.key < $1.key}
//            let actionSheetController: UIAlertController = UIAlertController(title: "How Much Was Left?", message: "This helps us learn how to help you!", preferredStyle: .actionSheet)
//            let cancelAction: UIAlertAction = UIAlertAction(title: "Not Done Yet", style: .cancel) { action -> Void in }
//            for actions in sorted {
//                let quantity: UIAlertAction = UIAlertAction(title: String(actions.value), style: .default) { action -> Void in
//                    self.addWasteAmount(id: find, amount: actions.value)
//                    self.updateProductLocationValues(indexPath: find, pantry: false, list: true)
//                    self.addTimeStamp(id: find, action: engagements.list.rawValue)
//                }
//                actionSheetController.addAction(quantity)
//            }
//            actionSheetController.addAction(cancelAction)
//            self.present(actionSheetController, animated: true, completion: nil)
//        }
    }
    
    func setUpProductButtons() {
        //MARK: how to add button interaction
        productNameSection.productNameAndBackButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        productNameSection.nutritionButton.addTarget(self, action: #selector(handleNutritionLabel), for: .touchUpInside)
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
            productImageSection.widthAnchor.constraint(equalTo: view.widthAnchor),
        
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
            
        
            nutritionPage.heightAnchor.constraint(equalTo: relatedProductInfoSection.heightAnchor),
            nutritionPage.centerXAnchor.constraint(equalTo: relatedProductInfoSection.centerXAnchor),
            nutritionPage.widthAnchor.constraint(equalTo: relatedProductInfoSection.widthAnchor),
            nutritionPage.centerYAnchor.constraint(equalTo: relatedProductInfoSection.centerYAnchor),
        ])
    }
}

extension listProductVCLayout: passMeal, passProduct {
    
    func relatedProductCollectionView(collectioncell: UICollectionViewCell?, IndexPath: IndexPath) {
        let selectedMeal: fireStoreDataClass!
        selectedMeal = similarProduct(forIndexPath: IndexPath)
        let detail = listProductVCLayout.detailViewControllerForProduct(selectedMeal)
        self.present(detail, animated: true, completion: nil)
    }
   
    func nutritionCollectionView(collectioncell: UICollectionViewCell?, IndexPath: IndexPath) {
        let selectedMeal: fireStoreDataClass!
        selectedMeal = similarProduct(forIndexPath: IndexPath)
        let detail = listProductVCLayout.detailViewControllerForProduct(selectedMeal)
        self.present(detail, animated: true, completion: nil)
    }
    
    func relatedMealCollectionView(collectioncell: UICollectionViewCell?, IndexPath: IndexPath) {
        let selectedMeal: mealClass!
        selectedMeal = mealYouCanMake(forIndexPath: IndexPath)
        let detail = mealVCLayout.detailViewControllerForProduct(selectedMeal)
        self.present(detail, animated: true, completion: nil)
    }
    
    func similarProduct(forIndexPath: IndexPath) -> fireStoreDataClass {
        var product: fireStoreDataClass!
        product = arrayofProducts[forIndexPath.item]
        return product
    }
    
    func mealYouCanMake(forIndexPath: IndexPath) -> mealClass {
        var product: mealClass!
        product = arrayofMeals[forIndexPath.item]
        return product
    }
}
