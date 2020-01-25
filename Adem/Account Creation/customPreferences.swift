//
//  customPreferences.swift
//  Adem
//
//  Created by Coleman Coats on 1/25/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit



class addedFoodPreference: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        var data = [friendsListInfo]()
        var refreshControl = UIRefreshControl()
        
        //reuse ID's
        let adtest = "privacy"
        let cellHeight = 60

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = UIColor.white
            setuploginFieldView()
        }
    
    let progressView: UIView = {
        let progress = UIView()
        progress.backgroundColor = UIColor.ademBlue
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    let nextView: UIView = {
        let next = UIView()
        next.backgroundColor = UIColor.ademBlue
        next.translatesAutoresizingMaskIntoConstraints = false
        return next
    }()
    
    //Name Section
    let welcomeLabel: UILabel = {
        let welcome = UILabel()
        welcome.text = "What flavors do you like?"
        welcome.textAlignment = .center
        welcome.textColor = UIColor.ademBlue
        welcome.backgroundColor = UIColor.white
        welcome.font = UIFont(name:"HelveticaNeue", size: 20.0)
        welcome.translatesAutoresizingMaskIntoConstraints = false
        return welcome
    }()
    
    let textFieldSeparator: UIView = {
        let textSeparator = UIView()
        textSeparator.backgroundColor = UIColor.ademBlue
        textSeparator.translatesAutoresizingMaskIntoConstraints = false
        return textSeparator
    }()
    
    //Next Button
    let doneButton: UIButton = {
        
        //This just refreshes the table view and the labels
        let nextPage = UIButton(type: .system)
        //nextPage.backgroundColor = UIColor.red
        nextPage.setTitle("Next", for: .normal)
        nextPage.translatesAutoresizingMaskIntoConstraints = false
        nextPage.layer.cornerRadius = 5
        nextPage.layer.masksToBounds = true
        nextPage.setTitleColor(UIColor.white, for: .normal)
        nextPage.addTarget(self, action: #selector(handelNext), for: .touchDown)
        nextPage.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return nextPage
        
    }()
       @objc func handelNext() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let skipAccountCreation = tabBar()
        appDelegate.window?.rootViewController = skipAccountCreation
        
    }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    let testee = ["test","please"]
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return testee.count
        }
        
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pref = tableView.dequeueReusableCell(withIdentifier: self.adtest, for: indexPath)
        

        pref.textLabel!.text = testee[indexPath.row]

        
        return pref
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        footerView.backgroundColor = UIColor.ademBlue
    
        return footerView
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    
    var preferencesTableView: UITableView!
    
    private func setuploginFieldView() {
        
        preferencesTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        preferencesTableView.register(UITableViewCell.self, forCellReuseIdentifier: adtest)
        
        preferencesTableView.dataSource = self
        preferencesTableView.delegate = self
        
        view.addSubview(progressView)
        view.addSubview(welcomeLabel)
        view.addSubview(preferencesTableView)
        view.addSubview(textFieldSeparator)
        view.addSubview(nextView)
        nextView.addSubview(doneButton)

        nextView.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        textFieldSeparator.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesTableView.translatesAutoresizingMaskIntoConstraints = false
        
           NSLayoutConstraint.activate([
            
            progressView.topAnchor.constraint(equalTo: view.topAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 50),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textFieldSeparator.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            textFieldSeparator.centerXAnchor.constraint(equalTo: welcomeLabel.centerXAnchor),
            textFieldSeparator.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            textFieldSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            preferencesTableView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            preferencesTableView.bottomAnchor.constraint(equalTo: doneButton.topAnchor),
            preferencesTableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            preferencesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextView.heightAnchor.constraint(equalToConstant: 100),
            nextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            nextView.widthAnchor.constraint(equalTo: view.widthAnchor),
            nextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            doneButton.widthAnchor.constraint(equalToConstant: 50),
            doneButton.centerYAnchor.constraint(equalTo: nextView.centerYAnchor),
            doneButton.centerXAnchor.constraint(equalTo: nextView.centerXAnchor),
            
        ])
    }
}

