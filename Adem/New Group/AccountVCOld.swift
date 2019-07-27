//
//  AccountVCOld.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

//import Foundation
//import UIKit
//import Firebase
//import CoreBluetooth
//
//
//
//class profileVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    let friendsCell = "friends Cell"
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        friendsCollectionView.register(userImageSection.self, forCellWithReuseIdentifier: friendsCell)
//
//
//        navigationItem.title = "Profile"
//
//        view.backgroundColor = UIColor.white
//
//        setupViews()
//    }
//
//
//
//    func setupViews(){
//        //addSubview(collectionView)
//        view.addSubview(friendsCollectionView)
//        view.addSubview(userProfileImag)
//
//
//
//
//        friendsCollectionView.delegate = self
//        friendsCollectionView.dataSource = self
//
//        userProfileImag.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        userProfileImag.widthAnchor.constraint(equalToConstant: 125).isActive = true
//        userProfileImag.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
//        userProfileImag.heightAnchor.constraint(equalToConstant: 125).isActive = true
//
//        //Friends collection view cell
//        friendsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        friendsCollectionView.widthAnchor.constraint(equalToConstant: 125).isActive = true
//        friendsCollectionView.topAnchor.constraint(equalTo: userProfileImag.bottomAnchor, constant: 15).isActive = true
//        friendsCollectionView.heightAnchor.constraint(equalToConstant: 125).isActive = true
//    }
//
//    //let stackView = UIStackView()
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: friendsCell, for: indexPath)
//
//        return cell
//    }
//
//
//    //UIView Profile Pic
//    let userProfileImag: UIImageView = {
//        let upi = UIImageView()
//
//        upi.backgroundColor = UIColor.blue
//        upi.image = UIImage(named: "eggs")
//        upi.layer.cornerRadius = 62.5
//        upi.layer.masksToBounds = true
//        upi.clipsToBounds = true
//        upi.layer.borderWidth = 2
//        upi.layer.borderColor = UIColor.ademGreen.cgColor
//        upi.translatesAutoresizingMaskIntoConstraints = false
//
//        return upi
//    }()
//
//    let friendsCollectionView: UICollectionView = {
//        let friendView = UICollectionView()
//        friendView.backgroundColor = UIColor.black
//
//        return friendView
//    }()
//
//
//
//}
//
//
//
//// Variation
//
///*
//class AccountVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//
//    //Cell Id's
//    let cellId = "cellId0"
//    let cellId2 = "cell1"
//    let cellId3 = "cell2"
//
//
//    var db: Firestore!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let settings = FirestoreSettings()
//
//        Firestore.firestore().settings = settings
//        // [END setup]
//        db = Firestore.firestore()
//
//
//        collectionView.isScrollEnabled = false
//
//        view.backgroundColor = .white
//
//        let titleText = UILabel()
//        titleText.text = "Account"
//        titleText.font = UIFont(name: "Lato", size: 40)
//        titleText.font = UIFont.boldSystemFont(ofSize: 20)
//        titleText.textColor = UIColor.white
//        navigationItem.titleView = titleText
//
//        //Family cell
//        collectionView.register(familySection.self, forCellWithReuseIdentifier: cellId)
//        //register collection view cell class
//
//        //Device Cell
//        collectionView.register(deviceSection.self, forCellWithReuseIdentifier: cellId2)
//
//        //Setting Cell
//        collectionView.register(privacySection.self, forCellWithReuseIdentifier: cellId3)
//
//
//
//
//        setupViews() //setup all views
//
//
//    }
//
//
//
//    let sView: UIView = {
//        let seperate = UIView()
//        //seperate.layer.borderWidth = 2
//        //seperate.backgroundColor = UIColor.red
//        print("sets the seperator color")
//        return seperate
//
//    }()
//
//    func setupViews() {
//
//        //view.addSubview(AccountView)
//        view.addSubview(collectionView) // add collection view to view controller
//        view.addSubview(userProfileImag)
//
//        collectionView.delegate = self // set delegate
//        collectionView.dataSource = self //set data source
//
//
//        //AccountView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        //AccountView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        //AccountView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        //AccountView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//
//        userProfileImag.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        userProfileImag.widthAnchor.constraint(equalToConstant: 125).isActive = true
//        userProfileImag.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
//        userProfileImag.heightAnchor.constraint(equalToConstant: 125).isActive = true
//
//
//
//        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true //set the location of collection view
//        collectionView.topAnchor.constraint(equalTo: userProfileImag.bottomAnchor).isActive = true // top anchor of collection view
//        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true // height
//        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true // width
//
//    }
//
//    //UIView Profile Pic
//    let userProfileImag: UIImageView = {
//        let upi = UIImageView()
//
//        upi.backgroundColor = UIColor.blue
//        upi.image = UIImage(named: "eggs")
//        upi.layer.cornerRadius = 62.5
//        upi.layer.masksToBounds = true
//        upi.clipsToBounds = true
//        upi.layer.borderWidth = 2
//        upi.layer.borderColor = UIColor.blue.cgColor
//        //upi.layer.borderColor = UIColor.ademGreen.cgColor
//        upi.translatesAutoresizingMaskIntoConstraints = false
//
//        return upi
//    }()
//
//    let collectionView: UICollectionView = { // collection view to be added to view controller
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()); //zero size with flow layout
//        cv.translatesAutoresizingMaskIntoConstraints = false; //set it to false so that we can suppy constraints
//        cv.backgroundColor = .white // test
//        return cv
//
//    }()
//
//    //deque cell
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//
//
//        switch indexPath.section {
//        case 0:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//            return cell
//
//        case 1:
//            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath)
//            return cell2
//
//        case 2:
//
//            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: cellId3, for: indexPath)
//            return cell3
//
//
//        default:
//            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellId3, for: indexPath);
//            return cell2
//        }
//    }
//
//    // number of cells
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//        return 3
//
//    }
//
//    //inset allocation
//
//    let sectionInsets = UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
//
//    //trying to get spacing betweenc cells
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//        return sectionInsets.bottom
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return sectionInsets
//    }
//
//
//
//    //size of each CollecionViewCell
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        switch indexPath.section {
//        case 0:
//            let size = CGSize(width: view.frame.width - 10, height: 125) //125
//            return size
//
//        case 1:
//            let size1 = CGSize(width: view.frame.width - 10, height: 90)
//            return size1
//
//        case 2:
//            let size2 = CGSize(width: view.frame.width - 10, height: 90)
//            return size2
//
//        default:
//            let defaults = CGSize(width: view.frame.width - 10, height: 110)
//            return defaults
//        }
//    }
//}
//
//
//
//
//*/

