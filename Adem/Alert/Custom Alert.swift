//
//  Custom Alert.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Foundation
import Firebase
//import FirebaseFirestore


class addedItemAlert: UIViewController {
    
    // Anywhere there is a server call we need to have the the function return a tuple to show the server status incase the server fails. see the section in the swift book on tuples
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(addedItem)
        
        setUpAddDismiss()
    }
    
    let addedItem: UIView = {
        
        let addedNotification = UIView()
        addedNotification.backgroundColor = UIColor.ademGreen.withAlphaComponent(0.95)
        addedNotification.translatesAutoresizingMaskIntoConstraints = false
        addedNotification.layer.cornerRadius = 30
        addedNotification.layer.masksToBounds = true
        addedNotification.layer.borderWidth = 1
        addedNotification.layer.borderColor = UIColor.white.cgColor
        
        return addedNotification
    }()
    
    let outNumberCount: UIButton = {
        
        let out = UIButton()
        out.layer.cornerRadius = 5
        out.setTitle("1", for: .normal)
        out.tintColor = UIColor.white
        out.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
        out.layer.masksToBounds = true
        out.translatesAutoresizingMaskIntoConstraints = false

        return out
    }()
    
    @objc func handelLogin() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setUpAddDismiss() {
        
        addedItem.addSubview(outNumberCount)
        
        NSLayoutConstraint.activate([
            
            addedItem.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addedItem.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addedItem.widthAnchor.constraint(equalToConstant: 60),
            addedItem.heightAnchor.constraint(equalToConstant: 60),
        
            outNumberCount.centerXAnchor.constraint(equalTo: addedItem.centerXAnchor),
            outNumberCount.centerYAnchor.constraint(equalTo: addedItem.centerYAnchor),
            outNumberCount.widthAnchor.constraint(equalTo: addedItem.widthAnchor),
            outNumberCount.heightAnchor.constraint(equalTo: addedItem.heightAnchor),
        ])
    }
}

class removeDataCapture: UIViewController {
    
    // Anywhere there is a server call we need to have the the function return a tuple to show the server status incase the server fails. see the section in the swift book on tuples
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(addedItem)
        
        setUpAddDismiss()
    }
    
    let addedItem: UIView = {
        
        let addedNotification = UIView()
        addedNotification.backgroundColor = UIColor.white
        addedNotification.layer.cornerRadius = 5
        addedNotification.layer.masksToBounds = true
        addedNotification.layer.borderColor = UIColor.white.cgColor
        
        return addedNotification
    }()
    
    let outNumberCount: UIButton = {
        
        let out = UIButton()
        out.layer.cornerRadius = 5
        out.setTitle("50%", for: .normal)
        out.backgroundColor = UIColor.ademBlue
        out.tintColor = UIColor.white
        out.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
        out.layer.masksToBounds = true

        return out
    }()
    
    @objc func handelLogin() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setUpAddDismiss() {
        view.addSubview(addedItem)
        addedItem.addSubview(outNumberCount)
        addedItem.translatesAutoresizingMaskIntoConstraints = false
        outNumberCount.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            addedItem.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addedItem.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addedItem.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 8/10),
            addedItem.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 4/10),
        
            outNumberCount.centerXAnchor.constraint(equalTo: addedItem.centerXAnchor),
            outNumberCount.centerYAnchor.constraint(equalTo: addedItem.centerYAnchor),
            outNumberCount.widthAnchor.constraint(equalToConstant: 110),
            outNumberCount.heightAnchor.constraint(equalToConstant: 60),
    
        ])
    }
}

