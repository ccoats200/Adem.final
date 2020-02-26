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
    
    
   
    //This needs a recipies button at the bottom. prominant. recipies can be listed as share with everyone or just friends or no one. Good for user generated content.
    //for now no chat setting for sending recipies easily.
    //the recipie will be photographed and in a table view, users can choose a generic pic for it. computer graphic or take a pic
    
    
    //Cell Id's
    let cellId = "cellId0"
    let cellId2 = "cell1"
    let cellId3 = "cell2"
    let cellID = "cell3"
    let headerID = "test"
    let listOfSettingsOptions = "test"
    
    //MARK: Views to set up
    var accountStuff = ProfileView()
    var friendsAndFamily = fAndFView()
    var diet = fAndFView()
    var statsCollectionView: UICollectionView!
    var accountTableView: UITableView!

    var accountStats = statsElements()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        view.backgroundColor = UIColor.white
        
        setUptopViews()
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
        
        segmentContr.topAnchor.constraint(equalTo: accountStuff.bottomAnchor, constant: 15),
        segmentContr.heightAnchor.constraint(equalToConstant: 25),
        segmentContr.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
        segmentContr.centerXAnchor.constraint(equalTo: accountStuff.centerXAnchor),
        
        ])
        
    }
    
    var accountViewToSwitch: [UIView]!
    var personalStats = statViews()
    
    func setUpAgain() {
        
     //SetUp views from own class
        //accountStuff = ProfileView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 225))
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        accountTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        
        accountTableView.register(UITableViewCell.self, forCellReuseIdentifier: listOfSettingsOptions)
        accountTableView.delegate = self
        accountTableView.dataSource = self
        
        accountTableView.estimatedRowHeight = UITableView.automaticDimension
        
        accountViewToSwitch = [UIView]()
        
        let backgroundView = UIView()
        
        accountViewToSwitch.append(backgroundView)
        accountViewToSwitch.append(personalStats)
        
        for v in accountViewToSwitch {
            view.addSubview(v)
            v.layer.cornerRadius = 5
            v.translatesAutoresizingMaskIntoConstraints = false
                    }
        view.bringSubviewToFront(accountViewToSwitch[0])
        
        backgroundView.addSubview(friendsAndFamily)
        backgroundView.addSubview(accountTableView)
        //backgroundView.addSubview(diet)
        
        accountTableView.isScrollEnabled = false
        accountTableView.backgroundColor = UIColor.red
        backgroundView.backgroundColor = UIColor.white
        
        personalStats.backgroundColor = UIColor.white
        accountTableView.translatesAutoresizingMaskIntoConstraints = false
        friendsAndFamily.translatesAutoresizingMaskIntoConstraints = false
        //diet.translatesAutoresizingMaskIntoConstraints = false

        
        diet.addButton.addTarget(self, action: #selector(updateDiet), for: .touchDown)
        friendsAndFamily.addButton.addTarget(self, action: #selector(handleFriends), for: .touchDown)
        friendsAndFamily.nameofUser.text = "Kitchen Staff"
        diet.nameofUser.text = "Dietary"

        
     
     NSLayoutConstraint.activate([
        
        backgroundView.topAnchor.constraint(equalTo: segmentContr.bottomAnchor, constant: 15),
        backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
        backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
        backgroundView.centerXAnchor.constraint(equalTo: segmentContr.centerXAnchor),
        
        personalStats.topAnchor.constraint(equalTo: backgroundView.topAnchor),
        personalStats.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        personalStats.widthAnchor.constraint(equalTo: backgroundView.widthAnchor),
        personalStats.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
        
        
        friendsAndFamily.topAnchor.constraint(equalTo: backgroundView.topAnchor),
        friendsAndFamily.heightAnchor.constraint(equalToConstant: 100),
        friendsAndFamily.widthAnchor.constraint(equalTo: backgroundView.widthAnchor),
        friendsAndFamily.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
        
        accountTableView.topAnchor.constraint(equalTo: friendsAndFamily.bottomAnchor, constant: 15),
        accountTableView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
        accountTableView.widthAnchor.constraint(equalTo: backgroundView.widthAnchor),
        accountTableView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
 
     ])
     }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
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

    var firstNameListener: ListenerRegistration!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpAgain()


        if segmentContr.selectedSegmentIndex == 0 {
            //switchSegViews()
            switchStatsViews()
//            accountStats.isHidden = true
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
        let friends = tableView.dequeueReusableCell(withIdentifier: self.listOfSettingsOptions, for: indexPath)
        friends.backgroundColor = UIColor.ademBlue
        friends.textLabel!.textColor = UIColor.white
        friends.textLabel!.text = acctOptions[indexPath.row]
        
        return friends
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.row {
        case 0:
            handleFriends()
        case 1:
            handleSettings()
        case 2:
            handleFriends()
        case 3:
            handleDevices()
        default:
            handleLogout()
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
//        let cController = ProductVC(collectionViewLayout: UICollectionViewFlowLayout())
//        self.navigationController?.pushViewController(cController, animated: true)
        print("Settings Tab is active")
    }
    //Button actions - End
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


