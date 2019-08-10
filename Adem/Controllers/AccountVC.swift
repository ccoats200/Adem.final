//
//  AccountVC.swift
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

class AccountVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    //This needs a recipies button at the bottom. prominant. recipies can be listed as share with everyone or just friends or no one. Good for user generated content.
    //for now no chat setting for sending recipies easily.
    //the recipie will be photographed and in a table view, users can choose a generic pic for it. computer graphic or take a pic
    
    
    
    //var docRef: DocumentReference!
    //var handle: AuthStateDidChangeListenerHandle?
    let user = Auth.auth().currentUser
    var db: Firestore!
    
    
    //Cell Id's
    let cellId = "cellId0"
    let cellId2 = "cell1"
    let cellId3 = "cell2"
    let cellID = "cell3"
    let headerID = "test"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        view.backgroundColor = UIColor.white
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        docRef = Firestore.firestore().document("\(usersInfo)")
        
        //This needs to be changed
        let added = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handelSignUp))
        self.navigationItem.rightBarButtonItem = added
        

       
        
        //setup all views
        setUpAgain()
        //setUpViews()
   
    }
    
    var accountStuff: ProfileView!
    weak var collectionView: UICollectionView!
    
    func setUpAgain() {
     //SetUp views from own class
        let ss: CGRect = UIScreen.main.bounds
        accountStuff = ProfileView(frame: CGRect(x: 0, y: 0, width: ss.width, height: 225))
        
        let layouts: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let profileCollectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layouts)
        self.view.addSubview(accountStuff)
        self.view.addSubview(profileCollectionView)
        
        profileCollectionView.delegate = self // set delegate
        profileCollectionView.dataSource = self
        profileCollectionView.layer.cornerRadius = 5

        
        profileCollectionView.backgroundColor = UIColor.ademGreen
       
        profileCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        profileCollectionView.register(accountPrivacyCellDesign.self, forCellWithReuseIdentifier: cellID)
        
     
     NSLayoutConstraint.activate([
     profileCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -10),
    
     profileCollectionView.centerXAnchor.constraint(equalTo:  view.centerXAnchor),
     profileCollectionView.topAnchor.constraint(equalTo: accountStuff.bottomAnchor, constant: 25),
     profileCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        
     ])
        self.collectionView = profileCollectionView
     
     }

    var firstNameListener: ListenerRegistration!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
        
        
        
