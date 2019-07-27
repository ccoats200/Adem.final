//
//  AcctElements.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth
import Firebase
import FirebaseFirestore


class AccountCell: CellBasics {
    
    
    var docRef: DocumentReference!
    let user = Auth.auth().currentUser
    
    
    
    
    var profileItem: profileContent? {
        didSet {
            personName.text = profileItem?.personName
            print("Name is grabed and placed in the person name text box")
        }
    }
    
    
    
    
    //Collection View Profile Pic
    let profileImageSection: UIImageView = {
        let profilepic = UIImageView()
        profilepic.image = UIImage(named: "eggs")
        profilepic.contentMode = .center
        //addItemButtonImage.contentMode = .scaleAspectFit
        profilepic.clipsToBounds = true
        profilepic.layer.masksToBounds = true
        profilepic.layer.cornerRadius = 62.5
        profilepic.layer.borderWidth = 2
        profilepic.layer.borderColor = UIColor.ademGreen.cgColor
        print("Created the users profile image")
        
        
        
        return profilepic
    }()
    
    @objc func getEmail() {
        
        docRef.addSnapshotListener { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
            let personNameData = docSnapshot.data()
            let nameData = personNameData!["email"] as! String
            self.personName.text = "\(nameData)"
        }
        
        /*
         docRef.getDocument(completion: { (docSnapshot, error) in
         guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
         let personNameData = docSnapshot.data()
         let nameData = personNameData!["email"] as! String
         self.personName.text = "\(nameData)"
         })
         */
    }
    
    
    
    var personName: UILabel = {
        
        let accountNameLBL = UILabel()
        accountNameLBL.font = UIFont(name: "Helvetica", size: 20)
        accountNameLBL.font = .boldSystemFont(ofSize: 20)
        accountNameLBL.textColor = UIColor.blue
        //accountNameLBL.text = "test"
        accountNameLBL.textAlignment = .center
        accountNameLBL.text = "Colemans"
        //accountNameLBL.layer.cornerRadius = 2
        //accountNameLBL.layer.borderWidth = 0.1
        print("Created the account name Label")
        
        return accountNameLBL
    }()
    
    let nickName: UILabel = {
        let NN = UILabel()
        NN.font = UIFont(name: "Helvetica", size: 20)
        NN.font = .boldSystemFont(ofSize: 20)
        NN.textColor = UIColor.blue
        NN.text = "Lazy"
        NN.textAlignment = .center
        //accountNameLBL.layer.cornerRadius = 2
        //accountNameLBL.layer.borderWidth = 0.1
        print("Created the account name Label")
        
        return NN
    }()
    
    
    override func setupViews() {
        addSubview(profileImageSection)
        addSubview(personName)
        
        //Vertical
        addConstraintsWithFormats(format: "V:|[v0(110)]-5-[v1(15)]|", views: profileImageSection, personName)
        
        //Horizontal
        addConstraintsWithFormats(format: "H:|[v0]|", views: profileImageSection)
        addConstraintsWithFormats(format: "H:|[v0]|", views: personName)
        
        
        
        /*
         //Top Constraints Quantity
         addConstraint(NSLayoutConstraint(item: personName, attribute: .top, relatedBy: .equal, toItem: profileImageSection, attribute: .top, multiplier: 1, constant: 5))
         //Right Constraints Quantity
         addConstraint(NSLayoutConstraint(item: personName, attribute: .right, relatedBy: .equal, toItem: profileImageSection, attribute: .right, multiplier: 1, constant: -5))
         //Height Constraint Quantity
         addConstraint(NSLayoutConstraint(item: personName, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 40))
         //Width Constraint
         addConstraint(NSLayoutConstraint(item: personName, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 100))
         */
        
    }
}

class familyCells: CellBasics {
    
    var profileItems: profileContent? {
        didSet {
            profileImageView.image = UIImage(named: (profileItems?.profielImageIdentifier)!)
            personName.text = profileItems?.personName
            
            print("set")
        }
    }
    
    let profileImageView: UIImageView = {
        let personImage = UIImageView()
        personImage.contentMode = .scaleAspectFill
        personImage.clipsToBounds = true
        personImage.layer.cornerRadius = 32.5
        personImage.layer.borderWidth = 2
        personImage.layer.borderColor = UIColor.ademGreen.cgColor
        personImage.layer.masksToBounds = true
        print("rounds the corners of the image view")
        return personImage
    }()
    
    let personName: UILabel = {
        let personName = UILabel()
        personName.textAlignment = .center
        personName.numberOfLines = 1
        personName.adjustsFontSizeToFitWidth = true
        print("sets the item name")
        return personName
    }()
    
    
    override func setupViews() {
        addSubview(profileImageView)
        print("adds the product image subview")
        addSubview(personName)
        print("adds the product name subview")
        
        //Horizontral Constaints
        addConstraintsWithFormats(format: "H:|-2-[v0(65)]-2-|", views: profileImageView)
        addConstraintsWithFormats(format: "H:|-8-[v0]-8-|", views: personName)
        
        //Vertical Constraints
        //addConstraintsWithFormats(format: "V:|-2-[v0(100)]-1-[v1(20)]|", views: profileImageView, personName)
        
        addConstraintsWithFormats(format: "V:|-5-[v0(65)]|", views: profileImageView)
        
        //Top Constraints Quantity
        addConstraint(NSLayoutConstraint(item: personName, attribute: .top, relatedBy: .equal, toItem: profileImageView, attribute: .bottom, multiplier: 1, constant: 5))
        //left Constraints Quantity
        addConstraint(NSLayoutConstraint(item: personName, attribute: .right, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 5))
        //Height Constraint Quantity
        addConstraint(NSLayoutConstraint(item: personName, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //Width Constraint
        addConstraint(NSLayoutConstraint(item: personName, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 15))
        
    }
}

class deviceCells: CellBasics {
    
    
    let kitchenStaff0: UIButton = {
        let Staff0 = UIButton()
        Staff0.contentMode = .center
        Staff0.clipsToBounds = true
        Staff0.layer.masksToBounds = true
        Staff0.layer.cornerRadius = 32.5
        Staff0.backgroundColor = UIColor.white
        Staff0.layer.borderColor = UIColor.ademGreen.cgColor
        Staff0.layer.borderWidth = 2
        //Staff0.image = UIImage(named: "eggs")
        Staff0.isUserInteractionEnabled = true
        
        print("Created the add button")
        
        return Staff0
    }()
    
    
    
    
    /*
     @objc
     open func handleTapGesture(_ gesture: UIGestureRecognizer) {
     guard gesture.state == .ended else { return }
     
     let touchLocation = gesture.location(in: self)
     
     switch true {
     case kitchenStaff0.frame.contains(touchLocation) && !contentView(canHandle: convert(touchLocation, to: SettingsVC)):
     delegate?.didTapMessage(in: self)
     default:
     break
     }
     }
     */
    
    override func setupViews() {
        addSubview(kitchenStaff0)
        //addSubview(kitchenStaff1)
        
        //kitchenStaff0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTap)))
        
        
        //Horizontal
        addConstraintsWithFormats(format: "H:|[v0(65)]|", views: kitchenStaff0)
        
        //Vertical
        addConstraintsWithFormats(format: "V:|-7.5-[v0(65)]-7.5-|", views: kitchenStaff0)
        
    }
    /*
     func handleClickCtg(gestureRecognizer: UITapGestureRecognizer) {
     guard let tag = gestureRecognizer.view?.tag else {return}
     print(tag)
     if let clickedImageView = deviceViews(rawValue: tag){
     self.delegate?.clicked( view: clickedImageView, forCell: self)
     }
     */
    
}

class accountAndPrivacyCollectionViewCells: CellBasics {
    
    
    let accountAndPrivacy: UIImageView = {
        let aAndp = UIImageView()
        aAndp.contentMode = .center
        aAndp.clipsToBounds = true
        aAndp.layer.masksToBounds = true
        aAndp.layer.cornerRadius = 5
        aAndp.backgroundColor = UIColor.white
        //aAndp.layer.borderColor = UIColor.ademGreen.cgColor
        //aAndp.layer.borderWidth = 2.0
        
        print("Created the add button")
        
        return aAndp
    }()
    
    let sectionName: UILabel = {
        let section = UILabel()
        //name.text = "\(itemName)"
        section.textAlignment = .center
        section.numberOfLines = 1
        section.adjustsFontSizeToFitWidth = true
        print("sets the item name")
        return section
    }()
    
    
    override func setupViews() {
        addSubview(accountAndPrivacy)
        addSubview(sectionName)
        
        //Horizontal
        //addConstraintsWithFormats(format: "H:|[v0(50)]-10-[v1(25)]|", views: kitchenStaff0, kitchenStaff1)
        addConstraintsWithFormats(format: "H:|[v0(160)]|", views: accountAndPrivacy)
        addConstraintsWithFormats(format: "H:|-8-[v0]-8-|", views: sectionName)
        
        //Vertical
        addConstraintsWithFormats(format: "V:|-7.5-[v0(120)]-7.5-[v1(20)]-3-|", views: accountAndPrivacy, sectionName)
        //addConstraintsWithFormats(format: "V:|[v0]|", views: kitchenStaff1)
    }
}

