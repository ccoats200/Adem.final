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
//import FirebaseFirestore

class listProductVCLayout: UIViewController {
    
    //MARK: View set up
    var pInfo = productViews()
    var imageV = productImageViews()
    var infoView = productInfoViews()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.ademBlue
        
        setUpViews()
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
        
        segmentViews = [UIView]()
        segmentViews.append(infoView)
        segmentViews.append(mealsPage)
        segmentViews.append(statsPage)
        view.addSubview(pInfo)
        view.addSubview(imageV)
        
        
        for v in segmentViews {
            view.addSubview(v)
            v.layer.cornerRadius = 10
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        view.bringSubviewToFront(segmentViews[0])
        
        view.addSubview(segmentContr)
        
        imageV.translatesAutoresizingMaskIntoConstraints = false
        pInfo.translatesAutoresizingMaskIntoConstraints = false
        segmentContr.translatesAutoresizingMaskIntoConstraints = false
        
        infoView.listQuantityButon.addTarget(self, action: #selector(plz), for: .touchDown)
    }

    
    @objc func plz() {
        
        print("???")
    }
    
    func setUpProductButtons() {
        //MARK: how to add button interaction
        
        pInfo.productNameAndBackButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        infoView.nutritionDetails.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
    }
    
    func setupProductLayoutContstraints() {

        //MARK: Constraints
        NSLayoutConstraint.activate([
            
        pInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        pInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        pInfo.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
        pInfo.heightAnchor.constraint(equalToConstant: 50),

        imageV.topAnchor.constraint(equalTo: pInfo.bottomAnchor, constant: 10),
        imageV.centerXAnchor.constraint(equalTo: pInfo.centerXAnchor),
        
        segmentContr.topAnchor.constraint(equalTo: imageV.bottomAnchor, constant: 10),
        segmentContr.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        segmentContr.widthAnchor.constraint(equalTo: infoView.widthAnchor),
        segmentContr.heightAnchor.constraint(equalToConstant: 25),
        
        infoView.topAnchor.constraint(equalTo: segmentContr.bottomAnchor, constant: 5),
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        infoView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
        infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        mealsPage.topAnchor.constraint(equalTo: infoView.topAnchor),
        mealsPage.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
        mealsPage.widthAnchor.constraint(equalTo: infoView.widthAnchor),
        mealsPage.bottomAnchor.constraint(equalTo: infoView.bottomAnchor),
        
        statsPage.topAnchor.constraint(equalTo: infoView.topAnchor),
        statsPage.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
        statsPage.widthAnchor.constraint(equalTo: infoView.widthAnchor),
        statsPage.bottomAnchor.constraint(equalTo: infoView.bottomAnchor),
        
        ])
            
    }
}


