//
//  customPreferences.swift
//  Adem
//
//  Created by Coleman Coats on 1/25/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


struct MyStruct {
    var myStructsIntProperty: Float = 0.25

    mutating func myNotVeryThoughtThroughInoutFunction ( myInt: inout Float) {
        myStructsIntProperty += 0.25
        /* What happens here? 'myInt' inout parameter is passed to this
           function by argument 'myStructsIntProperty' from _this_ instance
           of the MyStruct structure. Hence, we're trying to increase the
           value of the inout argument. Since the swift docs describe inout
           as a "call by reference" type as well as a "copy-in-copy-out"
           method, this behaviour is somewhat undefined (at least avoidable).

           After the function has been called: will the value of
           myStructsIntProperty have been increased by 1 or 2? (answer: 1) */
        myInt += 0.25
    }

    func myInoutFunction ( myInt: inout Float) {
        myInt += 0.25
    }
}

class addedFoodPreference: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        var data = [friendsListInfo]()
        var refreshControl = UIRefreshControl()
        
        //reuse ID's
        let adtest = "privacy"
        let cellHeight = 60

        var preferencesTableView: UITableView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = UIColor.white
            setuploginFieldView()
           
            preferencesTableView.separatorStyle = .none
            //preferencesTableView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            //preferencesTableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            preferencesTableView.allowsMultipleSelection = true
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
    
    var firstPage = 0
    var prog = 0.25
    var incr = MyStruct()
    
       @objc func handelNext() {
        
        firstPage+=1
        preferencesTableView.reloadData()
        topView.pBar.setProgress(incr.myStructsIntProperty, animated: true)
        print(incr.myStructsIntProperty)
        
        print(firstPage)
    }
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    let tasteProfile = ["Salty","Sweet","Spicy","Biter","Fruity"]
    let dietPreferences = ["Vegetarian","Vegan","Nuts","Lactose","Not on here", "None"]
    let storePreferences = ["Vegetarian","Vegan","Nuts","Lactose","Not on here", "None"]
        
    @objc func handleTap() {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return tasteProfile.count
        }
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pref = tableView.dequeueReusableCell(withIdentifier: self.adtest, for: indexPath)
        pref.layer.cornerRadius = 10
        //pref.layer.borderWidth = 1
        //pref.layer.borderColor = UIColor.ademBlue.cgColor
        //pref.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        pref.layoutMargins = UIEdgeInsets.zero
        pref.contentView.layoutMargins.top = 20
        pref.contentView.layoutMargins.bottom = 20
        
        //Change the checkmark color
        pref.tintColor = UIColor.ademGreen
        pref.clipsToBounds = true
        pref.textLabel?.textAlignment = .center
        
        //needs a guard let statment to protect against screen switching without the data reloading
        switch firstPage {
        case 0:
            pref.textLabel!.text = tasteProfile[indexPath.row]
        case 1:
            pref.textLabel!.text = dietPreferences[indexPath.row]
        case 2:
            pref.textLabel!.text = storePreferences[indexPath.row]
        default:
            pref.textLabel!.text = tasteProfile[indexPath.row]
        }

        return pref
    }
    func testededed() {
        
    }
    
    var selectedFoodPreferencesCells = [String]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let currentCell = preferencesTableView.cellForRow(at: indexPath)
        currentCell?.selectionStyle = .none
        
        
        //TODO: When the cells reload deselect the cells
        currentCell?.accessoryType = .checkmark
        //for taste in tasteProfile {
          //  if taste
        //}
        //selectedFoodPreferencesCells.append(currentCell?.textLabel!.text! ?? "empty")
        selectedFoodPreferencesCells.insert(currentCell?.textLabel!.text! ?? "empty", at: 0)

        print(currentCell?.textLabel!.text)
        //preferencesTableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let currentCell = preferencesTableView.cellForRow(at: indexPath)
        
        preferencesTableView.cellForRow(at: indexPath)?.accessoryType = .none
        selectedFoodPreferencesCells.remove(at: 0)
        
        /*
        if let indexValue = selectedFoodPreferencesCells.index(of: "\(currentCell?.textLabel!.text)") {
            selectedFoodPreferencesCells.remove(at: indexValue)
        }
*/
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
    
    var topView = preferenceProgressViews()
    private func setuploginFieldView() {
        
        preferencesTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        preferencesTableView.register(UITableViewCell.self, forCellReuseIdentifier: adtest)
        
        preferencesTableView.dataSource = self
        preferencesTableView.delegate = self
        
           
        view.addSubview(topView)
        view.addSubview(welcomeLabel)
        view.addSubview(preferencesTableView)
        view.addSubview(textFieldSeparator)
        view.addSubview(nextView)
        nextView.addSubview(doneButton)

        topView.translatesAutoresizingMaskIntoConstraints = false
        nextView.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        textFieldSeparator.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesTableView.translatesAutoresizingMaskIntoConstraints = false
        
           NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50),
            topView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            
            welcomeLabel.topAnchor.constraint(equalTo: topView.bottomAnchor),
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

