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
    
    //MARK: Views to set up
    var accountStuff = ProfileView()
    var homeSegmentView = homeView()
    var statsCollectionView: UICollectionView!
    var accountViewToSwitch: [UIView]!
    var personalStats = statViews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        view.backgroundColor = UIColor.white
        
        setUptopViews()
        handleUserInfo()
        
    }
    
    let segmentContr: UISegmentedControl = {
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
        self.view.addSubview(accountStuff)
        self.view.addSubview(segmentContr)
        
        accountStuff.translatesAutoresizingMaskIntoConstraints = false
        segmentContr.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
        
        accountStuff.topAnchor.constraint(equalTo: view.topAnchor),
        accountStuff.widthAnchor.constraint(equalTo: view.widthAnchor),
        accountStuff.heightAnchor.constraint(equalToConstant: 225),
        accountStuff.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        segmentContr.topAnchor.constraint(equalTo: accountStuff.bottomAnchor),
        segmentContr.heightAnchor.constraint(equalToConstant: 25),
        segmentContr.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
        segmentContr.centerXAnchor.constraint(equalTo: accountStuff.centerXAnchor),
        
        ])
        
    }
    
    
    let ffCCellID = "test"
    
    func setUpAgain() {

        homeSegmentView.accountTableView.register(UITableViewCell.self, forCellReuseIdentifier: listOfSettingsOptions)
        homeSegmentView.accountTableView.delegate = self
        homeSegmentView.accountTableView.dataSource = self
        homeSegmentView.friendsAndFamily.dataSource = self
        homeSegmentView.friendsAndFamily.delegate = self
        homeSegmentView.friendsAndFamily.register(ffCell.self, forCellWithReuseIdentifier: ffCCellID)
        
//        homeSegmentView.accountTableView.rowHeight = 90//UITableView.automaticDimension
        
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

        personalStats.topAnchor.constraint(equalTo: segmentContr.bottomAnchor, constant: 15),
        personalStats.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        personalStats.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
        personalStats.centerXAnchor.constraint(equalTo: segmentContr.centerXAnchor),
        
        homeSegmentView.topAnchor.constraint(equalTo: personalStats.topAnchor),
        homeSegmentView.heightAnchor.constraint(equalTo: personalStats.heightAnchor),
        homeSegmentView.widthAnchor.constraint(equalTo: personalStats.widthAnchor),
        homeSegmentView.centerXAnchor.constraint(equalTo: personalStats.centerXAnchor),
        
     ])
        logoutButton()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }
  
    var firstNameListener: ListenerRegistration!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpAgain()

        if segmentContr.selectedSegmentIndex == 0 {
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
       
        }

    private func handleUserInfo() {


        handle = firebaseAuth.addStateDidChangeListener { (auth, user) in

            if user?.isAnonymous != true {
                db.collection("Users").document(user!.uid).collection("private").getDocuments { (snapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
    
                    } else {
                        for document in snapshot!.documents {
                            let latMax = document.get("FirstName") as? String
                            self.accountStuff.nameofUser.largeNextButton.setTitle(latMax, for: .normal)
                            self.accountStuff.nameofUser.largeNextButton.addTarget(self, action: #selector(self.editUserInfo), for: .touchDown)
                            self.homeSegmentView.logOutButton.largeNextButton.setTitle("Log Out", for: .normal)
                        }
                    }
                }
            } else {
                let doesNotHaveAccount = "Join now"
                self.accountStuff.nameofUser.largeNextButton.setTitle(doesNotHaveAccount, for: .normal)
                self.accountStuff.nameofUser.largeNextButton.setTitleColor(UIColor.white, for: .normal)
                self.accountStuff.nameofUser.largeNextButton.backgroundColor = UIColor.ademGreen
                self.accountStuff.nameofUser.largeNextButton.addTarget(self, action: #selector(self.handelLogin), for: .touchDown)
                self.homeSegmentView.logOutButton.largeNextButton.setTitle("Log In", for: .normal)
                self.homeSegmentView.logOutButton.largeNextButton.addTarget(self, action: #selector(self.handelLogin), for: .touchDown)
                
                
            }
        }
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    var acctOptions = ["Recipies","Diet","Invite Friends","Rate Us","Apps","Settings"]
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
        
        return friends
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
       
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.row {
        case 0:
            handleFriends()
            homeSegmentView.accountTableView.deselectRow(at: indexPath, animated: false)
        case 1:
            handleSettings()
            homeSegmentView.accountTableView.deselectRow(at: indexPath, animated: false)

        case 2:
            handleFriends()
            homeSegmentView.accountTableView.deselectRow(at: indexPath, animated: false)

        case 3:
            handleDevices()
            homeSegmentView.accountTableView.deselectRow(at: indexPath, animated: false)

        default:
            handleDevices()
            homeSegmentView.accountTableView.deselectRow(at: indexPath, animated: false)

        }
    }
    
    //MARK: Button Action - Start
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
        print("Settings Tab is active")
    }
    @objc func editUserInfo() {
           print("tester")
       }
    
    @objc func handelLogin() {
        let loginInfo = login()
        loginInfo.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginInfo, animated: true)
    }
    
    @objc fileprivate func switchStatsViews() {
        
            self.view.bringSubviewToFront(accountViewToSwitch[segmentContr.selectedSegmentIndex])
    }
    
    @objc func updateDiet() {
        
        let alert = addedItemAlert()
        alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(alert, animated: true, completion: nil)
        print("Sending user to sign up Flow")
        
    }
    
    func logoutButton() {
        homeSegmentView.logOutButton.largeNextButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
    }
    //MARK: Button actions - End
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    var friendsAssociated = friends
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
