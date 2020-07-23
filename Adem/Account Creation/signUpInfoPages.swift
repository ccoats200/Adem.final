//
//  signUpInfoPages.swift
//  Adem
//
//  Created by Coleman Coats on 1/30/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

//MARK: Google Implamentation
class addedFlavorPreferences: UIViewController, UICollectionViewDelegateFlowLayout {

    var currentViewControllerIndex = 0

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
        welcome.text = "What flavors do you like?"
        welcome.textAlignment = .center
        welcome.numberOfLines = 0
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
        reason.text = "Don’t worry, this is just preference. You’ll still get the full range of flavors."
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
    
    var currentPage = 0
    let numberOfPages = 3
    var prog: Float = 0.00
    
    //MARK: Arrays
    let promptArray = ["What flavors do you like?","Are you allergic?","Where do you shop?","We Know Just The Thing"]
    
    //not sure what katie wants for this. I choose for them
    //Make the prompt explain the weighted scale
    //Making it based on a meal or picture
    //5 tiles click the flavor profile
    //Conjoint analysis in back end
    let preferencesDictionary = [
    0: ["Salty","Sour","Sweet","Biter","Savory","Spicy","Fruity","Skip"],
    1: ["Pescaterian","Vegetarian","Vegan","Nuts","Lactose","Not on here", "None", "please"],
    2: ["Walmart","Wegmans","Vons","Stater Bros","Not on here", "None", "Please","Work"],
    3: ["Thanks"]]
    
    
    @objc func handelNext() {
        //FIXME: What to do with this
        print("there are \((preferencesDictionary.keys.count)-1) sets")
        
        if currentPage < numberOfPages {
            currentPage+=1
        }
        
        if prog < Float(numberOfPages/numberOfPages) {
            prog += (Float(numberOfPages/numberOfPages)/Float(numberOfPages))
            print(prog)
        }
        coverMeImReloading()
    }
    
    private func sendingPreferencesToCloud() {
                
//        guard let flavorPreferences = accountCreationViews.firstNameTextField.text, !firstName.isEmpty else { return }
//
//        let dataToSave: [String: Any] = [
//                   "FirstName": flavorPreferences
//               ]
//
//       //MARK: this needs to be a collection
//        db.collection("Users").document().collection("private").document("UsersPrivateInfo").setData(dataToSave) { (error) in
//
//        }
    }
    
    func coverMeImReloading() {
        
        preferencesCollectionView.reloadData()
        
        switch currentPage {
        case currentPage:
            welcomeLabel.text = promptArray[currentPage]
        default:
            welcomeLabel.text = "Something Went Wrong... Let me check the recipe"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    //var selectedFoodPreferencesCells = [IndexPath]()
    var selectedFoodPreferencesCells = [String]()

    private func setUpSubviews() {
        

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: (self.view.frame.height)/5, left: (self.view.frame.width)/5, bottom: (self.view.frame.width)/5, right: (self.view.frame.height)/5)
    
        preferencesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        preferencesCollectionView.register(signUpCellDesign.self, forCellWithReuseIdentifier: cellID)

        //MARK: CollectionView attributes
        preferencesCollectionView.dataSource = self
        preferencesCollectionView.delegate = self
        preferencesCollectionView.backgroundColor = .white
        preferencesCollectionView.isScrollEnabled = true
        preferencesCollectionView.allowsMultipleSelection = true
        
        //MARK: Subviews
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
        
        let padding: CGFloat =  10
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
    var flavorsCount = flavorsAttributes
    var flavorStuff: [flavorsContent] = []
}

extension addedFlavorPreferences: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        for i in flavorsCount {
            flavorStuff.append(i)
         }
        
         return flavorStuff.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let preferencesCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! signUpCellDesign
        preferencesCell.flavorsElements = flavorStuff[indexPath.row]
        
        return preferencesCell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let currentCell = preferencesCollectionView.cellForItem(at: indexPath) as? signUpCellDesign else { return }

        currentCell.flavorsElements = flavorStuff[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let currentCell = preferencesCollectionView.cellForItem(at: indexPath) as? signUpCellDesign else { return }
        currentCell.flavorsElements = flavorStuff[indexPath.row]
    }
}
