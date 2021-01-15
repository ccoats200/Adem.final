//
//  addHomeMember.swift
//  Adem
//
//  Created by Coleman Coats on 11/16/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreImage.CIFilterBuiltins


class addHomeMember: UIViewController, UITextFieldDelegate {
    
    // Anywhere there is a server call we need to have the the function return a tuple to show the server status incase the server fails. see the section in the swift book on tuples
    var accountViewToSwitch: [UIView]!
    var leaveGroup = navigationButton()
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    let scanner = camVC()
    let cameraView = QRScannerView()

    let linkToFam = privatehomeAttributes["uid"]
    let houseName = privatehomeAttributes["homeName"]
    var placeholderNameOfHome = "Kitchen"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.ademBlue
        
        self.addChangeHomeName.delegate = self
        view.addSubview(addLabelView)
//        updates based on firebase
        addChangeHomeName.text = houseName as! String
        fetchHomeSettings()

        setUpAddDismiss()
    }
    
    let addLabelView: UILabel = {
        var welcome = UILabel()
        welcome.text = "Add a New Member?"
        welcome.textAlignment = .center
        welcome.textColor = UIColor.white
        welcome.font = UIFont(name: helNeu, size: 20.0)
        welcome.translatesAutoresizingMaskIntoConstraints = false
        return welcome
    }()
    
    //This pushes to firebase. Firebase should have the default of "Kitchen"
    var addChangeHomeName: UITextField = {
        //Use Firebase from accountVC
        var homeTextField = UITextField()
        //This line should be pulling from fire base
        homeTextField.text = "Kit"
        homeTextField.textAlignment = .center
        homeTextField.keyboardType = .alphabet
        homeTextField.returnKeyType = .done
        homeTextField.autocorrectionType = .no
        homeTextField.textColor = UIColor.white
        homeTextField.font = UIFont(name: helNeu, size: 20.0)
        homeTextField.translatesAutoresizingMaskIntoConstraints = false
        return homeTextField
    }()
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //This line should update firebase
        let text = textField.text
        addChangeHomeName.text = text
        
        addChangeHomeName.resignFirstResponder()
        return true
    }
    
    @objc func switchStatsViews() {
        self.view.bringSubviewToFront(accountViewToSwitch[homeStatssegmentContr.selectedSegmentIndex])
    }
    
    
    let homeStatssegmentContr: UISegmentedControl = {
        let items = ["Welcome", "Scan"]
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
    
    
    
    let welcomeBacking: UIView = {
        let welcomeBacking = UIView()
        welcomeBacking.backgroundColor = UIColor.ademBlue
        welcomeBacking.translatesAutoresizingMaskIntoConstraints = false
        return welcomeBacking
        
    }()
    
    let welcomeQR: UIImageView = {
        let ademImage = UIImageView()
        ademImage.contentMode = .scaleAspectFit
        ademImage.translatesAutoresizingMaskIntoConstraints = false
        
        return ademImage
    }()

    
    func fetchHomeSettings() {
        
        userfirebasehome.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
            print("Error fetching document: \(error!)")
            return
            }
            guard let data = document.data() else {
            print("Document data was empty.")
            return
            }
        print("Current data: \(data)")
        }
    }
    
    func generateQRCodeImage(_ url: String) -> UIImage {
        let data = Data(url.utf8)
        //let data = absoluteString.data(using: String.Encoding.ascii)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(named: "Adem Logo") ?? UIImage()
    }
    
    let scan: UIImageView = {
        let ademImage = UIImageView()
        ademImage.image = UIImage(named: "milk")
        ademImage.translatesAutoresizingMaskIntoConstraints = false
        ademImage.contentMode = .scaleAspectFit
        
        return ademImage
    }()
    
    let scanBacking: UIView = {
        let welcomeBacking = UIView()
        welcomeBacking.backgroundColor = UIColor.ademBlue
        welcomeBacking.translatesAutoresizingMaskIntoConstraints = false
        return welcomeBacking
        
    }()
    
    let camView: UIView = {
        let t = UIView()
        t.backgroundColor = UIColor.ademBlue
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
        
    }()
    
    @objc func handleLeaveGroup() {
        
        userfirebaseHomeSettings.updateData([
                                        "home" : privatehomeAttributes["uid"]!])
    }
    

    func leaveGroupButtonAttributes() {
        //https://developer.apple.com/documentation/swiftui/image/interpolation
        welcomeQR.image = generateQRCodeImage(linkToFam as! String)
        //welcomeQR.contentMode = .sc
        leaveGroup.largeNextButton.backgroundColor = UIColor.ademRed
        leaveGroup.largeNextButton.setTitleColor(UIColor.white, for: .normal)
        leaveGroup.largeNextButton.layer.masksToBounds = true
        leaveGroup.largeNextButton.setTitle("Leave Group", for: .normal)
        leaveGroup.largeNextButton.addTarget(self, action: #selector(handleLeaveGroup), for: .touchUpInside)
        
    }
    
    func setUpAddDismiss() {
        view.addSubview(addLabelView)
        
        view.addSubview(homeStatssegmentContr)
        view.addSubview(leaveGroup)
        
        view.addSubview(welcomeBacking)
        view.addSubview(scanBacking)
        welcomeBacking.addSubview(welcomeQR)
        welcomeBacking.addSubview(addChangeHomeName)
        //scanBacking.addSubview(scan)
        scanBacking.addSubview(cameraView)
        cameraView.layer.cornerRadius = 10
        leaveGroupButtonAttributes()
        
        addChangeHomeName.translatesAutoresizingMaskIntoConstraints = false
        addLabelView.translatesAutoresizingMaskIntoConstraints = false
        homeStatssegmentContr.translatesAutoresizingMaskIntoConstraints = false
        leaveGroup.translatesAutoresizingMaskIntoConstraints = false
        welcomeQR.translatesAutoresizingMaskIntoConstraints = false
        //scan.translatesAutoresizingMaskIntoConstraints = false
        welcomeBacking.translatesAutoresizingMaskIntoConstraints = false
        scanBacking.translatesAutoresizingMaskIntoConstraints = false
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        
        
        accountViewToSwitch = [UIView]()
                
        accountViewToSwitch.append(welcomeBacking)
        accountViewToSwitch.append(scanBacking)
        
       
        view.bringSubviewToFront(accountViewToSwitch[0])
        
        
        NSLayoutConstraint.activate([
            
            addLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addLabelView.topAnchor.constraint(equalTo: view.topAnchor, constant: -10),
            addLabelView.widthAnchor.constraint(equalTo: view.widthAnchor),
            addLabelView.heightAnchor.constraint(equalToConstant: 50),
            
            homeStatssegmentContr.topAnchor.constraint(equalTo: addLabelView.bottomAnchor),
            homeStatssegmentContr.heightAnchor.constraint(equalToConstant: 25),
            homeStatssegmentContr.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            homeStatssegmentContr.centerXAnchor.constraint(equalTo: addLabelView.centerXAnchor),
            
            addChangeHomeName.centerXAnchor.constraint(equalTo: welcomeBacking.centerXAnchor),
            addChangeHomeName.topAnchor.constraint(equalTo: welcomeBacking.topAnchor, constant: -5),
            addChangeHomeName.widthAnchor.constraint(equalTo: welcomeBacking.widthAnchor),
            addChangeHomeName.heightAnchor.constraint(equalToConstant: 25),
            
            welcomeQR.topAnchor.constraint(equalTo: addChangeHomeName.bottomAnchor, constant: 10),
            welcomeQR.bottomAnchor.constraint(equalTo: welcomeBacking.bottomAnchor),
            welcomeQR.widthAnchor.constraint(equalTo: welcomeBacking.widthAnchor, multiplier: 1/2),
            welcomeQR.centerXAnchor.constraint(equalTo: welcomeBacking.centerXAnchor),
            
            welcomeBacking.topAnchor.constraint(equalTo: homeStatssegmentContr.bottomAnchor, constant: 10),
            welcomeBacking.bottomAnchor.constraint(equalTo: leaveGroup.topAnchor, constant: -15),
            welcomeBacking.widthAnchor.constraint(equalTo: view.widthAnchor),
            welcomeBacking.centerXAnchor.constraint(equalTo: homeStatssegmentContr.centerXAnchor),
            
//            scan.topAnchor.constraint(equalTo: scanBacking.topAnchor, constant: 10),
//            scan.bottomAnchor.constraint(equalTo: scanBacking.bottomAnchor, constant: -15),
//            scan.widthAnchor.constraint(equalTo: scanBacking.widthAnchor, constant: -2),
//            scan.centerXAnchor.constraint(equalTo: scanBacking.centerXAnchor),
            
            cameraView.topAnchor.constraint(equalTo: scanBacking.topAnchor, constant: 10),
            cameraView.bottomAnchor.constraint(equalTo: scanBacking.bottomAnchor ),
            cameraView.widthAnchor.constraint(equalTo: scanBacking.widthAnchor, multiplier: 1/2),
            cameraView.centerXAnchor.constraint(equalTo: scanBacking.centerXAnchor),
            
            scanBacking.topAnchor.constraint(equalTo: homeStatssegmentContr.bottomAnchor, constant: 10),
            scanBacking.bottomAnchor.constraint(equalTo: leaveGroup.topAnchor, constant: -15),
            scanBacking.widthAnchor.constraint(equalTo: view.widthAnchor),
            scanBacking.centerXAnchor.constraint(equalTo: homeStatssegmentContr.centerXAnchor),
                        
            leaveGroup.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            leaveGroup.heightAnchor.constraint(equalToConstant: 50),
            leaveGroup.widthAnchor.constraint(equalTo: homeStatssegmentContr.widthAnchor),
            leaveGroup.centerXAnchor.constraint(equalTo: homeStatssegmentContr.centerXAnchor)
            
        ])
    }
}


