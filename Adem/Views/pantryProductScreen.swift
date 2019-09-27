//
//  pantryProductScreen.swift
//  Adem
//
//  Created by Coleman Coats on 8/20/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class pantryProductVCLayout: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.ademGreen
        
        
        setupProductImageAttributes()
        //addSwipe()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        
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
    
  
    
    let imageMatting: UIView = {
        let lightColor = UIView()
        lightColor.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        lightColor.translatesAutoresizingMaskIntoConstraints = false
        lightColor.layer.masksToBounds = true
        lightColor.widthAnchor.constraint(equalToConstant: 300).isActive = true
        lightColor.heightAnchor.constraint(equalToConstant: 300).isActive = true
        lightColor.layer.cornerRadius = 150
        return lightColor
    }()
    
    let productImage: UIImageView = {
        let productImageDesign = UIImageView()
        productImageDesign.image = UIImage(named: "bread")
        productImageDesign.contentMode = .center
        productImageDesign.contentMode = .scaleAspectFill
        productImageDesign.clipsToBounds = true
        productImageDesign.layer.masksToBounds = true
        productImageDesign.layer.cornerRadius = 25
        productImageDesign.layer.borderWidth = 1
        productImageDesign.layer.borderColor = UIColor.white.cgColor
        productImageDesign.translatesAutoresizingMaskIntoConstraints = false
        productImageDesign.widthAnchor.constraint(equalToConstant: 200).isActive = true
        productImageDesign.heightAnchor.constraint(equalToConstant: 200).isActive = true //125 also looks good
        print("Created Image for the product image in the details VC")
        return productImageDesign
    }()
    
    let alwaysNotify: UIButton = {
        let notify = UIButton()
        let notifyImage = UIImage(named: nutritionFacts)
        notify.setImage(notifyImage, for: .normal)
        notify.translatesAutoresizingMaskIntoConstraints = false
        notify.contentMode = .scaleAspectFit
        //notify.backgroundColor = UIColor.blue
        return notify
    }()

    lazy var healthfFacts: UIButton = {
        let facts = UIButton()
        let image = UIImage(named: "Vegan")
        //facts.backgroundImage(for: .normal)
        facts.setImage(image, for: .normal)
        facts.translatesAutoresizingMaskIntoConstraints = false
        facts.contentMode = .scaleAspectFit
        facts.addTarget(self, action: #selector(handleFacts), for: .touchUpInside)
        return facts
    }()
    
    //product Button
    @objc func handleFacts() {
        //let signUpInfo = ()
        //self.present(signUpInfo, animated: true)
        print("went to new page")
    }
    
    
    var test: UICollectionView!
    
    let productInfoHolder: UIView = {
        let productInfo = UIView()
        productInfo.backgroundColor = UIColor.white
        productInfo.translatesAutoresizingMaskIntoConstraints = false
        productInfo.layer.cornerRadius = 5
        productInfo.layer.masksToBounds = true
        return productInfo
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! pantryProductFirstCell
        return productCell
    }
    
    let calLabel: UILabel = {
        let calories = UILabel()
        //calories.backgroundColor = UIColor.blue
        calories.translatesAutoresizingMaskIntoConstraints = false
        calories.layer.cornerRadius = 5
        calories.layer.masksToBounds = true
        calories.text = "Calories: "
        return calories
    }()
    
    let priceLabel: UILabel = {
        let cost = 2.99
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.layer.cornerRadius = 5
        price.layer.masksToBounds = true
        price.text = "$\(cost)"
        price.font = UIFont.boldSystemFont(ofSize: 16)
        return price
    }()
    
    lazy var productNameAndBackButton: UIButton = {
        let back = UIButton(type: .system)
        back.setTitle("Bread", for: .normal)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.setTitleColor(UIColor.white, for: .normal)
        back.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        back.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        back.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        return back
        
    }()
    
    //product Button
    @objc func handleBack() {
        self.dismiss(animated: true, completion: nil)
        print("went back to previous page")
    }
    
    private let pantryPageControl: UIPageControl = {
       let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = UIColor.ademGreen
        pc.pageIndicatorTintColor = UIColor.ademBlue
        return pc
    }()
    
    let cellID = "cell"
    func setupProductImageAttributes() {
        
        
        let layouts: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let pCollectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layouts)
        
        view.addSubview(productNameAndBackButton)
        view.addSubview(imageMatting)
        view.addSubview(productInfoHolder)
        view.addSubview(productImage)
        //Adding subviews
        //scrolling.addSubview(alwaysNotify)
        //scrolling.addSubview(healthfFacts)
        
        view.addSubview(calLabel)
        view.addSubview(priceLabel)
        view.addSubview(pantryPageControl)
    
        //collectionView
        pCollectionView.dataSource = self
        pCollectionView.delegate = self
        pCollectionView.register(pantryProductFirstCell.self, forCellWithReuseIdentifier: cellID)
        pCollectionView.backgroundColor = UIColor.white
        pCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pCollectionView.clipsToBounds = true
        pCollectionView.layer.masksToBounds = true
        pCollectionView.backgroundColor = UIColor.blue
        pCollectionView.isScrollEnabled = true
        self.view.addSubview(pCollectionView)
        
        
        
        productNameAndBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        productNameAndBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        productNameAndBackButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        productNameAndBackButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        productNameAndBackButton.layer.cornerRadius = 20
        
        //Product Image matting
        imageMatting.topAnchor.constraint(equalTo: productNameAndBackButton.bottomAnchor, constant: 10).isActive = true
        imageMatting.centerXAnchor.constraint(equalTo: productNameAndBackButton.centerXAnchor).isActive = true
        
        //Prodcut Image
        productImage.centerXAnchor.constraint(equalTo: imageMatting.centerXAnchor).isActive = true
        productImage.centerYAnchor.constraint(equalTo: imageMatting.centerYAnchor).isActive = true

        
        let healthInfoStackView = UIStackView(arrangedSubviews: [healthfFacts, pantryPageControl, alwaysNotify])
        healthInfoStackView.contentMode = .scaleAspectFit
        healthInfoStackView.spacing = 5
        healthInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        healthInfoStackView.distribution = .fillEqually
        
        
        view.addSubview(healthInfoStackView)
        
        productInfoHolder.topAnchor.constraint(equalTo: imageMatting.bottomAnchor, constant: 15).isActive = true
        productInfoHolder.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        productInfoHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25).isActive = true
        productInfoHolder.heightAnchor.constraint(equalToConstant: 350).isActive = true
        productInfoHolder.layer.cornerRadius = 10
        
        pCollectionView.centerXAnchor.constraint(equalTo: productInfoHolder.centerXAnchor).isActive = true
        pCollectionView.topAnchor.constraint(equalTo: productInfoHolder.topAnchor).isActive = true
        pCollectionView.widthAnchor.constraint(equalTo: productInfoHolder.widthAnchor).isActive = true
        pCollectionView.bottomAnchor.constraint(equalTo: productInfoHolder.bottomAnchor, constant: -30).isActive = true
        pCollectionView.layer.cornerRadius = 10

        
        healthInfoStackView.topAnchor.constraint(equalTo: pCollectionView.bottomAnchor, constant: 5).isActive = true
        healthInfoStackView.centerXAnchor.constraint(equalTo: productInfoHolder.centerXAnchor).isActive = true
        //healthInfoStackView.trailingAnchor.constraint(equalTo: productInfoHolder.trailingAnchor, constant: -5).isActive = true
        healthInfoStackView.widthAnchor.constraint(equalTo: productInfoHolder.widthAnchor).isActive = true
        healthInfoStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        /*
        //calories
        calLabel.topAnchor.constraint(equalTo: alwaysNotify.bottomAnchor, constant: 5).isActive = true
        calLabel.leftAnchor.constraint(equalTo: productInfoHolder.leftAnchor, constant: 12).isActive = true
        calLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        calLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        //calories
        priceLabel.topAnchor.constraint(equalTo: productInfoHolder.topAnchor, constant: 5).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: productInfoHolder.rightAnchor, constant: 10).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
*/
    }
}
