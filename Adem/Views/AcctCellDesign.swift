//
//  AcctCellDesign.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import CoreBluetooth


//Second cell implementation elements
class familySection: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId2 = "cell2" // same as above unique id
    let addFamily = "addFamily"
    
    var profile: [profileContent]? = {
        var eggs = profileContent()
        eggs.personName = "Coleman"
        eggs.profielImageIdentifier = "eggs"
        
        var bitch = profileContent()
        bitch.personName = "Dan"
        bitch.profielImageIdentifier = "eggs"
        
        var third = profileContent()
        third.personName = "Will"
        third.profielImageIdentifier = "eggs"
        
        return [eggs, bitch, third]
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        setupViews();
        
        //MARK: Cell configuration at section
        collectionView.register(familyCells.self, forCellWithReuseIdentifier: cellId2)
        
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
        
        //let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! familyCells
        
        let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! familyCells
        
        firstCell.profileItems = profile![indexPath.item]
        
        //firstCell.backgroundColor = .blue
        firstCell.layer.cornerRadius = 46.5
        return firstCell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        let test = profile!.count
        
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
    let fruitServiceCBUUID = [CBUUID(string: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E")]
    
    var profile: [profileContent]? = {
        var deviceImages = profileContent()
        deviceImages.deviceImage = "eggs"
        
        return [deviceImages]
        
    }()
    
    
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
            centralManager.scanForPeripherals(withServices: fruitServiceCBUUID)
            
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
        fruitPeripheral = peripheral
        fruitPeripheral.delegate = self
        centralManager.stopScan()
        centralManager.connect(fruitPeripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        let tempindex = IndexPath(item: 0, section: 0)
        if let temp = self.collectionView.cellForItem(at: tempindex) as? deviceCells {
            temp.kitchenStaff0.layer.borderColor = UIColor.rgb(red: 0, green: 0, blue: 0).cgColor
            //            temp.layer.borderColor = UIColor.rgb(red: 0, green: 0, blue: 0).cgColor
        }
        self.collectionView.reloadData()
        print("Connected af")
        //trying the 6e400... first
        //peripheral.discoverServices(fruitServiceCBUUID)
        peripheral.discoverServices(nil)
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        for service in services {
            //peripheral.discoverCharacteristics(nil, for: service)
            print(service)
        }
        
    }
    /*
     func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
     error: Error?) {
     print("This is running")
     guard let characteristics = service.characteristics else { return }
     
     for characteristic in characteristics {
     print(characteristic)
     }
     }
     */
    
}


//Fourth cell
class privacySection: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId4 = "cell4" // same as above unique id
    
    var aP: [profileContent]? = {
        var accountUI = profileContent()
        accountUI.userNameLabel = "Account"
        accountUI.profileImage = "eggs"
        
        var privacyUI = profileContent()
        privacyUI.userNameLabel = "Privacy"
        privacyUI.profileImage = "eggs"
        
        return [accountUI, privacyUI]
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        setupViews();
        collectionView.register(accountAndPrivacyCollectionViewCells.self, forCellWithReuseIdentifier: cellId4) //register custom UICollectionViewCell class.
        // Here I am not using any custom class
        //collectionView.contentInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        
        collectionView.isScrollEnabled = false
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
        
        return cv
    }()
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let selected = cellId4[collectionView.tag][indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.connected(_:)))
        
        
        switch indexPath.item {
        case 0:
            let account = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath) as! accountAndPrivacyCollectionViewCells
            account.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 255)
            account.layer.cornerRadius = 10
            return account
            
        case 1:
            let privacy = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath)
            privacy.backgroundColor = UIColor.red
            return privacy
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath)
            return cell
        }
    }
    
    //Go to Device Cell
    func connected(_ sender:AnyObject){
        
        print("you tap image number : \(sender.view.tag)")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceCount = 2
        let cell0 = CGSize(width: self.frame.width/CGFloat(deviceCount), height: self.frame.height)
        
        return cell0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


