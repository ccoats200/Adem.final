//
//  ItemVC.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//
import Foundation
import UIKit
import CoreBluetooth



class ProductVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //Reuse ID's
    let productForVC = "Product"
    let productNames = "Eggs"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.title = "Productssss"
        
        let productName = UILabel()
        productName.text = "\(productNames)"
        productName.font = UIFont(name: "Lato", size: 25)
        productName.textColor = UIColor.white
        navigationItem.titleView = productName
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = UIColor.rgb(red: 30, green: 188, blue: 28)
        
        collectionView.isScrollEnabled = true
        
        collectionView?.register(ItemLayout.self, forCellWithReuseIdentifier: productForVC)
        
        //This moves the Cells to the correct offsets, Stylistic choice
        collectionView?.contentInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 50, right: 0)
        
        //bluetooth()
        //BLESwitch.addTarget(self, action: #selector(switchStatus(_:)), for: UIControl.Event.valueChanged)
        
        setUpNavBarButto()
        
    }
    
    func setUpNavBarButto(){
        
        let statusImage = UIBarButtonItem(image: UIImage(named: "fave")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(home))
        
        
        navigationItem.rightBarButtonItem = statusImage
    }
    
    //Account Button
    @objc func home() {
        //let bController = listCollectionView(collectionViewLayout: UICollectionViewFlowLayout())
        let bController = listCollectionView()
        self.navigationController?.pushViewController(bController, animated: true)
        //self.present(bController, animated: true, completion: nil)
        print(123)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    //Cell at row
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let profileCell = collectionView.dequeueReusableCell(withReuseIdentifier: productForVC, for: indexPath) as! ItemLayout
        /*
         profileCell.backgroundColor = UIColor.rgb(red: 252, green: 252, blue: 252) //off white blue color
         profileCell.layer.cornerRadius = 5
         print("Rounds corners")
         
         
         //Shadow
         profileCell.layer.shadowColor = UIColor.gray.cgColor
         profileCell.layer.shadowOffset = CGSize(width: 0, height: 3.0)
         profileCell.layer.shadowOpacity = 0.7
         profileCell.layer.shadowRadius = 2.0
         profileCell.layer.masksToBounds = false
         profileCell.layer.shadowPath = UIBezierPath(roundedRect: profileCell.bounds, cornerRadius: profileCell.contentView.layer.cornerRadius).cgPath;
         */
        
        return profileCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeofItemCell = CGSize(width: view.frame.width, height: 125)
        return sizeofItemCell
    }
    
    //Space between rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
//
//    //BluetoothStatus
//    @objc func switchStatus(_ sender: UISwitch) {
//        if sender.isOn {
//            connectedLBL.text = "Connected"
//        } else {
//            connectedLBL.text = "Connect"
//        }
//    }
//
//    func bluetooth() {
//
//        //Switch
//        BLESwitch.frame = CGRect(x: 0, y: 0, width: 200, height: 21)
//        BLESwitch.center = CGPoint(x: 163, y: 200)
//        self.view.addSubview(BLESwitch)
//
//        //LBL
//        connectedLBL.frame = CGRect(x: 0, y: 0, width: 200, height: 21)
//        connectedLBL.center = CGPoint(x: 160, y: 285)
//        connectedLBL.textAlignment = .center
//        connectedLBL.text = "Connect"
//        self.view.addSubview(connectedLBL)
//    }


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */



