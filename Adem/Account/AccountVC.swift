//
//  AccountVC.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AccountVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //Cell Id's
    let cellId = "cellId0"
    let cellId2 = "cell1"
    let cellId3 = "cell2"
    let cellID = "cell3"
    let headerID = "test"
    let listOfSettingsOptions = "test"
    let ffCCellID = "test"
    var friendsAssociated = friends
    
    var acctOptions = ["Recipies","Diet Preferences","Stores","Flavors","Invite Friends","Rate Us","Settings"] //"Apps"]
    
    //MARK: Views to set up
    var personalAttributes = ProfileView()
    var homeSegmentView = homeView()
    var personalStats = statViews()
    var statsCollectionView: UICollectionView!
    var accountViewToSwitch: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        view.backgroundColor = UIColor.white
        
//        self.homeSegmentView.accountTableView.estimatedRowHeight = 60
//        self.homeSegmentView.accountTableView.rowHeight = UITableView.automaticDimension
        
        
        setUptopViews()
        handleUserInfo()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        setUpdefaultSegment()
        handleUserInfo()

        if homeStatssegmentContr.selectedSegmentIndex == 0 {
            switchStatsViews()
        }
        
        //MARK: Nav bar is see through
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        //MARK: Nav bar is see through
        
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
        
        handleUserInfo()
        
        handle = firebaseAuth.addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.sendToLogIn()
            } else {
                print("User is logged in")
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        handleUserInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        firebaseAuth.removeStateDidChangeListener(handle!)
    }
    
    //MARK: - Button Action - Start
    @objc func handleRecipies() {
        let privacyController = friendsTVC()
        self.navigationController?.pushViewController(privacyController, animated: true)
    }
    
    @objc func handleDiet() {
//        let cController = settings()
//        cController.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(cController, animated: true)
        let moreController = updateDietPreferencesTwo()
        self.present(moreController, animated: true, completion: nil)
    }
    
    @objc func handleStores() {
//        let cController = SettingTVC()
//        self.navigationController?.pushViewController(cController, animated: true)
        let storesUpdate = updateStorePreferencesTwo()
        self.present(storesUpdate, animated: true, completion: nil)
    }
    
    @objc func handleFlavors() {

        let signUpInfos = updateFlavorPreferences()
        self.present(signUpInfos, animated: true, completion: nil)
    }

    
    @objc func editUserInfo() {
        self.dismiss(animated: true, completion: nil)
        //This works but I think is fucked
        print("testing this")
       }
    
    @objc func handelLogin() {
        let loginUser = login()
        loginUser.hidesBottomBarWhenPushed = true
        self.present(loginUser, animated: true, completion: nil)
    }
    
    @objc func signUp() {
        let loginInfo = UserInfo()
        loginInfo.hidesBottomBarWhenPushed = true
        self.present(loginInfo, animated: true, completion: nil)
    }
    
    @objc func switchStatsViews() {
        self.view.bringSubviewToFront(accountViewToSwitch[homeStatssegmentContr.selectedSegmentIndex])
    }
    
    @objc func updateDiet() {
        
        let alert = addedItemAlert()
        alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(alert, animated: true, completion: nil)
        print("Sending user to sign up Flow")
        
    }
    //MARK: - Button actions - End
    
    
    let homeStatssegmentContr: UISegmentedControl = {
        let items = ["Home", "Stats"]
        let segmentContr = UISegmentedControl(items: items)
        segmentContr.tintColor = UIColor.white
        segmentContr.selectedSegmentIndex = 0
        segmentContr.layer.cornerRadius = 5
        segmentContr.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.ademBlue], for: .selected)
               
        segmentContr.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)

        segmentContr.backgroundColor = UIColor.ademBlue
               segmentContr.addTarget(self, action: #selector(switchStatsViews), for: .valueChanged)
        return segmentContr
        
    }()
    
    func setUptopViews() {
        
        self.view.addSubview(personalAttributes)
        self.view.addSubview(homeStatssegmentContr)
        personalAttributes.translatesAutoresizingMaskIntoConstraints = false
        homeStatssegmentContr.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            personalAttributes.topAnchor.constraint(equalTo: view.topAnchor),
            personalAttributes.widthAnchor.constraint(equalTo: view.widthAnchor),
            personalAttributes.heightAnchor.constraint(equalToConstant: 225),
            personalAttributes.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            homeStatssegmentContr.topAnchor.constraint(equalTo: personalAttributes.bottomAnchor),
            homeStatssegmentContr.heightAnchor.constraint(equalToConstant: 25),
            homeStatssegmentContr.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            homeStatssegmentContr.centerXAnchor.constraint(equalTo: personalAttributes.centerXAnchor),
        ])
    }
    
    func setUpdefaultSegment() {

        homeSegmentView.accountTableView.register(UITableViewCell.self, forCellReuseIdentifier: listOfSettingsOptions)
        homeSegmentView.accountTableView.delegate = self
        homeSegmentView.accountTableView.dataSource = self
        homeSegmentView.friendsAndFamily.dataSource = self
        homeSegmentView.friendsAndFamily.delegate = self
        homeSegmentView.friendsAndFamily.register(ffCell.self, forCellWithReuseIdentifier: ffCCellID)
        
//        homeSegmentView.accountTableView.estimatedRowHeight = 60
//        homeSegmentView.accountTableView.rowHeight = UITableView.automaticDimension
        
                
        accountViewToSwitch = [UIView]()
                
        accountViewToSwitch.append(homeSegmentView)
        accountViewToSwitch.append(personalStats)
        
        for v in accountViewToSwitch {
            view.addSubview(v)
            v.layer.cornerRadius = 5
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        view.bringSubviewToFront(accountViewToSwitch[0])
        
        homeSegmentView.accountTableView.isScrollEnabled = false
        homeSegmentView.accountTableView.layer.cornerRadius = 5
        personalStats.backgroundColor = UIColor.white
        homeSegmentView.translatesAutoresizingMaskIntoConstraints = false
        
//        homeSegmentView.friendsAndFamily.addButton.addTarget(self, action: #selector(handleFriends), for: .touchDown)
//        homeSegmentView.friendsAndFamily.nameofUser.text = "Kitchen Staff"
     
     NSLayoutConstraint.activate([
        personalStats.topAnchor.constraint(equalTo: homeStatssegmentContr.bottomAnchor, constant: 15),
        personalStats.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        personalStats.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
        personalStats.centerXAnchor.constraint(equalTo: homeStatssegmentContr.centerXAnchor),
        
        homeSegmentView.topAnchor.constraint(equalTo: personalStats.topAnchor),
        homeSegmentView.heightAnchor.constraint(equalTo: personalStats.heightAnchor),
        homeSegmentView.widthAnchor.constraint(equalTo: personalStats.widthAnchor),
        homeSegmentView.centerXAnchor.constraint(equalTo: personalStats.centerXAnchor),
     ])
        //MARK: Sign Out
        signOutButton()
    }
    
    //MARK: - Sign out
    func signOutButton() {
        homeSegmentView.logOutButton.largeNextButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        homeSegmentView.logOutButton.largeNextButton.titleLabel?.font = UIFont(name: helNeu, size: 20)
    }
    
    @objc func handleLogout() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { action -> Void in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action -> Void in }))
        present(alertController, animated: true, completion: nil)
    }
    
    func signOut() {
        do {
            //FIXME: This isn't working for some reason. if a user signs in on a diff account right after signing out they get the old account
            try firebaseAuth.signOut()
//            sendToLogIn()
            //https://www.youtube.com/watch?v=76ANW9VJwCQ
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    //MARK: - Sign out
    

    func handleUserInfo() {
        
        self.homeSegmentView.logOutButton.largeNextButton.backgroundColor = UIColor.clear
        //handle = firebaseAuth.addStateDidChangeListener { (auth, user) in
               
        if currentUser?.isAnonymous == true {
            let doesNotHaveAccount = "Join now"
            self.personalAttributes.nameofUser.largeNextButton.setTitle(doesNotHaveAccount, for: .normal)
            self.personalAttributes.nameofUser.largeNextButton.setTitleColor(UIColor.white, for: .normal)
            self.personalAttributes.nameofUser.largeNextButton.backgroundColor = UIColor.ademGreen
            self.personalAttributes.nameofUser.largeNextButton.addTarget(self, action: #selector(self.signUp), for: .touchDown)
            self.homeSegmentView.logOutButton.largeNextButton.setTitle("Sign In", for: .normal)
            self.homeSegmentView.logOutButton.largeNextButton.addTarget(self, action: #selector(self.handelLogin), for: .touchDown)
        } else if currentUser == nil {
            sendToLogIn()
        } else {
            
            print("this is the current user \(currentUser!.email)")
            //handle = firebaseAuth.addStateDidChangeListener { (auth, user) in
               //Probably wrong
            //db.collection("Users").document(user!.uid).collection("private").getDocuments { (snapshot, err) in
            db.collection("Users").document(currentUser!.uid).collection("private").getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in snapshot!.documents {
                        let latMax = document.get("FirstName") as? String
                        self.homeSegmentView.logOutButton.largeNextButton.setTitle("Sign Out", for: .normal)
                        self.homeSegmentView.logOutButton.largeNextButton.backgroundColor = UIColor.clear
                        self.homeSegmentView.logOutButton.largeNextButton.titleLabel?.textColor = UIColor.ademBlue
                        self.personalAttributes.nameofUser.largeNextButton.setTitle(latMax, for: .normal)
                        self.personalAttributes.nameofUser.largeNextButton.addTarget(self, action: #selector(self.editUserInfo), for: .touchDown)
                    }
                }
            }
        }
    }
    

    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acctOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let friends = tableView.dequeueReusableCell(withIdentifier: self.listOfSettingsOptions, for: indexPath)
        friends.backgroundColor = UIColor.ademBlue
        friends.textLabel!.textColor = UIColor.white
        friends.textLabel!.text = acctOptions[indexPath.row]
        friends.accessoryType = .disclosureIndicator
        //friends.textLabel?.lineBreakMode = .byWordWrapping
        
        return friends
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let c = acctOptions.count
//        let buttons = [handleRecipies(),handleDiet(),handleStores(),handleFlavors(),handleRecipies(),handleRecipies()]
//
//        for i in  1..<c {
//            if indexPath.row == i {
//                buttons[i]
//            }
//        }
        switch indexPath.row {
        case 0:
            handleRecipies()
            homeSegmentView.accountTableView.deselectRow(at: indexPath, animated: false)
        case 1:
            handleDiet()
            homeSegmentView.accountTableView.deselectRow(at: indexPath, animated: false)

        case 2:
            handleStores()
            homeSegmentView.accountTableView.deselectRow(at: indexPath, animated: false)

        case 3:
            handleFlavors()
            homeSegmentView.accountTableView.deselectRow(at: indexPath, animated: false)

        default:
            handleDiet()
            homeSegmentView.accountTableView.deselectRow(at: indexPath, animated: false)

        }
    }
    
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



extension AccountVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return friendsAssociated.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let personCell = collectionView.dequeueReusableCell(withReuseIdentifier: ffCCellID, for: indexPath) as! ffCell
        personCell.friendsInAccount = friendsAssociated[indexPath.item]
        return personCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //MARK: Changes the size of the image in pantry
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
