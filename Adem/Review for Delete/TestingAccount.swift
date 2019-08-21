//
//  TestingAccount.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

/*
 import Foundation
 import UIKit
 import Firebase
 import CoreBluetooth
 
 
 
 // first UICollectionViewCell
 class userImageSection: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
 let cellId = "CellId"; // same as above unique id
 
 override init(frame: CGRect) {
 super.init(frame: frame);
 
 
 
 
 setupViews()
 
 collectionView.register(AccountCell.self, forCellWithReuseIdentifier: cellId); //register custom UICollectionViewCell class.
 // Here I am not using any custom class
 collectionView.contentInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
 }
 
 func setupViews(){
 //addSubview(collectionView)
 
 addSubview(userProfileImag)
 
 
 collectionView.delegate = self;
 collectionView.dataSource = self;
 
 //collectionView.addConstraintsWithFormats(format: "H:|[v0]|", views: collectionView)
 
 //collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true;
 //collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true;
 //collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true;
 //collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true;
 
 userProfileImag.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
 userProfileImag.widthAnchor.constraint(equalToConstant: 125).isActive = true
 userProfileImag.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
 userProfileImag.heightAnchor.constraint(equalToConstant: 125).isActive = true
 }
 
 //UIView Profile Pic
 let userProfileImag: UIImageView = {
 let upi = UIImageView()
 
 upi.backgroundColor = UIColor.blue
 upi.image = UIImage(named: "eggs")
 upi.layer.cornerRadius = 62.5
 upi.layer.masksToBounds = true
 upi.clipsToBounds = true
 upi.layer.borderWidth = 2
 upi.layer.borderColor = UIColor.ademGreen.cgColor
 upi.translatesAutoresizingMaskIntoConstraints = false
 
 return upi
 }()
 
 //Profile Image background
 let collectionView: UICollectionView = {
 let layout = UICollectionViewFlowLayout()
 layout.scrollDirection = .horizontal //set scroll direction to horizontal
 let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
 cv.backgroundColor = .blue //testing
 cv.layer.cornerRadius = 30
 
 cv.translatesAutoresizingMaskIntoConstraints = false
 return cv
 }()
 
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
 //cell.backgroundView = UIImageView(image: profilepic)
 cell.clipsToBounds = true
 
 //cell.layer.cornerRadius = 60
 
 return cell
 }
 
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
 return 1
 
 }
 
 
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
 let cell0 = CGSize(width: self.frame.width, height: self.frame.height - 10)
 
 return cell0
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 }
 
 //Second cell
 class familySection: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
 let cellId2 = "cell2" // same as above unique id
 let addFamily = "addFamily"
 
 let famMembers =  ["1","2","3"]
 
 
 
 override init(frame: CGRect) {
 super.init(frame: frame);
 
 setupViews();
 
 //MARK: Cell configuration at section
 collectionView.register(familyCells.self, forCellWithReuseIdentifier: cellId2)
 
 // Here I am not using any custom class
 
 collectionView.contentInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
 
 
 
 //styling of the cell border
 collectionView.layer.borderWidth = 2.0
 collectionView.layer.borderColor = UIColor.ademGreen.cgColor
 
 
 }
 
 
 func setupViews(){
 addSubview(collectionView);
 
 collectionView.delegate = self;
 collectionView.dataSource = self;
 
 collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true;
 collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true;
 collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true;
 collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true;
 }
 
 let collectionView: UICollectionView = {
 
 let layout = UICollectionViewFlowLayout();
 layout.scrollDirection = .horizontal; //set scroll direction to horizontal
 
 let cv = UICollectionView(frame: .zero, collectionViewLayout: layout);
 
 //testing
 cv.backgroundColor = .white
 cv.layer.cornerRadius = 10
 cv.translatesAutoresizingMaskIntoConstraints = false;
 return cv
 }()
 
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
 let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! familyCells
 firstCell.backgroundColor = .blue
 firstCell.layer.cornerRadius = 46.5
 return firstCell
 
 
 /*
 switch indexPath.row {
 case 0...famMembers.count:
 let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! familyCells
 firstCell.backgroundColor = .blue
 firstCell.layer.cornerRadius = 40
 return firstCell
 default:
 let fourthCell = collectionView.dequeueReusableCell(withReuseIdentifier: addFamily, for: indexPath) as! deviceCells
 //fourthCell.backgroundColor = .green
 fourthCell.layer.cornerRadius = 50
 
 return fourthCell
 }
 */
 
 }
 
 
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
 
 
 let test = famMembers.count
 
 return test
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
 
 let cell0 = CGSize(width: self.frame.width/4, height: self.frame.height - 10)
 
 return cell0
 
 }
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 }
 
 //Third cell
 class deviceSection: UICollectionViewCell, CBCentralManagerDelegate, CBPeripheralDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
 let cellId3 = "cell4" // same as above unique id
 var centralManager : CBCentralManager!
 var fruitPeripheral : CBPeripheral!
 let fruitServiceCBUUID = CBUUID(string: "0x1825")
 
 
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 
 setupViews()
 collectionView.register(deviceCells.self, forCellWithReuseIdentifier: cellId3) //register custom UICollectionViewCell class.
 // Here I am not using any custom class
 
 collectionView.contentInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
 
 centralManager = CBCentralManager(delegate: self, queue: nil)
 }
 
 
 func setupViews(){
 addSubview(collectionView)
 
 collectionView.delegate = self
 collectionView.dataSource = self
 
 collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
 collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
 collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
 collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
 
 centralManager = CBCentralManager(delegate: self, queue: nil)
 }
 
 let collectionView: UICollectionView = {
 let layout = UICollectionViewFlowLayout()
 layout.scrollDirection = .horizontal //set scroll direction to horizontal
 let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
 cv.backgroundColor = .blue //testing
 cv.layer.cornerRadius = 10
 cv.translatesAutoresizingMaskIntoConstraints = false
 return cv
 }()
 
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
 //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.connected(_:)))
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId3, for: indexPath)
 
 return cell
 }
 
 /*
 //Go to Device Cell
 func connected(_ sender:AnyObject){
 print("you tap image number : \(sender.view.tag)")
 //Your code for navigate to another viewcontroller
 }
 */
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
 return 4
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
 let deviceCount = 3
 
 let cell0 = CGSize(width: self.frame.width/CGFloat(deviceCount), height: self.frame.height - 10)
 
 return cell0
 
 }
 
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
 func centralManagerDidUpdateState(_ central: CBCentralManager) {
 if central.state == CBManagerState.poweredOn {
 print("Bluetooth on")
 
 centralManager.scanForPeripherals(withServices: nil)
 print("ADEM Found")
 
 }
 else {
 print("Bluetooth off")
 }
 
 //        switch central.state {
 //
 //        case .unknown:
 //            print("BT unknown")
 //        case .resetting:
 //            print("BT resetting")
 //        case .unsupported:
 //            print("BT unsupported")
 //        case .unauthorized:
 //            print("BT unauthorized")
 //        case .poweredOff:
 //            print("BT powered off")
 //        case .poweredOn:
 //            print("BT powered on")
 //            centralManager.scanForPeripherals(withServices: nil)
 //        }
 }
 
 func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
 print(peripheral, " ", peripheral.services as Any)
 }
 }
 
 //Fourth cell
 class privacySection: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
 let cellId4 = "cell4" // same as above unique id
 
 override init(frame: CGRect) {
 super.init(frame: frame);
 
 setupViews();
 collectionView.register(BLE.self, forCellWithReuseIdentifier: cellId4) //register custom UICollectionViewCell class.
 // Here I am not using any custom class
 collectionView.contentInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
 }
 
 
 func setupViews(){
 addSubview(collectionView);
 
 collectionView.delegate = self;
 collectionView.dataSource = self;
 
 collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true;
 collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true;
 collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true;
 collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true;
 }
 
 let collectionView: UICollectionView = {
 let layout = UICollectionViewFlowLayout();
 layout.scrollDirection = .horizontal; //set scroll direction to horizontal
 let cv = UICollectionView(frame: .zero, collectionViewLayout: layout);
 cv.backgroundColor = .blue; //testing
 cv.layer.cornerRadius = 10
 cv.translatesAutoresizingMaskIntoConstraints = false;
 return cv;
 }()
 
 public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
 //let selected = cellId4[collectionView.tag][indexPath.item]
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
 //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.connected(_:)))
 
 
 
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath)
 
 
 
 return cell
 }
 
 //Go to Device Cell
 func connected(_ sender:AnyObject){
 print("you tap image number : \(sender.view.tag)")
 //Your code for navigate to another viewcontroller
 }
 
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
 
 return 1
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 let deviceCount = 4
 
 let cell0 = CGSize(width: self.frame.width/CGFloat(deviceCount), height: self.frame.height - 10)
 
 return cell0
 
 }
 required init?(coder aDecoder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 }
 */

