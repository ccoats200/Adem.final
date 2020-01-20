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

class AccountVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
    
    
   
    //This needs a recipies button at the bottom. prominant. recipies can be listed as share with everyone or just friends or no one. Good for user generated content.
    //for now no chat setting for sending recipies easily.
    //the recipie will be photographed and in a table view, users can choose a generic pic for it. computer graphic or take a pic
    
    
    //Cell Id's
    let cellId = "cellId0"
    let cellId2 = "cell1"
    let cellId3 = "cell2"
    let cellID = "cell3"
    let headerID = "test"
    let tv = "test"
    
    //MARK: Views to set up
    var accountStuff = ProfileView()
    var friendsAndFamily = fAndFView()
    var diet = fAndFView()
    var collectionView: UICollectionView!
    var accountTableView: UITableView!
    //var accountTableView = listTableView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        view.backgroundColor = UIColor.white
        
        let settings = FirestoreSettings()
        db.settings = settings
        // [END setup]
        
        //setup all views
        setUpAgain()
        //setUpViews()
   
    }
    
    
    
    let segmentContr: UISegmentedControl = {
        let items = ["Stats", "Home", "Account"]
        let segmentContr = UISegmentedControl(items: items)
        segmentContr.tintColor = UIColor.white
        segmentContr.selectedSegmentIndex = 1
        segmentContr.layer.cornerRadius = 5
        segmentContr.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.ademBlue], for: .selected)
               
        segmentContr.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)

        segmentContr.backgroundColor = UIColor.ademBlue
               segmentContr.addTarget(self, action: #selector(switchSegViews), for: .valueChanged)
        return segmentContr
        
    }()
    
    
    func setUpAgain() {
        
     //SetUp views from own class
        //accountStuff = ProfileView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 225))
        
        let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
        
            accountTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        
        let layouts: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let profileCollectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layouts)
        
        accountTableView.register(UITableViewCell.self, forCellReuseIdentifier: tv)
        accountTableView.delegate = self
        accountTableView.dataSource = self
        
        self.view.addSubview(accountStuff)
        self.view.addSubview(friendsAndFamily)
        self.view.addSubview(segmentContr)
        self.view.addSubview(accountTableView)
        self.view.addSubview(profileCollectionView)
        
        accountTableView.layer.cornerRadius = 5
        
        accountTableView.translatesAutoresizingMaskIntoConstraints = false
        accountStuff.translatesAutoresizingMaskIntoConstraints = false
        segmentContr.translatesAutoresizingMaskIntoConstraints = false
        friendsAndFamily.translatesAutoresizingMaskIntoConstraints = false
        profileCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.layer.cornerRadius = 5
        
       
        
        diet.addButton.addTarget(self, action: #selector(addFriends), for: .touchDown)
        friendsAndFamily.addButton.addTarget(self, action: #selector(handleFriends), for: .touchDown)
        friendsAndFamily.nameofUser.text = "Kitchen Staff"
        diet.nameofUser.text = "Dietary"

        profileCollectionView.backgroundColor = UIColor.ademGreen

        profileCollectionView.register(accountPrivacyCellDesign.self, forCellWithReuseIdentifier: cellID)
        
     
     NSLayoutConstraint.activate([
        
        accountStuff.topAnchor.constraint(equalTo: view.topAnchor),
        accountStuff.widthAnchor.constraint(equalTo: view.widthAnchor),
        accountStuff.heightAnchor.constraint(equalToConstant: 225),
        accountStuff.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        segmentContr.topAnchor.constraint(equalTo: accountStuff.bottomAnchor, constant: 15),
        segmentContr.heightAnchor.constraint(equalToConstant: 25),
        segmentContr.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
        segmentContr.centerXAnchor.constraint(equalTo: accountStuff.centerXAnchor),
        
        friendsAndFamily.topAnchor.constraint(equalTo: segmentContr.bottomAnchor, constant: 15),
        friendsAndFamily.heightAnchor.constraint(equalToConstant: 100),
        friendsAndFamily.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
        friendsAndFamily.centerXAnchor.constraint(equalTo: segmentContr.centerXAnchor),
        
        accountTableView.topAnchor.constraint(equalTo: friendsAndFamily.bottomAnchor, constant: 15),
        accountTableView.heightAnchor.constraint(equalToConstant: 100),
        accountTableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
        accountTableView.centerXAnchor.constraint(equalTo: friendsAndFamily.centerXAnchor),
        
        profileCollectionView.topAnchor.constraint(equalTo: accountTableView.bottomAnchor, constant: 10),
        profileCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -10),
        profileCollectionView.centerXAnchor.constraint(equalTo:  view.centerXAnchor),
        profileCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        
     ])
        self.collectionView = profileCollectionView
     }
    
    @objc func switchSegViews() {
        
        switch segmentContr.selectedSegmentIndex {
        case 0:
            print("test 0")
        case 1:
            
            self.view.addSubview(diet)
            diet.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
            diet.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 5),
            diet.heightAnchor.constraint(equalToConstant: 100),
            diet.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            diet.centerXAnchor.constraint(equalTo: friendsAndFamily.centerXAnchor),
        ])
            
            print("test 1")
        default:
            print("test default")
        }
    }
    
    @objc func addFriends() {
        
        let alert = addedItemAlert()
        alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(alert, animated: true, completion: nil)
        print("Sending user to sign up Flow")
        
    }

    var firstNameListener: ListenerRegistration!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Nav bar is see through
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        //Nav bar is see through
        
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
        
        handleUserInfo()
       
        }
        
        private func handleUserInfo() {
            docRef = db.document("\(usersInfo)")
               
                   handle = firebaseAuth.addStateDidChangeListener { (auth, user) in
                       
                       var user = currentUser
                       if let user = user {
                           let nameOfUser = user.email
                           let photoURL = user.photoURL
                           let uid = user.uid
                           let name = user.displayName
                           self.accountStuff.nameofUser.text = nameOfUser
                           
                           //If use is logged in they can't sign in again
                           self.navigationItem.rightBarButtonItem = nil
                       } else {
                           let doesNotHaveAccount = "Chef"
                           self.accountStuff.nameofUser.text = doesNotHaveAccount
                           //CreateAccount
                           
                           let signInOrCreateAccount = UIBarButtonItem(image: UIImage(named: "CreateAccount"), style: .done, target: self, action: #selector(self.handelLogin))
                           self.navigationItem.rightBarButtonItem = signInOrCreateAccount
                       }
            }
        
        
        /*
        firstNameListener = docRef.addSnapshotListener { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
            let userNameData = docSnapshot.data()
            let usersName = userNameData?["FirstName"] as? String ?? ""
            self.accountStuff.nameofUser.text = "\(usersName)"
            print("\(usersName)")
        }
 */
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc func handelLogin() {
        let loginInfo = login()
        loginInfo.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginInfo, animated: true)
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
    var acctOptions = ["Account","Invite Friends","Rate Us","Apps","Settings","Log out"]
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return acctOptions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friends = tableView.dequeueReusableCell(withIdentifier: self.tv, for: indexPath)
        friends.backgroundColor = UIColor.ademBlue
        friends.textLabel!.textColor = UIColor.white
        friends.textLabel!.text = acctOptions[indexPath.row]
        
        return friends
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    //deque cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        switch indexPath.section {
            
        case 0:
            if indexPath.item == 0 {
                let friends = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                friends.accountPrivacyImages.image = UIImage(named: "lock")
                friends.accountPrivacyLabels.text = "Friends"
                friends.backgroundColor = UIColor.ademBlue
                friends.layer.cornerRadius = 5
                
                
                return friends
            } else {
                let devices = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                devices.accountPrivacyImages.image = UIImage(named: "lock")
                devices.accountPrivacyLabels.text = "Devices"
                devices.backgroundColor = UIColor.ademBlue
                devices.layer.cornerRadius = 5
                
                return devices
            }
            
        case 1:
            switch indexPath.item {
            case 0:
                let devices = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                devices.accountPrivacyImages.image = UIImage(named: "Settings")
                devices.accountPrivacyLabels.text = "Settings"
                devices.backgroundColor = UIColor.white
                devices.layer.cornerRadius = 5
                
                return devices
            case 1:
                let devices = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                devices.accountPrivacyImages.image = UIImage(named: "lock")
                devices.accountPrivacyLabels.text = "Health"
                devices.backgroundColor = UIColor.ademBlue
                devices.layer.cornerRadius = 5
                
                return devices
            case 2:
                let devices = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                devices.accountPrivacyImages.image = UIImage(named: "lock")
                devices.accountPrivacyLabels.text = "Apps"
                devices.backgroundColor = UIColor.ademBlue
                devices.layer.cornerRadius = 5
                
                return devices
            default:
                let settings = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
                settings.accountPrivacyLabels.text = "Settings"
                settings.backgroundColor = UIColor.ademBlue
                settings.layer.cornerRadius = 5
                return settings
            }
            
        case 2:
            let recipes = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
            recipes.accountPrivacyLabels.text = "Recipes"
            recipes.accountPrivacyImages.image = UIImage(named: "lock")
            recipes.backgroundColor = UIColor.ademBlue
            recipes.layer.cornerRadius = 5
            return recipes
            
        default:
            let settings = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! accountPrivacyCellDesign
            settings.accountPrivacyLabels.text = "Settings"
            settings.backgroundColor = UIColor.ademBlue
            settings.layer.cornerRadius = 15
            
            return settings
        }
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
    
    @objc func handleLogout() {
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        handelLogin()
    }
    
    @objc func handleHealth() {
        let cController = ProductVC(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(cController, animated: true)
        print("Settings Tab is active")
    }
    //Button actions - End
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            switch indexPath.item {
            case 0:
                handleFriends()
            case 1:
                handleSettings()
            default:
                handleHealth()
            }
        case 1:
            switch indexPath.item {
            case 0:
                handleDevices()
            case 1:
                handleDevices()
            case 2:
                handleHealth()
            default:
                handleHealth()
            }
        case 2:
            handleLogout()
        default:
            handleLogout()
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


