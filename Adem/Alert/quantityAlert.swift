//
//  quantityAlert.swift
//  Adem
//
//  Created by Coleman Coats on 2/22/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class quantityAlert: UIViewController {
    
    // Anywhere there is a server call we need to have the the function return a tuple to show the server status incase the server fails. see the section in the swift book on tuples
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setUpAddDismiss()
        
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss(_:)))
        self.view.addGestureRecognizer(tapToDismiss)

    }
    

    let addedItem: UIView = {
        
        let addedNotification = UIView()
        addedNotification.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        addedNotification.layer.cornerRadius = 5
        
        addedNotification.translatesAutoresizingMaskIntoConstraints = false
        addedNotification.layer.masksToBounds = true
        addedNotification.layer.borderColor = UIColor.white.cgColor
        
        return addedNotification
    }()
    
    let priceLabel: UILabel = {
        let cost = 2.99
        let price = UILabel()
        price.layer.cornerRadius = 5
        price.layer.masksToBounds = true
        price.text = "$\(cost)"
        price.textColor = UIColor.ademRed
        price.font = UIFont.boldSystemFont(ofSize: 16)
        return price
    }()
    
    @objc func tapToDismiss(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpAddDismiss() {
       
        view.addSubview(addedItem)
        view.addSubview(priceLabel)
        addedItem.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            
    
            priceLabel.centerXAnchor.constraint(equalTo: addedItem.centerXAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: addedItem.centerYAnchor),
            priceLabel.widthAnchor.constraint(equalTo: addedItem.widthAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 50),
            
            
            addedItem.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addedItem.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addedItem.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            addedItem.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),
        ])
    }
}

