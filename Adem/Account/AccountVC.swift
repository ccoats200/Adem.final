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

    //MARK: For the QR scanner see OCR.swift QRScannerView
    
    //Cell Id's
    let cellId = "cellId0"
    let cellId2 = "cell1"
    let cellId3 = "cell2"
    let cellID = "cell3"
    let headerID = "test"
    let listOfSettingsOptions = "test"
    let ffCCellID = "reuse"
    let ffHeader = "header"
    
    //This needs to be firestoreDataClass for finding people in the home collection
    var friendsAssociated = friends
    
    
    var acctOptions = ["Recipies","Diet Preferences","Stores","Flavors","Rate Us","Settings"] //"Apps"]
    
    //MARK: Views to set up
    var personalAttributes = ProfileView()
    var homeSegmentView = homeView()
    var personalStats = statViews()
    var statsCollectionView: UICollectionView!
    var accountViewToSwitch: [UIView]!
    
    let collectionViewHeaderReuse = "Header"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavbar()
        
        view.backgroundColor = UIColor.white
        
        //MARK: QR code gene for households
        //https://www.hackingwithswift.com/example-code/media/how-to-create-a-qr-code
        /*This needs to link household and have the option for roomates or families.
         if roommies then put initials next to their items in the pantry.
         */
        
        setUptopViews()
        handleUserInfo()
        setUpdefaultSegment()
        
        //testing
        fetchUserPrivateInfo()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavbar()
        
        setUpdefaultSegment()
        handleUserInfo()

        if homeStatssegmentContr.selectedSegmentIndex == 0 {
            switchStatsViews()
        }
        
        //MARK: Nav bar is see through
        setUptopViews()
        
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
    
    
    func fetchUserPrivateInfo() {
        
        //FIXME: This is still using the old hierarchy
        userfirebaseHomeSettings.addSnapshotListener { documentSnapshot, error in
            
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            guard let data = document.data() else {
              print("Document data was empty.")
              return
            }
            privatehomeAttributes = data
          }
    }
    
    func setNavbar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    //MARK: - Button Action - Start
    @objc func handleRecipies() {
        let privacyController = friendsTVC()
        
        //FIXME: This is cutting off the top of the user image
        self.navigationController?.pushViewController(privacyController, animated: true)
    }
    
    
    
    @objc func handleDiet() {

        let moreController = updateDietPreferencesTwo()
        self.present(moreController, animated: true, completion: nil)
    }
    
    @objc func handleStores() {

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

        
        homeSegmentView.friendsAndFamily.showsHorizontalScrollIndicator = false
        homeSegmentView.friendsAndFamily.dataSource = self
        self.homeSegmentView.friendsAndFamily.delegate = self
        homeSegmentView.friendsAndFamily.register(ffCell.self, forCellWithReuseIdentifier: ffCCellID)
        homeSegmentView.friendsAndFamily.register(householdAdd.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ffHeader)
        
        homeSegmentView.accountTableView.delegate = self
        homeSegmentView.accountTableView.dataSource = self
        homeSegmentView.accountTableView.reloadData()
        homeSegmentView.accountTableView.layoutIfNeeded()
        homeSegmentView.accountTableView.register(UITableViewCell.self, forCellReuseIdentifier: listOfSettingsOptions)
        //https://stackoverflow.com/questions/41094672/increase-tableview-height-based-on-cells
        //This sets the height automatically
        
        homeSegmentView.accountTableView.heightAnchor.constraint(equalToConstant: homeSegmentView.accountTableView.contentSize.height).isActive = true
        homeSegmentView.accountTableView.estimatedRowHeight = 30
        homeSegmentView.accountTableView.rowHeight = UITableView.automaticDimension
        
        //MARK: - This needs to be avatars. IDC what type but they can't be people
        //https://kit.snapchat.com/docs/bitmoji-kit-ios
        //MARK: - Can I use the snap/bitmoji avatar? If so I must use
        
        //Household dimensions
        homeSegmentView.friendsAndFamily.contentInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)

        homeSegmentView.accountTableView.isScrollEnabled = false
        homeSegmentView.accountTableView.layer.cornerRadius = 5
        personalStats.backgroundColor = UIColor.white
        homeSegmentView.friendsAndFamily.translatesAutoresizingMaskIntoConstraints = false
        homeSegmentView.translatesAutoresizingMaskIntoConstraints = false
                
        accountViewToSwitch = [UIView]()
                
        accountViewToSwitch.append(homeSegmentView)
        accountViewToSwitch.append(personalStats)
        
        for v in accountViewToSwitch {
            view.addSubview(v)
            v.layer.cornerRadius = 5
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        view.bringSubviewToFront(accountViewToSwitch[0])
     
        NSLayoutConstraint.activate([
            
            personalStats.topAnchor.constraint(equalTo: homeStatssegmentContr.bottomAnchor, constant: 10),
            personalStats.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
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
            //Sign out text
            self.homeSegmentView.logOutButton.largeNextButton.setTitle("Sign Out", for: .normal)
            self.homeSegmentView.logOutButton.largeNextButton.backgroundColor = UIColor.clear
            self.homeSegmentView.logOutButton.largeNextButton.titleLabel?.textColor = UIColor.ademBlue
            //Sign out text
            
            //MARK: below is the old way to do it
            //db.collection("Users").document(currentUser!.uid).collection("private").getDocuments { (snapshot, err) in
            self.personalAttributes.nameofUser.largeNextButton.setTitle("\(defaults.value(forKey: "FirstName")!)", for: .normal)
            self.personalAttributes.nameofUser.largeNextButton.addTarget(self, action: #selector(self.editUserInfo), for: .touchDown)

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
            //This is a list of liked meals
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
    
    private var detailsTransitioningDelegate: halfwayControllerTransitioningDelegate!
    //Search Button
    @objc func handleAddPerson() {
        let alert = addHomeMember()
        detailsTransitioningDelegate = halfwayControllerTransitioningDelegate(from: self, to: alert)
        alert.modalPresentationStyle = UIModalPresentationStyle.custom
        alert.transitioningDelegate = detailsTransitioningDelegate
        self.present(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AccountVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Must us a Supplementary view
        //https://developer.apple.com/documentation/uikit/uicollectionview
        return friendsAssociated.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let personCell = collectionView.dequeueReusableCell(withReuseIdentifier: ffCCellID, for: indexPath) as! ffCell
        let houseMembers = friendsAssociated[indexPath.item]
        
        personCell.personImageView.image = UIImage(named: (houseMembers.friendImage)!)
        personCell.personName.text = houseMembers.friendName
        return personCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Pop up of remove from household for now")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //https://www.thetopsites.net/article/52167601.shtml
        //https://stackoverflow.com/questions/29655652/how-to-make-both-header-and-footer-in-collection-view-with-swift
        
        var reusableView : UICollectionReusableView? = nil

        // Create header
        if (kind == UICollectionView.elementKindSectionHeader) {
            // Create Header
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ffHeader, for: indexPath) as! householdAdd
            headerView.addFam.largeNextButton.addTarget(self, action: #selector(handleAddPerson), for: .touchDown)
            //headerView.householdName.largeNextButton.addTarget(self, action: #selector(handleAddPerson), for: .touchDown)

            reusableView = headerView
        }
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //MARK: Changes the size of the image in pantry
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        //MARK: header
            return CGSize(width: collectionView.frame.width - 10, height: 30.0)
    }
    
    
}

class householdAdd: UICollectionReusableView {
    
    
    var addFam = navigationButton()
    //Label should be pulling from firebase but the firebase should populate from the text field
    var homeName: UILabel = {
        var homeNickName = UILabel()
        homeNickName.textAlignment = .left
        homeNickName.textColor = UIColor.white
        homeNickName.font = UIFont(name: hNBold, size: 20.0)
        homeNickName.translatesAutoresizingMaskIntoConstraints = false
        return homeNickName
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myCustomInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.myCustomInit()
    }
    

    func myCustomInit() {
        self.addSubview(addFam)
        self.addSubview(homeName)
        //Will need to update user defauls when changed. snapshotlistner
        homeName.text = "\(defaults.value(forKey: "homeName")!)"//addHomeMember().addChangeHomeName.text//AccountVC().nameOfHouse
        addFam.largeNextButton.backgroundColor = UIColor.ademGreen
        addFam.largeNextButton.layer.cornerRadius = 15
        //Not finding image
        addFam.largeNextButton.setBackgroundImage(UIImage(named: "greenAddButton"), for: .normal)
        //MARK: THE BEV
        addFam.translatesAutoresizingMaskIntoConstraints = false
        homeName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            homeName.topAnchor.constraint(equalTo: self.topAnchor),
            homeName.heightAnchor.constraint(equalTo: self.heightAnchor),
            homeName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            homeName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            homeName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
           
            addFam.topAnchor.constraint(equalTo: self.topAnchor),
            addFam.heightAnchor.constraint(equalToConstant: 30),//self.heightAnchor),
            addFam.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            addFam.widthAnchor.constraint(equalToConstant: 30),
            addFam.centerYAnchor.constraint(equalTo: homeName.centerYAnchor),
        ])
    }
}