//        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//
//            let user = Auth.auth().currentUser
//            if let user = user {
//                let nameOfUser = user.email
//                //let photoURL = user.photoURL
//                //let uid = user.uid
//
//                //                let doesNotHaveAccount = "Welcome"
//
//                ProfileView().nameofUser.text = nameOfUser
//            }
//        }
        
        
        firstNameListener = docRef.addSnapshotListener { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
            let userNameData = docSnapshot.data()
            let usersName = userNameData?["FirstName"] as? String ?? ""
            self.accountStuff.nameofUser.text = "\(usersName)"
            print("\(usersName)")
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firstNameListener.remove()
    }
    
    @objc func handelSignUp()
    {
        
        let signUpInfo = UserInfo()
        signUpInfo.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(signUpInfo, animated: true)
        
        print("Sending user to sign up Flow")
        
    }
    
    var acct: [profileContent]? = {
        
        
        var acctImage = profileContent()
        acctImage.accountImage = "Coleman"
        acctImage.userNameLabel = "eggs"
        
        var privacyImage = profileContent()
        privacyImage.accountImage = "Coleman"
        privacyImage.userNameLabel = "eggs"
        
        return [acctImage, privacyImage]
    }()
    
    //deque cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        switch indexPath.section {
            
        case 0:
            if indexPath.item == 0 {
                let friends = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                friends.accountPrivacyImages.image = UIImage(named: "lock")
                friends.accountPrivacyLabels.text = "Friends"
                friends.backgroundColor = UIColor.white
                friends.layer.cornerRadius = 5
                
                
                return friends
            } else {
                let devices = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                devices.accountPrivacyImages.image = UIImage(named: "lock")
                devices.accountPrivacyLabels.text = "Devices"
                devices.backgroundColor = UIColor.white
                devices.layer.cornerRadius = 5
                
                return devices
            }
            
        case 1:
            switch indexPath.item {
            case 0:
                let devices = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                devices.accountPrivacyImages.image = UIImage(named: "lock")
                devices.accountPrivacyLabels.text = "Account"
                devices.backgroundColor = UIColor.white
                devices.layer.cornerRadius = 5
                
                return devices
            case 1:
                let devices = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                devices.accountPrivacyImages.image = UIImage(named: "lock")
                devices.accountPrivacyLabels.text = "Health"
                devices.backgroundColor = UIColor.white
                devices.layer.cornerRadius = 5
                
                return devices
            case 2:
                let devices = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                devices.accountPrivacyImages.image = UIImage(named: "lock")
                devices.accountPrivacyLabels.text = "Apps"
                devices.backgroundColor = UIColor.white
                devices.layer.cornerRadius = 5
                
                return devices
            default:
                let settings = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                settings.accountPrivacyLabels.text = "Settings"
                settings.backgroundColor = UIColor.white
                settings.layer.cornerRadius = 5
                return settings
            }
            
        case 2:
            let health = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
            health.accountPrivacyLabels.text = "Recipes"
            health.backgroundColor = UIColor.white
            health.layer.cornerRadius = 5
            return health
            
        default:
            let settings = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
            settings.accountPrivacyLabels.text = "Settings"
            settings.backgroundColor = UIColor.white
            settings.layer.cornerRadius = 15
            
            return settings
        }
        
        /*
        switch indexPath.item {
        case 0:
            let friends = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath) as! accountPrivacyCellDesign
            friends.accountPrivacyLabels.text = "Friends"
            friends.backgroundColor = UIColor.white
            friends.layer.cornerRadius = 15
            
            
            return friends
        case 1:
            let devices = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath) as! accountPrivacyCellDesign
            devices.accountPrivacyImages.image = UIImage(named: "lock")
            devices.accountPrivacyLabels.text = "Devices"
            devices.backgroundColor = UIColor.white
            devices.layer.cornerRadius = 15
            
            return devices
            
        case 2:
            let settings = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath) as! accountPrivacyCellDesign
            settings.accountPrivacyLabels.text = "Settingss"
            settings.backgroundColor = UIColor.white
            settings.layer.cornerRadius = 15
            
            
            return settings
        case 3:
            let health = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath) as! accountPrivacyCellDesign
            health.accountPrivacyImages.image = UIImage(named: "lock")
            health.accountPrivacyLabels.text = "Health"
            health.backgroundColor = UIColor.white
            health.layer.cornerRadius = 15
            
            return health
            
        default:
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath)
            return cell2
        }
 
 */
    }
    
    
    //Button Action - Start
    @objc func handleFriends() {
        let privacyController = friendsTVC()
        self.navigationController?.pushViewController(privacyController, animated: true)
        print("Settings Tab is active")
    }
    
    @objc func handleDevices() {
        let cController = settings()
        cController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(cController, animated: true)
        print("Settings Tab is active")
    }
    
    @objc func handleSettings() {
        let cController = SettingTVC()
        self.navigationController?.pushViewController(cController, animated: true)
        print("Settings Tab is active")
    }
    
    @objc func handleHealth() {
        let cController = ProductVC(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(cController, animated: true)
        print("Settings Tab is active")
    }
    //Button actions - End
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            handleFriends()
        case 1:
            handleDevices()
        case 2:
            handleSettings()
        case 3:
            handleHealth()
        default:
            handleSettings()
        }
    }
    
    // number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 1
        default:
            return 6
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    //inset allocation
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    //trying to get spacing betweenc cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //Distance Between Cells
        return sectionInsets.bottom
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    
    //size of each CollecionViewCell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            let section1 = CGSize(width: (view.frame.width/2 - 20), height: 100)
            return section1
        case 1:
            let section2 = CGSize(width: (view.frame.width/3 - 20), height: 100)
            return section2
        case 2:
            
            //Recipes button is acting weird
            let section3 = CGSize(width: (view.frame.width - 30), height: 75)//50)
            return section3
        default:
            let noSection = CGSize(width: view.frame.width, height: 50)
            return noSection
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


