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
    
    //var docRef: DocumentReference!
    //var handle: AuthStateDidChangeListenerHandle?
    let user = Auth.auth().currentUser
    var accountStuff: ProfileView!
    
    //Cell Id's
    let cellId = "cellId0"
    let cellId2 = "cell1"
    let cellId3 = "cell2"
    let cellId4 = "cell3"
    let headerID = "test"
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Account"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.clear]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        view.backgroundColor = UIColor.white
        
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        docRef = Firestore.firestore().document("UserLoginInfo/user")
        
        
        
        let added = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handelSignUp))
        self.navigationItem.rightBarButtonItem = added
        
        
        //Family Cell
        //Collection view scrollable
        //collectionView.register(familySection.self, forCellWithReuseIdentifier: cellId2)
        //collectionView.register(friendsCellLayout.self, forCellWithReuseIdentifier: cellId2)
        
        //collectionView.register(familyCells.self, forCellWithReuseIdentifier: cellId2)
        
        //Device Cell
        //collectionView.register(deviceSection.self, forCellWithReuseIdentifier: cellId3)
        
        //Allergies Cell
        collectionView.register(accountPrivacyCellDesign.self, forCellWithReuseIdentifier: cellId4)
        
        //self.collectionView.register(friendsCellLayout.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
        
        //let flow = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //flow.headerReferenceSize = CGSize(30,30)
        
        
        
        //setup all views
        setupViews()
        //setUpAgain()
    }
    
    //UIView Profile Pic
    let coverPhoto: UIImageView = {
        let cover = UIImageView()
        cover.image = UIImage(named: "eggs")
        cover.layer.masksToBounds = true
        cover.clipsToBounds = true
        cover.translatesAutoresizingMaskIntoConstraints = false
        return cover
    }()
    
    //UIView Profile Pic
    let userProfileImage: UIImageView = {
        let profPic = UIImageView()
        profPic.image = UIImage(named: "bread")
        profPic.contentMode = .scaleAspectFill
        profPic.layer.cornerRadius = 50
        profPic.layer.masksToBounds = true
        profPic.clipsToBounds = true
        profPic.layer.borderWidth = 4
        profPic.layer.shadowColor = UIColor.clear.cgColor
        profPic.layer.borderColor = UIColor.white.cgColor
        profPic.translatesAutoresizingMaskIntoConstraints = false
        
        return profPic
    }()
    
    let nameofUser: UILabel = {
        let userName = UILabel()
        userName.textAlignment = .center
        userName.numberOfLines = 1
        userName.adjustsFontSizeToFitWidth = true
        //userName.font = UIFont(name: "Lato", size: 80)
        userName.font = UIFont.boldSystemFont(ofSize: 20)
        userName.textColor = UIColor.ademBlue
        userName.text = "Coleman"
        userName.translatesAutoresizingMaskIntoConstraints = false
        print("sets the item name")
        return userName
    }()
    
    
    
    let collectionView: UICollectionView = { // collection view to be added to view controller
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout());//zero size with flow layout
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        return cv
        
    }()
    /*
     func setUpAgain() {
     //SetUp views from own class
     let ss: CGRect = UIScreen.main.bounds
     accountStuff = ProfileView(frame: CGRect(x: 0, y: 0, width: ss.width, height: 500))
     //accountStuff = ProfileView(frame: CGRect.zero)
     //accountStuff.backgroundColor = UIColor.red
     self.view.addSubview(accountStuff)
     self.view.addSubview(collectionView)
     
     
     collectionView.delegate = self // set delegate
     collectionView.dataSource = self //set data source
     
     NSLayoutConstraint.activate([
     //accountStuff.topAnchor.constraint(equalTo: view.topAnchor),
     //accountStuff.leadingAnchor.constraint(equalTo: view.leadingAnchor),
     //accountStuff.trailingAnchor.constraint(equalTo: view.trailingAnchor),
     collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
     collectionView.trailingAnchor.constraint(equalTo:  view.trailingAnchor),
     collectionView.topAnchor.constraint(equalTo: accountStuff.bottomAnchor, constant: 25),
     collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
     ])
     
     }
     */
    
    
    
    func setupViews() {
        
        
        view.addSubview(coverPhoto)
        view.addSubview(userProfileImage)
        view.addSubview(nameofUser)
        
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.ademGreen
        collectionView.layer.cornerRadius = 5
        
        collectionView.delegate = self // set delegate
        collectionView.dataSource = self //set data source
        
        
        //CoverPhoto
        coverPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true //set the location of collection view
        coverPhoto.trailingAnchor.constraint(equalTo:  view.trailingAnchor).isActive = true // top anchor of collection view
        coverPhoto.topAnchor.constraint(equalTo: view.topAnchor).isActive = true // height
        coverPhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true // width
        
        //Profile Pic
        userProfileImage.centerXAnchor.constraint(equalTo: coverPhoto.centerXAnchor).isActive = true //set the location of collection view
        userProfileImage.centerYAnchor.constraint(equalTo: coverPhoto.bottomAnchor).isActive = true //set the location of collection view
        //userProfileImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true // height
        userProfileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true // width
        userProfileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //Users Name
        nameofUser.centerXAnchor.constraint(equalTo: userProfileImage.centerXAnchor).isActive = true
        nameofUser.topAnchor.constraint(equalTo: userProfileImage.bottomAnchor).isActive = true
        nameofUser.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true // width
        nameofUser.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        //Collection
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true //set the location of collection view
        collectionView.trailingAnchor.constraint(equalTo:  view.trailingAnchor, constant: -5).isActive = true // top anchor of collection view
        collectionView.topAnchor.constraint(equalTo: nameofUser.bottomAnchor, constant: 25).isActive = true // height
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true // width
        //collectionView.heightAnchor.constraint(equalToConstant: 450).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
        
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            let user = Auth.auth().currentUser
            if let user = user {
                let nameOfUser = user.email
                //let photoURL = user.photoURL
                //let uid = user.uid
                
                //                let doesNotHaveAccount = "Welcome"
                
                self.nameofUser.text = nameOfUser
            }
        }
        docRef.addSnapshotListener { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
            let userNameData = docSnapshot.data()
            let usersName = userNameData?["FirstName"] as? String ?? ""
            profileImageCellLayout().userProfileName.text = "\(usersName)"
            profileImageCellLayout().userProfileImageView.image = UIImage(named: "eggs")
        }
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
            settings.accountPrivacyLabels.text = "Settings"
            settings.backgroundColor = UIColor.white
            settings.layer.cornerRadius = 15
            
            
            return settings
        case 3 :
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
    }
    
    
    //Cell calls
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
        
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //inset allocation
    let sectionInsets = UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
    
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
        
        let size4 = CGSize(width: view.frame.width/2 - 20, height: collectionView.frame.height/4 - 20)
        return size4
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


