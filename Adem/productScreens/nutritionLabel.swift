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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.ademBlue
        
        setUpProductButtons()
        setupProductLayoutContstraints()
        
        //let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
        //self.view.addGestureRecognizer(panGestureRecognizer)
        
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
        let notifyImage = UIImage(named: infoImage)
        notify.setImage(notifyImage, for: .normal)
        notify.translatesAutoresizingMaskIntoConstraints = false
        notify.contentMode = .scaleAspectFit
        //notify.backgroundColor = UIColor.blue
        return notify
    }()
    
    lazy var nutritionDetails: UIButton = {
        let facts = UIButton()
        let image = UIImage(named: "vegan_selected")
        //facts.backgroundImage(for: .normal)
        facts.setImage(image, for: .normal)
        facts.translatesAutoresizingMaskIntoConstraints = false
        facts.contentMode = .scaleAspectFit
        return facts
    }()
    
    let favoriteProduct: UIButton = {
        let faveProduct = UIButton()
        let faveImage = UIImage(named: heartImage)
        faveProduct.setImage(faveImage, for: .normal)
        faveProduct.translatesAutoresizingMaskIntoConstraints = false
        faveProduct.contentMode = .scaleAspectFit
        faveProduct.backgroundColor = UIColor.blue
        return faveProduct
    }()




    func setUpProductButtons() {
        //MARK: how to add button interaction
        
//        productNameSection.productNameAndBackButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
//        relatedProductInfoSection.nutritionDetails.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
    }
    
    func setupProductLayoutContstraints() {
        
        view.addSubview(nutritionImage)
        
        let healthInfoStackView = UIStackView(arrangedSubviews: [nutritionDetails, favoriteProduct, whereToBuy])

        view.addSubview(healthInfoStackView)
        
        healthInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        nutritionImage.translatesAutoresizingMaskIntoConstraints = false
        
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
        nutritionImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        
        

        
        ])
            
    }
}



