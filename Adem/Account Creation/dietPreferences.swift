//
//  dietPreferences.swift
//  Adem
//
//  Created by Coleman Coats on 2/10/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class addedDietPreferencesTwo: UIViewController, UICollectionViewDelegateFlowLayout {

    var currentViewControllerIndex = 0
    let viewControllerDataSource = ["\(preferenceProgressViews())"]

    var data = [friendsListInfo]()
        
    //reuse ID's
    let adtest = "privacy"
    let cellHeight = 60

    //MARK: Element calls
    var preferencesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setUpSubviews()
        setuplayoutConstraints()
        
    }
    
    
    //MARK: Alert
    @objc func handelDismiss() {
        
        incorrectInformationAlert(title: "Are you Sure", message: "You can finish setting everything up later")
        //self.dismiss(animated: true, completion: nil)
    }
    
    func incorrectInformationAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .actionSheet) //might be better as an .alert
        alertController.addAction(UIAlertAction(title: "Keep going", style: .default, handler: {action in
        }))
        alertController.addAction(UIAlertAction(title: "Finish Later", style: .destructive, handler: {action in
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    //MARK: End Alert
    
    
    //Name Section
    let welcomeLabel: UILabel = {
        var welcome = UILabel()
        welcome.text = "Any Foods You Don't Eat?"
        welcome.textAlignment = .center
        welcome.textColor = UIColor.ademBlue
        welcome.backgroundColor = UIColor.white
        welcome.font = UIFont(name: helNeu, size: 20.0)
        welcome.translatesAutoresizingMaskIntoConstraints = false
        return welcome
    }()
    
    let textFieldSeparator: UIView = {
        let textSeparator = UIView()
        textSeparator.backgroundColor = UIColor.ademBlue
        textSeparator.translatesAutoresizingMaskIntoConstraints = false
        return textSeparator
    }()
    
    //Name Section
    let infoLabel: UILabel = {
        var reason = UILabel()
        reason.text = "This helps us not recommend new foods and meals that you might not enjoy."
        reason.textAlignment = .center
        reason.numberOfLines = 0
        reason.textColor = UIColor.ademBlue
        reason.backgroundColor = UIColor.white
        reason.font = UIFont(name: helNeu, size: 15.0)
        reason.translatesAutoresizingMaskIntoConstraints = false
        return reason
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {

    }
    //MARK: Arrays
    let preferencesDictionary = [0: ["Pescaterian","Vegetarian","Vegan","Nuts","Lactose","Other", "None"]]

    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    //var selectedFoodPreferencesCells = [IndexPath]()
    var selectedFoodPreferencesCells = [String]()

    private func setUpSubviews() {
        

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
        //layout.scrollDirection = .horizontal
        preferencesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        preferencesCollectionView.register(signUpCellDesign.self, forCellWithReuseIdentifier: cellID)

        //MARK: CollectionView attributes
        preferencesCollectionView.dataSource = self
        preferencesCollectionView.delegate = self
        preferencesCollectionView.backgroundColor = .white
        preferencesCollectionView.isScrollEnabled = true
        preferencesCollectionView.allowsMultipleSelection = true
        
        //MARK: subviews
        view.addSubview(welcomeLabel)
        view.addSubview(textFieldSeparator)
        view.addSubview(infoLabel)
        view.addSubview(preferencesCollectionView)
        

        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldSeparator.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesCollectionView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
           let padding: CGFloat =  50
           
           let collectionViewSize = collectionView.frame.size.width - padding

           return CGSize(width: collectionViewSize/2, height: 80)
       }
    
    let cellID = "Test"
    
    private func setuplayoutConstraints() {
        
           NSLayoutConstraint.activate([
            
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            
            textFieldSeparator.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            textFieldSeparator.centerXAnchor.constraint(equalTo: welcomeLabel.centerXAnchor),
            textFieldSeparator.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor),
            textFieldSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            infoLabel.topAnchor.constraint(equalTo: textFieldSeparator.bottomAnchor, constant: 20),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor, constant: -5),
            infoLabel.heightAnchor.constraint(equalToConstant: 50),
            
            preferencesCollectionView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            preferencesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            preferencesCollectionView.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor),
            preferencesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
}

extension addedDietPreferencesTwo: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

       
        return preferencesDictionary[0]!.count
    }
    
    //var emptyDict: [String: String] = [:]
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let preferencesCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! signUpCellDesign
        
        for _ in preferencesDictionary[0]! {
            if indexPath.row == 0 {
                preferencesCell.preferencesIcon.image = UIImage(named: "fish")
            } else if indexPath.row == 1 {
                preferencesCell.preferencesIcon.image = UIImage(named: "veg")
            } else if indexPath.row == 2 {
                preferencesCell.preferencesIcon.image = UIImage(named: "vegan")
            } else if indexPath.row == 3 {
                preferencesCell.preferencesIcon.image = UIImage(named: "nut")
            } else {
                preferencesCell.preferencesIcon.image = UIImage(named: "dairy")
            }
        }
      
        //signInFlowViewControllerTwo().dataSource = self as! UIPageViewControllerDataSource
    
            for (number, options) in preferencesDictionary {
                preferencesCell.preferencesLabel.text = options[indexPath.row]
            }
        return preferencesCell
        
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = preferencesCollectionView.cellForItem(at: indexPath) as? signUpCellDesign
        
        for _ in preferencesDictionary[0]! {
            if indexPath.row == 0 {
                currentCell?.preferencesIcon.image = UIImage(named: "fish_selected")
            } else if indexPath.row == 1 {
                currentCell?.preferencesIcon.image = UIImage(named: "veg_selected")
            } else if indexPath.row == 2 {
                currentCell?.preferencesIcon.image = UIImage(named: "vegan_selected")
            } else if indexPath.row == 3 {
                currentCell?.preferencesIcon.image = UIImage(named: "nut_selected")
            } else {
                currentCell?.preferencesIcon.image = UIImage(named: "dairy_selected")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let currentCell = preferencesCollectionView.cellForItem(at: indexPath) as? signUpCellDesign
        
        for _ in preferencesDictionary[0]! {
            if indexPath.row == 0 {
                currentCell?.preferencesIcon.image = UIImage(named: "fish")
            } else if indexPath.row == 1 {
                currentCell?.preferencesIcon.image = UIImage(named: "veg")
            } else if indexPath.row == 2 {
            currentCell?.preferencesIcon.image = UIImage(named: "vegan")
            } else if indexPath.row == 3 {
                currentCell?.preferencesIcon.image = UIImage(named: "nut")
            } else {
                currentCell?.preferencesIcon.image = UIImage(named: "dairy")
            }
        }
    }
    
}
