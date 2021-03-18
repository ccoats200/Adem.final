//
//  nutritionLabel.swift
//  Adem
//
//  Created by Coleman Coats on 2/24/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class nutritionLabelVC: UIViewController {
    
    var nutritionCollectionView: UICollectionView!
    let nutritionCID = "Cmeals"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.white
        
        setUpCollection()
        setupProductLayoutContstraints()
        
        //let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
        //self.view.addGestureRecognizer(panGestureRecognizer)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpCollection() {
        let mealsCollectionViewlayouts = UICollectionViewFlowLayout()
        mealsCollectionViewlayouts.scrollDirection = .vertical
        
        self.nutritionCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: mealsCollectionViewlayouts)

          
        nutritionCollectionView.showsVerticalScrollIndicator = false
        self.nutritionCollectionView.dataSource = self
        self.nutritionCollectionView.delegate = self
        self.nutritionCollectionView.register(pantryCell.self, forCellWithReuseIdentifier: nutritionCID)
        if #available(iOS 13.0, *) {
            self.nutritionCollectionView.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        self.nutritionCollectionView.isUserInteractionEnabled = true
        self.nutritionCollectionView.isScrollEnabled = true
        
        //CollectionView spacing
        nutritionCollectionView.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
    }
    

    //MARK: Button engagement
    //product Button
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
        
    @objc func handleCamera() {
        if #available(iOS 13.0, *) {
            let productScreen = camVC()
            productScreen.hidesBottomBarWhenPushed = true
            productScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(productScreen, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        
        print("Camera button working")
    }

    let nutritionImage: UIImageView = {
        let nutritionImg = UIImageView()
        nutritionImg.image = UIImage(named: "rec")
        //nutritionImg.backgroundColor = UIColor.white
        nutritionImg.layer.cornerRadius = 5
        nutritionImg.clipsToBounds = true
        nutritionImg.layer.masksToBounds = true
        nutritionImg.contentMode = .scaleAspectFit
        nutritionImg.translatesAutoresizingMaskIntoConstraints = false
        return nutritionImg
    }()
    
    let whereToBuy: UIButton = {
        let notify = UIButton()
        let notifyImage = UIImage(named: heartImage)
        notify.setImage(notifyImage, for: .normal)
        notify.translatesAutoresizingMaskIntoConstraints = false
        notify.contentMode = .scaleAspectFit
        return notify
    }()
    
    lazy var nutritionDetails: UIButton = {
        let facts = UIButton()
        let image = UIImage(named: fishImage)
        facts.setImage(image, for: .normal)
        facts.translatesAutoresizingMaskIntoConstraints = false
        facts.contentMode = .scaleAspectFit
        return facts
    }()
    
    let favoriteProduct: UIButton = {
        let faveProduct = UIButton()
        let faveImage = UIImage(named: nutImage)
        faveProduct.setImage(faveImage, for: .normal)
        faveProduct.translatesAutoresizingMaskIntoConstraints = false
        faveProduct.contentMode = .scaleAspectFit
        return faveProduct
    }()

    
    func setupProductLayoutContstraints() {
        
        view.addSubview(nutritionImage)
        view.addSubview(nutritionCollectionView)
        
        let healthInfoStackView = UIStackView(arrangedSubviews: [nutritionDetails, favoriteProduct, whereToBuy])

        view.addSubview(healthInfoStackView)
        
        healthInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        nutritionImage.translatesAutoresizingMaskIntoConstraints = false
        nutritionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //adding subviews to the view controller
        
        healthInfoStackView.contentMode = .scaleAspectFit
        healthInfoStackView.spacing = 5
        healthInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        healthInfoStackView.clipsToBounds = true
        healthInfoStackView.layer.masksToBounds = true
        healthInfoStackView.distribution = .fillEqually
        healthInfoStackView.backgroundColor = UIColor.white

        
        //MARK: Constraints
        NSLayoutConstraint.activate([
            
            
            healthInfoStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            healthInfoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            healthInfoStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            healthInfoStackView.heightAnchor.constraint(equalToConstant: 30),
            
            nutritionImage.topAnchor.constraint(equalTo: healthInfoStackView.bottomAnchor, constant: 10),
            nutritionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nutritionImage.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            nutritionImage.heightAnchor.constraint(equalToConstant: 100),
            
            nutritionCollectionView.topAnchor.constraint(equalTo: nutritionImage.bottomAnchor),
            nutritionCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nutritionCollectionView.widthAnchor.constraint(equalTo: nutritionImage.widthAnchor),
            nutritionCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
}

extension nutritionLabelVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayofPantry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pantryItemsCell = collectionView.dequeueReusableCell(withReuseIdentifier: nutritionCID, for: indexPath) as! pantryCell
    
        let pantryList = arrayofPantry[indexPath.item]
        
        pantryItemsCell.pantryItemName.text = pantryList.productName

        pantryItemsCell.layer.cornerRadius = 5
        return pantryItemsCell
    }
    
    
}



