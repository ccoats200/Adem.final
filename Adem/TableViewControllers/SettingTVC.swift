//
//  SettingTVC.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class SettingTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //reuse ID's
    let privacy = "privacy"
    private var settingsTableView: UITableView!
    
    let settingsOptions = ["Log out"]
    let cellHeight = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let setText = UILabel()
        setText.text = "Settings"
        setText.font = UIFont(name: "Lato", size: 20)
        setText.textColor = UIColor.ademGreen
        navigationItem.titleView = setText
        navigationController?.navigationBar.isTranslucent = false
        
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        settingsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        
        
        
        settingsTableView.backgroundColor = UIColor.white
        self.settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: privacy)
        
        //self.tableView.separatorStyle = .none
        
        self.settingsTableView.dataSource = self
        self.settingsTableView.delegate = self
        self.view.addSubview(settingsTableView)
        
    }
    
    //UIView Profile Pic
    let friendsPicture: UIImageView = {
        let picOfFriend = UIImageView()
        picOfFriend.contentMode = .scaleAspectFill
        picOfFriend.layer.cornerRadius = 25
        picOfFriend.layer.masksToBounds = true
        picOfFriend.clipsToBounds = true
        picOfFriend.layer.shadowColor = UIColor.clear.cgColor
        picOfFriend.layer.borderColor = UIColor.white.cgColor
        picOfFriend.translatesAutoresizingMaskIntoConstraints = false
        
        return picOfFriend
    }()
    
    
    //product Button
    @objc func handleProduct() {
        
        let cController = ProductVC(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(cController, animated: true)
        
        print("Settings Tab is active")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsOptions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataSwitch = UISwitch()
        let privacy = UITableViewCell(style: .subtitle, reuseIdentifier: self.privacy)
        
        //let privacy = tableView.dequeueReusableCell(withIdentifier: self.privacy, for: indexPath)
        privacy.textLabel?.text = settingsOptions[indexPath.row]
        privacy.textLabel?.textAlignment = .left
        //privacy.backgroundColor = UIColor.rgb(red: 46, green: 114, blue: 111)
        //privacy.textLabel?.font = .boldSystemFont(ofSize: 20)
        privacy.textLabel?.textColor = UIColor.black
        privacy.detailTextLabel?.text = "test"
        privacy.detailTextLabel?.textColor = UIColor.black
        privacy.detailTextLabel?.textAlignment = .left
        
        //privacy.imageView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        //privacy.imageView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //privacy.imageView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        //privacy.imageView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5).isActive = true
        privacy.imageView?.image = UIImage(named: "bread")
        privacy.imageView?.layer.cornerRadius = 30
        privacy.imageView?.clipsToBounds = true
        privacy.imageView?.layer.masksToBounds = true
        privacy.accessoryView = dataSwitch
        
        return privacy
    }
}


