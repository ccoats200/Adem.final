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
import FirebaseFirestore


protocol alertInformation {
    
    var alertProductName: String? { get set }
    var alertProductImageName: String? { get set }
}


//error hadeling for list.contains all items in the checkout screen that are designated as being purchased
class addedItemAlert: UIViewController {
    
    // Anywhere there is a server call we need to have the the function return a tuple to show the server status incase the server fails. see the section in the swift book on tuples
    
    
    var docRef: DocumentReference!
    var handle: AuthStateDidChangeListenerHandle?
    let user = Auth.auth().currentUser
    let minimuPasswordCount = 6
    
    var alertAssets: thrownOutAlert? {
        didSet {
            productImage.image = UIImage(named: (alertAssets?.alertProductImageName)!)
            productPreview.text = alertAssets?.alertProductName
            
            print("Set Alet pieces")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(addedItem)
        
        setUpAddDismiss()
    }
    
    let addedItem: UIView = {
        let addedNotification = UIView()
        addedNotification.backgroundColor = UIColor.ademGreen.withAlphaComponent(0.95)
        addedNotification.translatesAutoresizingMaskIntoConstraints = false
        addedNotification.layer.cornerRadius = 35
        addedNotification.layer.masksToBounds = true
        addedNotification.layer.borderWidth = 1
        addedNotification.layer.borderColor = UIColor.blue.cgColor
        
        return addedNotification
    }()
    
    let outPreview: UILabel = {
        let out = UILabel()
        out.translatesAutoresizingMaskIntoConstraints = false
        out.layer.cornerRadius = 5
        out.layer.masksToBounds = true
        out.text = "Looks like you're out of Berries"
        out.textColor = UIColor.white
        out.font = UIFont.boldSystemFont(ofSize: 20)
        out.textAlignment = .center
        
        return out
    }()
    
    lazy var productPreview: UILabel = {
        let preview = UILabel()
        preview.translatesAutoresizingMaskIntoConstraints = false
        preview.layer.cornerRadius = 5
        preview.layer.masksToBounds = true
        preview.text = "t"
        preview.textColor = UIColor.white
        preview.font = UIFont.boldSystemFont(ofSize: 20)
        preview.textAlignment = .center
        
        return preview
    }()
    
    lazy var skipButton: UIButton = {
        let login = UIButton(type: .system)
        login.backgroundColor = UIColor.white
        login.setTitle("Skip", for: .normal)
        login.translatesAutoresizingMaskIntoConstraints = false
        //login.layer.cornerRadius = 5
        login.layer.masksToBounds = true
        login.clipsToBounds = true
        login.setTitleColor(UIColor.rgb(red: 76, green: 82, blue: 111), for: .normal)
        login.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        login.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
        return login
        
    }()
    
    @objc func handelLogin() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    lazy var addButton: UIButton = {
        let add = UIButton(type: .system)
        add.backgroundColor = UIColor.white
        add.setTitle("Add", for: .normal)
        add.translatesAutoresizingMaskIntoConstraints = false
        //add.layer.cornerRadius = 5
        add.layer.masksToBounds = true
        add.clipsToBounds = true
        add.setTitleColor(UIColor.black, for: .normal)
        add.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        add.addTarget(self, action: #selector(handelAdd), for: .touchUpInside)
        
        return add
        
    }()
    
    
    @objc func handelAdd() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    lazy var productImage: UIImageView = {
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
        print("Created Image for the product image in the details VC")
        
        return productImageDesign
    }()
    
    
    func setUpAddDismiss() {
        
        let alertStackView = UIStackView(arrangedSubviews: [skipButton, addButton])
        alertStackView.contentMode = .scaleAspectFit
        alertStackView.translatesAutoresizingMaskIntoConstraints = false
        alertStackView.distribution = .fillEqually
        alertStackView.layer.masksToBounds = true
        alertStackView.clipsToBounds = true
        
        
        
        addedItem.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addedItem.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        addedItem.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -75).isActive = true
        addedItem.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        addedItem.addSubview(alertStackView)
        addedItem.addSubview(productPreview)
        addedItem.addSubview(productImage)
        addedItem.addSubview(outPreview)
        
        
        outPreview.centerXAnchor.constraint(equalTo: addedItem.centerXAnchor).isActive = true
        outPreview.topAnchor.constraint(equalTo: addedItem.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        outPreview.widthAnchor.constraint(equalTo: addedItem.widthAnchor).isActive = true
        outPreview.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        productImage.centerXAnchor.constraint(equalTo: outPreview.centerXAnchor).isActive = true
        productImage.topAnchor.constraint(equalTo: outPreview.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        productImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        productImage.layer.cornerRadius = 100
        
        productPreview.bottomAnchor.constraint(equalTo: alertStackView.topAnchor, constant: 10).isActive = true
        productPreview.centerXAnchor.constraint(equalTo: addedItem.centerXAnchor).isActive = true
        productPreview.widthAnchor.constraint(equalTo: addedItem.widthAnchor, constant: -10).isActive = true
        productPreview.heightAnchor.constraint(equalToConstant: 50).isActive = true

        alertStackView.bottomAnchor.constraint(equalTo: addedItem.bottomAnchor).isActive = true
        alertStackView.centerXAnchor.constraint(equalTo: addedItem.centerXAnchor).isActive = true
        alertStackView.widthAnchor.constraint(equalTo: addedItem.widthAnchor).isActive = true
        alertStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}


class addOrDeleteProduct: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpAddDismiss()
    }

    
    lazy var deleteItemFromPantryButton: UIButton = {
        let login = UIButton(type: .system)
        login.backgroundColor = UIColor.ademBlue
        login.setTitle("Skip", for: .normal)
        login.translatesAutoresizingMaskIntoConstraints = false
        login.layer.masksToBounds = true
        login.clipsToBounds = true
        login.setTitleColor(UIColor.black, for: .normal)
        login.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        login.addTarget(self, action: #selector(deleteProductFromPantry), for: .touchUpInside)
        login.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return login
        
    }()
    
    @objc func deleteProductFromPantry() {
        print("tried to click delete")
    }
    
    
    lazy var addProductToListButton: UIButton = {
        let add = UIButton(type: .system)
        add.backgroundColor = UIColor.ademBlue
        add.setTitle("Add", for: .normal)
        add.translatesAutoresizingMaskIntoConstraints = false
        add.layer.masksToBounds = true
        add.clipsToBounds = true
        add.setTitleColor(UIColor.black, for: .normal)
        add.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        add.addTarget(self, action: #selector(addProductToListFromPantry), for: .touchUpInside)
        
        return add
        
    }()
    
    @objc func addProductToListFromPantry() {
        print("tried to click Add")
        
    }
    
    func setUpAddDismiss() {
       
        let alertStackView = UIStackView(arrangedSubviews: [deleteItemFromPantryButton, addProductToListButton])
        alertStackView.contentMode = .scaleAspectFit
        alertStackView.translatesAutoresizingMaskIntoConstraints = false
        alertStackView.distribution = .fillEqually
        alertStackView.layer.masksToBounds = true
        alertStackView.clipsToBounds = true
        
        self.addSubview(alertStackView)
        
        alertStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        alertStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        alertStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        alertStackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
