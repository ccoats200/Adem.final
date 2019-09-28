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
    let switchKey = "SwitchKey"
    
    var firstTimeAppLaunch: Bool {
        get {
            // Will return false when the key is not set.
            return userDefinedSettings.bool(forKey: "firstTimeAppLaunch")
        }
        set {}
    }
    
    //MARK: Settings Table View header - Start
    let settingsOptions = ["List view","Account","About","Privacy","Security","Help","Log out"]
    
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
        
        //editing to reorder cell
        //self.settingsTableView.isEditing = true
        //MARK: Remeber switch value
        colorSwitch.isOn = userDefinedSettings.bool(forKey: switchKey)
        
        
        //MARK: Custom Cells
        self.settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: privacy)
        
        self.settingsTableView.dataSource = self
        self.settingsTableView.delegate = self
        self.view.addSubview(settingsTableView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        colorSwitch.isOn = userDefinedSettings.bool(forKey: switchKey)
    }
    
    
    
    /*
    //editing to reorder cell - Start
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.settingsCategories[sourceIndexPath.row]
        settingsCategories.remove(at: sourceIndexPath.row)
        settingsCategories.insert(movedObject, at: destinationIndexPath.row)
    }
    //editing to reorder cell - End
*/
    
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
        userDefinedSettings.set(sender.isOn, forKey: switchKey)
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
        
        label.text = "Adem"
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

    //MARK: Cell for Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //MARK: Cell instantiation
        let settingsListOptions = tableView.dequeueReusableCell(withIdentifier: self.privacy, for: indexPath)
        
        let row = indexPath.row
      
        settingsListOptions.textLabel?.text = settingsOptions[row]
        settingsListOptions.textLabel?.textAlignment = .left
        settingsListOptions.textLabel?.textColor = UIColor.black
        
        switch row {
        case 0:
            settingsListOptions.accessoryView = colorSwitch
            settingsListOptions.imageView?.image = UIImage(named: "nutritionFacts")
            
            settingsListOptions.imageView?.clipsToBounds = true
            settingsListOptions.imageView?.layer.masksToBounds = true
        case 1:
            settingsListOptions.imageView?.image = UIImage(named: "notifications")
            settingsListOptions.imageView?.clipsToBounds = true
            settingsListOptions.imageView?.layer.masksToBounds = true
        case 2:
            settingsListOptions.imageView?.image = UIImage(named: "notifications")
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
        case 0:
            print("1")
        default:
            print("2")
        }
    }
    
    
}
