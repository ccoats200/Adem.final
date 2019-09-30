//
//  settingVC.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore

class settings: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //reuse ID's
    let privacy = "privacy"
    private var settingsTableView: UITableView!
    
    let userDefinedSettings = UserDefaults.standard
    //let switchKey = "SwitchKey"
    
    var firstTimeAppLaunch: Bool {
        get {
            // Will return false when the key is not set.
            return userDefinedSettings.bool(forKey: "firstTimeAppLaunch")
        }
        set {}
    }
    
    //MARK: Settings Table View header - Start
    let settingsOptions = ["List view","Pantry View","Account","About","Privacy","Security","Help","Log out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let setText = UILabel()
        setText.text = "Settings"
        setText.textColor = UIColor.white
        navigationItem.titleView = setText
        navigationController?.navigationBar.isTranslucent = false
        
        
        let screenWidth: CGFloat = self.view.frame.width
        let screenHeight: CGFloat = self.view.frame.height
        
        settingsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        settingsTableView.backgroundColor = UIColor.white
        
        
        //MARK: Custom Cells
        self.settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: privacy)
        
        self.settingsTableView.dataSource = self
        self.settingsTableView.delegate = self
        self.view.addSubview(settingsTableView)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        colorSwitch.isOn = userDefinedSettings.bool(forKey: "SwitchKey")
    }
  
    //MARK: Settings Icons - START
    let settingsImage: UIImageView = {
        let settingsIcon = UIImageView()
        settingsIcon.contentMode = .scaleAspectFill
        settingsIcon.layer.masksToBounds = true
        settingsIcon.clipsToBounds = true
        settingsIcon.layer.shadowColor = UIColor.clear.cgColor
        settingsIcon.layer.borderColor = UIColor.white.cgColor
        settingsIcon.translatesAutoresizingMaskIntoConstraints = false
        
        return settingsIcon
    }()
    
    @objc func switchForListDesign(sender: UISwitch) {
        userDefinedSettings.set(sender.isOn, forKey: "SwitchKey")
    }
    
      //MARK: Settings Sections - Start
      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
      //MARK: Settings Rows for sections
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
          switch section {
          case 0:
              return settingsOptions.count
          default:
              return 1
          }
      }
    
    //MARK: Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
           footerView.backgroundColor = UIColor.ademBlue
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        
        label.text = "Adem is further than it was this morning"
        footerView.addSubview(label)
           return footerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    //MARK: Switch
    let colorSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.setOn(false, animated: true)
        switcher.addTarget(self, action: #selector(switchForListDesign), for: .valueChanged)
        
        return switcher
    }()
    let pantrySwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.setOn(false, animated: true)
        switcher.addTarget(self, action: #selector(switchForListDesign), for: .valueChanged)
        
        return switcher
    }()

    //MARK: Cell for Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //MARK: Cell instantiation
        let settingsListOptions = tableView.dequeueReusableCell(withIdentifier: self.privacy, for: indexPath)
        
        let row = indexPath.row
      
        settingsListOptions.textLabel?.text = settingsOptions[row]
        settingsListOptions.textLabel?.textAlignment = .left
        settingsListOptions.textLabel?.textColor = UIColor.black
        settingsListOptions.accessoryType = .disclosureIndicator
        
        switch row {
        case 0:
            settingsListOptions.accessoryView = colorSwitch
            settingsListOptions.imageView?.image = UIImage(named: "nutritionFacts")
            
            settingsListOptions.imageView?.clipsToBounds = true
            settingsListOptions.imageView?.layer.masksToBounds = true
        case 1:
            settingsListOptions.accessoryView = pantrySwitch
            settingsListOptions.imageView?.image = UIImage(named: "nutritionFacts")
            
            settingsListOptions.imageView?.clipsToBounds = true
            settingsListOptions.imageView?.layer.masksToBounds = true
        case 2:
            settingsListOptions.accessoryType = .detailDisclosureButton
            settingsListOptions.imageView?.image = UIImage(named: "notifications")
            settingsListOptions.imageView?.clipsToBounds = true
            settingsListOptions.imageView?.layer.masksToBounds = true
        case 3:
            settingsListOptions.accessoryType = .detailButton
            settingsListOptions.imageView?.image = UIImage(named: "Info")
            settingsListOptions.imageView?.clipsToBounds = true
            settingsListOptions.imageView?.layer.masksToBounds = true
        default:
            settingsListOptions.accessoryView = nil
        }
        return settingsListOptions
    }
    
    
    //MARK: Settings Row button handlers
    @objc func settingsRowOne() {
        
        let cController = ProductVC(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(cController, animated: true)
        
        print("Settings Tab is active")
    }
    
    //MARK: Cell selection handler
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellRow = indexPath.row
        
        switch cellRow {
        case 7:
            handleAlert()
            print("1")
        default:
            print("2")
        }
    }
    
    //MARK: Alert Buttons
    @objc func handleLogout() {
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        handleLogin()
    }
    
    //Button Action - Start
    @objc func handleLogin() {
        let logBackIn = login()
        self.present(logBackIn, animated: true, completion: nil)
        print("Settings Tab is active")
    }
    
    //Logout Alert
    @objc func handleAlert() {
        let alert = UIAlertController(title: "Leaving So Soon?", message: "Are you sure you want to leave the Kitchen?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Log Out", comment: "User is logging out"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            self.handleLogout()
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "User is logging out"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
