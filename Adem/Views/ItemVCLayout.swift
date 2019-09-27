//
//  ItemVCLayout.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class productVCLayout: UIViewController {
    
    let atTop = CGFloat(0.0)
    var likeReallyAtTop = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrolling.isScrollEnabled = true
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.ademGreen
        
        view.addSubview(scrolling)
        
        setUpScrollView()
        addSwipe()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        
        self.dismiss(animated: true, completion: nil)
        
        if scrolling.contentOffset.y == atTop && likeReallyAtTop {
            scrolling.isScrollEnabled = false
            scrolling.addGestureRecognizer(panGestureRecognizer)
            print("swiper no swipping")
        }
    }
    
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        print("\(sender.direction) is where swiper is going")
        if sender.direction == .down {
            likeReallyAtTop = true
        }
        else {
            likeReallyAtTop = false
        }
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
            if touchPoint.y - initialTouchPoint.y > 300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
        print(gesture)
    }
    
    let scrolling: UIScrollView = {
        let scrollable = UIScrollView()
        scrollable.backgroundColor = UIColor.clear
        scrollable.translatesAutoresizingMaskIntoConstraints = false
        scrollable.contentSize.height = 1000
        scrollable.isPagingEnabled = true
        return scrollable
    }()
    
    
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
        productImageDesign.image = UIImage(named: "blueBerry")
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
        let signUpInfo = login()
        self.present(signUpInfo, animated: true)
        print("went to new page")
    }
    
    let productInfoHolder: UIView = {
        let productInfo = UIView()
        productInfo.backgroundColor = UIColor.white
        productInfo.translatesAutoresizingMaskIntoConstraints = false
        productInfo.layer.cornerRadius = 5
        productInfo.layer.masksToBounds = true
        return productInfo
    }()
    
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
    
    
    let NurtritionLabel: UIView = {
        let NutLbl = UITextView()
        NutLbl.font = UIFont(name: "Helvetica", size: 15)
        NutLbl.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 253)
        NutLbl.isEditable = false
        NutLbl.text = "This is a test to see if I can pre populate the text with the ingrediants"
        NutLbl.textAlignment = .left
        NutLbl.layer.cornerRadius = 2
        NutLbl.layer.borderWidth = 0.1
        NutLbl.translatesAutoresizingMaskIntoConstraints = false
        
        return NutLbl
    }()
    
    lazy var backButton: UIButton = {
        let back = UIButton(type: .system)
        back.setTitle("Blueberries", for: .normal)
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
    
    
    //var productImageView: listProductImageLayout!
    func setUpScrollView() {
        scrolling.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrolling.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrolling.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrolling.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        scrolling.addSubview(backButton)
        scrolling.addSubview(imageMatting)
        scrolling.addSubview(productInfoHolder)
        scrolling.addSubview(NurtritionLabel)
        scrolling.addSubview(productImage)
        //Adding subviews
        //scrolling.addSubview(alwaysNotify)
        //scrolling.addSubview(healthfFacts)
        
        scrolling.addSubview(calLabel)
        scrolling.addSubview(priceLabel)
        
        setupProductImageAttributes()
        setupproductInfoHolder()
        setupproductNutritionLabel()
        
    }
    
    
    func setupProductImageAttributes() {
        
        backButton.topAnchor.constraint(equalTo: scrolling.topAnchor, constant: 15).isActive = true
        backButton.centerXAnchor.constraint(equalTo: scrolling.centerXAnchor).isActive = true
        backButton.widthAnchor.constraint(equalTo: scrolling.widthAnchor, constant: -50).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.layer.cornerRadius = 20
        
        imageMatting.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10).isActive = true
        imageMatting.centerXAnchor.constraint(equalTo: backButton.centerXAnchor).isActive = true
        
        //login Fields
        //productImage.topAnchor.constraint(equalTo: backgrounLightColor.topAnchor, constant: 5).isActive = true
        productImage.centerXAnchor.constraint(equalTo: imageMatting.centerXAnchor).isActive = true
        productImage.centerYAnchor.constraint(equalTo: imageMatting.centerYAnchor).isActive = true
        
    }
    
    func setupproductInfoHolder() {
        
        let healthInfoStackView = UIStackView(arrangedSubviews: [healthfFacts, alwaysNotify])
        healthInfoStackView.contentMode = .scaleAspectFit
        healthInfoStackView.spacing = 5
        healthInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        healthInfoStackView.distribution = .fillEqually
        
        
        scrolling.addSubview(healthInfoStackView)
        
        
        productInfoHolder.topAnchor.constraint(equalTo: imageMatting.bottomAnchor, constant: 15).isActive = true
        productInfoHolder.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        productInfoHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25).isActive = true
        productInfoHolder.heightAnchor.constraint(equalToConstant: 350).isActive = true
        productInfoHolder.layer.cornerRadius = 10
        
        healthInfoStackView.topAnchor.constraint(equalTo: productInfoHolder.topAnchor, constant: 5).isActive = true
        healthInfoStackView.leadingAnchor.constraint(equalTo: productInfoHolder.leadingAnchor, constant: 5).isActive = true
        //healthInfoStackView.trailingAnchor.constraint(equalTo: productInfoHolder.trailingAnchor, constant: -5).isActive = true
        healthInfoStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        healthInfoStackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
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
        
    }
    
    func setupproductNutritionLabel() {
        
        NurtritionLabel.topAnchor.constraint(equalTo: productInfoHolder.bottomAnchor, constant: 5).isActive = true
        NurtritionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        NurtritionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25).isActive = true
        NurtritionLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        NurtritionLabel.layer.cornerRadius = 10
        
    }
    
    
}
