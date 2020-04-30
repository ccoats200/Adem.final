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

class listProductVCLayout: UIViewController {
    
    //MARK: View set up
    var productNameSection = productViews()
    var productImageSection = productImageViews()
    var relatedProductInfoSection = productInfoViews()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.ademBlue
        
        setUpViews()
        setUpProductButtons()
        setupProductLayoutContstraints()
        
        //let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
        //self.view.addGestureRecognizer(panGestureRecognizer)
        handleitems()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    @objc func panGestureRecognizerAction(_ gesture: UIPanGestureRecognizer) {
        
        let touchPoint = gesture.location(in: self.view?.window)
        
        if gesture.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if gesture.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if gesture.state == UIGestureRecognizer.State.ended || gesture.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
        print(gesture)
    }

//    let c = db.collection("groceryProducts").getDocuments() { (snapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//            for document in snapshot!.documents {
//                let productName = document.get("productName")
//                let docId = document.documentID
//                for (key, value) in self.firebaseDocuments {
//                    productsListViewLayout.textLabel?.text = key
//                }
//            }
//        }
//    }
//
    
    func handleitems() {
    var handle = firebaseAuth.addStateDidChangeListener { (auth, user) in
                          
        let known = db.collection("Users").document(user!.uid).collection("public").document("products").collection("List")
        known.whereField("productList", isEqualTo: true).getDocuments { (snapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in snapshot!.documents {
    
                            var gItem = document {
                                didSet {
                                    self.productNameSection.productNameAndBackButton.setTitle((gItem.get("productName") as! String), for: .normal)
                                    self.productNameSection.priceLabel.text = "$\(gItem.get("productPrice") ?? nil)"
                                    self.productImageSection.productImage.image = UIImage(named: (gItem.get("productImage"))! as! String)
                                    self.relatedProductInfoSection.productDescription.text = gItem.get("productDescription") as! String
                                    self.relatedProductInfoSection.listQuantity.text = "Qty: \(gItem.get("productQuantity") ?? 1)"
                                          print("set")
                            }
                            }
                        }
                    }
                }
    }
    }
//    var productVariableElements = productsMaster {
//            didSet {
//                productNameSection.productNameAndBackButton.setTitle((gItem.getDocuments()), for: .normal)
//                productNameSection.priceLabel.text = "$\(gItem.productPrice ?? nil)"
//                productImageSection.productImage.image = UIImage(named: (gItem.productImage)!)
//                relatedProductInfoSection.productDescription.text = gItem.productDescription
//                relatedProductInfoSection.listQuantity.text = "Qty: \(gItem.productQuantity ?? 1)"
//                print("set")
//            }
//        }
    
    //MARK: Button engagement
    //product Button
    @objc func handleFacts() {
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

    

    let segmentContr: UISegmentedControl = {
        let items = ["Description", "Meals", "Stats"]
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
    
    let mealsPage = mealsSegment()
    let statsPage = statsSegment()
    var segmentViews: [UIView]!
    
    func setUpViews() {
        
        segmentViews = [relatedProductInfoSection,mealsPage,statsPage]

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
        
        relatedProductInfoSection.listQuantityButon.addTarget(self, action: #selector(plz), for: .touchDown)
    }

    
    @objc func plz() {
       
        incorrectInformationAlert(title: "Login Failed", message: "It doesn't work like that...")
//        let updateQuantity = quantityAlert()
//        updateQuantity.modalPresentationStyle = UIModalPresentationStyle.formSheet
//        self.present(updateQuantity, animated: true, completion: nil)

        
    }
    
    //MARK: Quantity
    let actionTest = [1: "1",2: "2",3: "3",4 :"4",5: "5"]
    
    
    
    func incorrectInformationAlert(title: String, message: String) {
        
        let sorted = actionTest.sorted {$0.key > $1.key}
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        for actions in sorted {
            
            let quantity: UIAlertAction = UIAlertAction(title: actions.value, style: .default) { action -> Void in
                self.relatedProductInfoSection.listQuantity.text = "Qty: \(actions.value)"
                print(actions.value)
            }
            actionSheetController.addAction(quantity)
        }
        
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
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
        
        statsPage.heightAnchor.constraint(equalTo: relatedProductInfoSection.heightAnchor),
        statsPage.centerXAnchor.constraint(equalTo: relatedProductInfoSection.centerXAnchor),
        statsPage.widthAnchor.constraint(equalTo: relatedProductInfoSection.widthAnchor),
        statsPage.centerYAnchor.constraint(equalTo: relatedProductInfoSection.centerYAnchor),
        
        ])
            
    }
}


