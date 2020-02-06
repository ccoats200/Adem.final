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
        reason.text = "This helps us recommend new foods and meals that you might enjoy."
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
    
    let preferencesDictionary = [0: ["Salty","Sour","Sweet","Biter","Savory","Spicy","Fruity","Skip"],
    1: ["Vegetarian","Vegan","Nuts","Lactose","Not on here", "None", "please"],
    2: ["Walmart","Wegmans","Vons","Stater Bros","Not on here", "None", "please","work"],
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

        return CGSize(width: collectionViewSize/2, height: 60)
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

extension addedFlavorPreferences: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch currentPage {
        case currentPage:
            return preferencesDictionary[currentPage]!.count
        default:
            return preferencesDictionary[3]!.count
        }
    }
    
    //var emptyDict: [String: String] = [:]
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let preferencesCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! signUpCellDesign
        preferencesCell.layer.cornerRadius = 5
        //preferencesCell.layer.borderWidth = 1
        //preferencesCell.backgroundColor = UIColor.red
      
        //signInFlowViewControllerTwo().dataSource = self as! UIPageViewControllerDataSource
        
        
        switch currentPage {
        case currentPage:
            for (number, options) in preferencesDictionary {
            if number == currentPage {
                preferencesCell.preferencesLabel.text = options[indexPath.row]
            }
        }
        
        default:
            preferencesCell.preferencesLabel.text = "Something Went Wrong... Let me check the recipe"
        }
        return preferencesCell
        
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = preferencesCollectionView.cellForItem(at: indexPath) as? signUpCellDesign
        currentCell?.preferencesIcon.backgroundColor = UIColor.ademGreen
        currentCell?.preferencesIcon.tintColor = UIColor.red
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let currentCell = preferencesCollectionView.cellForItem(at: indexPath) as? signUpCellDesign
        currentCell?.preferencesIcon.backgroundColor = nil
    }
    
}

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
    let preferencesDictionary = [0: ["Vegetarian","Vegan","Nuts","Lactose","Not on here", "None", "please"]]

    
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

           return CGSize(width: collectionViewSize/2, height: 60)
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
        preferencesCell.layer.cornerRadius = 5
      
        //signInFlowViewControllerTwo().dataSource = self as! UIPageViewControllerDataSource
    
            for (number, options) in preferencesDictionary {
                preferencesCell.preferencesLabel.text = options[indexPath.row]
            }
        return preferencesCell
        
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = preferencesCollectionView.cellForItem(at: indexPath) as? signUpCellDesign
        currentCell?.preferencesIcon.backgroundColor = UIColor.ademGreen
        currentCell?.preferencesIcon.tintColor = UIColor.red
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let currentCell = preferencesCollectionView.cellForItem(at: indexPath) as? signUpCellDesign
        currentCell?.preferencesIcon.backgroundColor = nil
    }
    
}


class addedStorePreferencesTwo: UIViewController, UICollectionViewDelegateFlowLayout {

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
        welcome.text = "Where do you shop?"
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
    
    let infoLabel: UILabel = {
        var reason = UILabel()
        reason.text = "You can sync all or none of your loyalty accounts to get better insights into your habits."
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
    let preferencesDictionary = [0: ["Walmart","Wegmans","Vons","Stater Bros","Not on here", "None", "please","work"]]

    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    //var selectedFoodPreferencesCells = [IndexPath]()
    var selectedFoodPreferencesCells = [String]()

    private func setUpSubviews() {
        

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
        //layout.scrollDirection = .horizontal
        preferencesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        layout.itemSize = CGSize(width: (view.frame.width)/2, height: 60)
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

extension addedStorePreferencesTwo: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

       
        return preferencesDictionary[0]!.count
    }
    
    //var emptyDict: [String: String] = [:]
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let preferencesCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! signUpCellDesign
        preferencesCell.layer.cornerRadius = 5
      
        //signInFlowViewControllerTwo().dataSource = self as! UIPageViewControllerDataSource
    
            for (number, options) in preferencesDictionary {
                preferencesCell.preferencesLabel.text = options[indexPath.row]
            }
        return preferencesCell
        
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = preferencesCollectionView.cellForItem(at: indexPath) as? signUpCellDesign
        currentCell?.preferencesIcon.backgroundColor = UIColor.ademGreen
        currentCell?.preferencesIcon.tintColor = UIColor.red
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let currentCell = preferencesCollectionView.cellForItem(at: indexPath) as? signUpCellDesign
        currentCell?.preferencesIcon.backgroundColor = nil
    }
    
}

class thankYouPreferences: UIViewController {

    var currentViewControllerIndex = 0

    //MARK: Element calls
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white
        
        setUpSubviews()
        setuplayoutConstraints()
    }
    
    
    
    //Name Section
    let welcomeLabel: UILabel = {
        var welcome = UILabel()
        welcome.text = "Welcome to Adem!"
        welcome.textAlignment = .center
        welcome.numberOfLines = 0
        welcome.textColor = UIColor.ademBlue
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
    
    let ademImageHolder: UIImageView = {
        let ademImage = UIImageView()
        ademImage.image = UIImage(named: "Adem Logo")
        ademImage.backgroundColor = UIColor.red
        ademImage.contentMode = .scaleAspectFit
        
        return ademImage
    }()
    
    //Name Section
    let subText: UILabel = {
        var subtext = UILabel()
        subtext.text = "We're adding your preferences so that we can give you the best experience!"
        subtext.textAlignment = .center
        subtext.numberOfLines = 0
        subtext.textColor = UIColor.ademBlue
        subtext.font = UIFont(name: helNeu, size: 20.0)
        subtext.translatesAutoresizingMaskIntoConstraints = false
        
        return subtext
    }()

    
    override func viewWillAppear(_ animated: Bool) {

    }

    private func setUpSubviews() {
        
        //MARK: subviews
        view.addSubview(welcomeLabel)
        view.addSubview(textFieldSeparator)
        view.addSubview(ademImageHolder)
        view.addSubview(subText)
        

        //TODO: this should be a loading or animation to indicate saving
//        welcomeLabel.layer.borderWidth = 2
//        welcomeLabel.layer.borderColor = UIColor.ademGreen.cgColor
//        welcomeLabel.layer.cornerRadius = 75
        
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldSeparator.translatesAutoresizingMaskIntoConstraints = false
        ademImageHolder.translatesAutoresizingMaskIntoConstraints = false
        subText.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func setuplayoutConstraints() {
        
           NSLayoutConstraint.activate([
            
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            
            textFieldSeparator.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            textFieldSeparator.heightAnchor.constraint(equalToConstant: 1),
            textFieldSeparator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldSeparator.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            
            ademImageHolder.topAnchor.constraint(equalTo: textFieldSeparator.bottomAnchor, constant: 50),
            ademImageHolder.heightAnchor.constraint(equalToConstant: 150),
            ademImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ademImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            
            subText.topAnchor.constraint(equalTo: ademImageHolder.bottomAnchor),
            subText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            subText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subText.widthAnchor.constraint(equalTo: view.widthAnchor, constant:  -25),
            
        ])
    }
    
}
