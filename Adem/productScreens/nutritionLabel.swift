//
//  nutritionLabel.swift
//  Adem
//
//  Created by Coleman Coats on 2/24/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


class nutritionLabelVC: UIView {
    
    var nutritionCollectionView: UICollectionView!
    let nutritionCID = "Cmeals"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor.white
        setUpCollection()
        setupProductLayoutContstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCollection()
        setupProductLayoutContstraints()
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCollection() {
        let nutritionCollectionViewlayouts = UICollectionViewFlowLayout()
        nutritionCollectionViewlayouts.scrollDirection = .vertical
        nutritionCollectionViewlayouts.itemSize = CGSize(width: 100, height: 50)
        
        self.nutritionCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: nutritionCollectionViewlayouts)

          
        nutritionCollectionView.showsVerticalScrollIndicator = false
        self.nutritionCollectionView.dataSource = self
        self.nutritionCollectionView.delegate = self
        self.nutritionCollectionView.register(nutritionCell.self, forCellWithReuseIdentifier: nutritionCID)
        if #available(iOS 13.0, *) {
            self.nutritionCollectionView.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        self.nutritionCollectionView.isUserInteractionEnabled = true
        self.nutritionCollectionView.isScrollEnabled = true
        
        //CollectionView spacing
        nutritionCollectionView.contentInset = UIEdgeInsets(top: 5, left: 2.5, bottom: 5, right: 2.5)
    }

    let nutritionIngredientsTextView: UITextView = {
        let nutritionTxtView = UITextView()
        nutritionTxtView.layer.cornerRadius = 5
        nutritionTxtView.isEditable = false
        nutritionTxtView.textColor = UIColor.ademBlue
        nutritionTxtView.layer.masksToBounds = true
        nutritionTxtView.translatesAutoresizingMaskIntoConstraints = false
        return nutritionTxtView
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
        
        self.addSubview(nutritionIngredientsTextView)
        self.addSubview(nutritionCollectionView)
        
        let healthInfoStackView = UIStackView(arrangedSubviews: [nutritionDetails, favoriteProduct, whereToBuy])

        self.addSubview(healthInfoStackView)
        
        healthInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        nutritionIngredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        nutritionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //adding subviews to the view controller
        
        healthInfoStackView.contentMode = .scaleAspectFit
        healthInfoStackView.spacing = 5
        healthInfoStackView.clipsToBounds = true
        healthInfoStackView.layer.masksToBounds = true
        healthInfoStackView.layer.cornerRadius = 15
        healthInfoStackView.distribution = .fillEqually
        healthInfoStackView.backgroundColor = UIColor.white

        
        //MARK: Constraints
        NSLayoutConstraint.activate([
            
            
            healthInfoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            healthInfoStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            healthInfoStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            healthInfoStackView.heightAnchor.constraint(equalToConstant: 30),
            
            nutritionCollectionView.topAnchor.constraint(equalTo: healthInfoStackView.bottomAnchor, constant: 10),
            nutritionCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -25),
            nutritionCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nutritionCollectionView.bottomAnchor.constraint(equalTo: nutritionIngredientsTextView.topAnchor),

            nutritionIngredientsTextView.topAnchor.constraint(equalTo: nutritionCollectionView.bottomAnchor, constant: 10),
            nutritionIngredientsTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nutritionIngredientsTextView.widthAnchor.constraint(equalTo: nutritionCollectionView.widthAnchor),
            nutritionIngredientsTextView.heightAnchor.constraint(equalToConstant: 100),
            nutritionIngredientsTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
}

extension nutritionLabelVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //FIXME: I feel like there should be a check of some sort here.
        return arrayofNutrients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pantryItemsCell = collectionView.dequeueReusableCell(withReuseIdentifier: nutritionCID, for: indexPath) as! nutritionCell
        let pantryList = arrayofNutrients[indexPath.item]
        pantryItemsCell.nutriName.text = pantryList.name
        pantryItemsCell.nutriAmount.text = "\(pantryList.amount) \(pantryList.unit)"
        pantryItemsCell.layer.cornerRadius = 5
        
        return pantryItemsCell
    }
}
