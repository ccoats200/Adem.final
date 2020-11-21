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


class addHomeMember: UIViewController {
    
    // Anywhere there is a server call we need to have the the function return a tuple to show the server status incase the server fails. see the section in the swift book on tuples
    var accountViewToSwitch: [UIView]!
    //var camAddViews = self().camView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.ademBlue
        view.addSubview(addLabelView)
        
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
    
    //let contect = CIContext()
    //let filter = CIFilter.qrCodeGenerator()
    //https://www.hackingwithswift.com/books/ios-swiftui/generating-and-scaling-up-a-qr-code
    
    
    @objc func switchStatsViews() {
        self.view.bringSubviewToFront(accountViewToSwitch[homeStatssegmentContr.selectedSegmentIndex])
    }
    var leaveGroup = navigationButton()
    
    let homeStatssegmentContr: UISegmentedControl = {
        let items = ["Welcome", "Join"]
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
    
    let ademImageHolder: UIImageView = {
        let ademImage = UIImageView()
        ademImage.image = UIImage(named: "Adem Logo")
        ademImage.translatesAutoresizingMaskIntoConstraints = false
        ademImage.contentMode = .scaleAspectFit
        
        return ademImage
    }()
    
    let camView: UIView = {
       let t = UIView()
        return t
        
    }()
    
    @objc func handleLeaveGroup() {
        print("testing the leave group action")
    }
    

    func leaveGroupButtonAttributes() {
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
        leaveGroupButtonAttributes()
        
        addLabelView.translatesAutoresizingMaskIntoConstraints = false
        homeStatssegmentContr.translatesAutoresizingMaskIntoConstraints = false
        leaveGroup.translatesAutoresizingMaskIntoConstraints = false
        
        
        accountViewToSwitch = [UIView]()
                
        accountViewToSwitch.append(ademImageHolder)
        accountViewToSwitch.append(ademImageHolder)
        
        for v in accountViewToSwitch {
            view.addSubview(v)
            v.layer.cornerRadius = 5
            v.translatesAutoresizingMaskIntoConstraints = false
        }
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
            
            ademImageHolder.topAnchor.constraint(equalTo: homeStatssegmentContr.bottomAnchor, constant: 10),
            ademImageHolder.bottomAnchor.constraint(equalTo: leaveGroup.topAnchor, constant: -15),
            ademImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            ademImageHolder.centerXAnchor.constraint(equalTo: homeStatssegmentContr.centerXAnchor),
            
                        
            leaveGroup.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            leaveGroup.heightAnchor.constraint(equalToConstant: 50),
            leaveGroup.widthAnchor.constraint(equalTo: homeStatssegmentContr.widthAnchor),
            leaveGroup.centerXAnchor.constraint(equalTo: homeStatssegmentContr.centerXAnchor)
            
        ])
    }
}





