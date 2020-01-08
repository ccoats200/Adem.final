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
import FirebaseFirestore

class listProductVCLayout: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.ademBlue
        
        
        setupProductImageAttributes()
        
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
    

    //product Button
    @objc func handleFacts() {
        let signUpInfo = circleTest()
        self.present(signUpInfo, animated: true)
        print("went to new page")
    }
 
    //product Button
    @objc func handleBack() {
        self.dismiss(animated: true, completion: nil)
        print("went back to previous page")
    }
    
    var pInfo = productViews()
    var imageV = productImageViews()
    var infoView = productInfoViews()

    

    func setupProductImageAttributes() {
    
        view.addSubview(imageV)
        view.addSubview(pInfo)
        view.addSubview(infoView)
        
        imageV.translatesAutoresizingMaskIntoConstraints = false
        pInfo.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        pInfo.layer.cornerRadius = 20
        
        
        //MARK: Constraints
        
        NSLayoutConstraint.activate([
            
        pInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
        pInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        pInfo.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
        pInfo.heightAnchor.constraint(equalToConstant: 50),

        imageV.topAnchor.constraint(equalTo: pInfo.bottomAnchor, constant: 10),
        imageV.centerXAnchor.constraint(equalTo: pInfo.centerXAnchor),
        
        infoView.topAnchor.constraint(equalTo: imageV.bottomAnchor, constant: 15),
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        infoView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
        infoView.heightAnchor.constraint(equalToConstant: 325),
        ])
            
    }
}
