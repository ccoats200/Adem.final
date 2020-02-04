//
//  customPreferences.swift
//  Adem
//
//  Created by Coleman Coats on 1/25/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

struct Model {
   var title: String
}

class ViewModelItem {
   private var item: Model
   var isSelected = false
   var title: String {
      return item.title
   }
   init(item: Model) {
      self.item = item
   }
}

let dataArray = [Model(title: "Salty"),
Model(title: "Sweet"),
Model(title: "Spicy"),
Model(title: "Biter"),
Model(title: "Fruity")]

class addedFoodPreference: UIViewController, UICollectionViewDelegateFlowLayout {
        
    var items = [ViewModelItem]()
    
    
    var currentViewControllerIndex = 0
    let viewControllerDataSource = ["\(preferenceProgressViews())"]


    var data = [friendsListInfo]()
    var refreshControl = UIRefreshControl()
        
    //reuse ID's
    let adtest = "privacy"
    let cellHeight = 60

    //MARK: Element calls
    //var preferencesTableView: UITableView!
    var preferencesCollectionView: UICollectionView!
    var topView = preferenceProgressViews()
    var bottomView = preferenceNextViews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "please"
        view.backgroundColor = UIColor.white
        setUpSubviews()
        setuplayoutConstraints()
        
        
    }
    
    let progressView: UIView = {
        let progress = UIView()
        progress.backgroundColor = UIColor.ademBlue
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    
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
 
    let nextView: UIView = {
        let next = UIView()
        next.backgroundColor = UIColor.white
        next.translatesAutoresizingMaskIntoConstraints = false
        return next
    }()
    
    //Name Section
    let welcomeLabel: UILabel = {
        var welcome = UILabel()
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
    
    override func viewWillAppear(_ animated: Bool) {
        //var pathTest = self.preferencesTableView.indexPathForSelectedRow
        
//        if let index = self.preferencesTableView.indexPathForSelectedRow {
//            self.preferencesTableView.deselectRow(at: index, animated: true)
//        }
    }
    
    var currentPage = 0
    let numberOfPages = 3
    var prog: Float = 0.00
    
    //MARK: Arrays
    let promptArray = ["What flavors do you like?","Are you allergic?","Where do you shop?","We Know Just The Thing"]
    
    let preferencesDictionary = [0: ["Salty","Sweet","Spicy","Biter","Fruity"],
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
            topView.pBar.progress = prog
        }
        //preferencesTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        coverMeImReloading()
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

    func deselectOnRefresh() {
        if currentPage != 0 {
            //preferencesTableView.indexPathForSelectedRow
        }
    }

    //var selectedFoodPreferencesCells = [IndexPath]()
    var selectedFoodPreferencesCells = [String]()

    
    private func setUpSubviews() {
        

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: (self.view.frame.height)/10, left: 0, bottom: 0, right: 0)
    
        //layout.scrollDirection = .horizontal
        preferencesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        //preferencesTableView = UICollectionView(frame: self.frame, collectionViewLayout: layouts)

        layout.itemSize = CGSize(width: (view.frame.width)/2, height: 60)
        preferencesCollectionView.register(signUpCellDesign.self, forCellWithReuseIdentifier: cellID)

        //MARK: CollectionView attributes
        preferencesCollectionView.dataSource = self
        preferencesCollectionView.delegate = self
        preferencesCollectionView.backgroundColor = .white
        preferencesCollectionView.isScrollEnabled = true
        preferencesCollectionView.allowsMultipleSelection = true
        preferencesCollectionView.backgroundColor = UIColor.white
        
        view.addSubview(welcomeLabel)
        view.addSubview(preferencesCollectionView)
        view.addSubview(textFieldSeparator)
        

        textFieldSeparator.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesCollectionView.translatesAutoresizingMaskIntoConstraints = false

        
        topView.closePreferencesButton.addTarget(self, action: #selector(handelDismiss), for: .touchUpInside)
        bottomView.nextButton.addTarget(self, action: #selector(handelNext), for: .touchDown)
    }
    
    let cellID = "Test"
    
    private func setuplayoutConstraints() {
        
        
           NSLayoutConstraint.activate([
            
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textFieldSeparator.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            textFieldSeparator.centerXAnchor.constraint(equalTo: welcomeLabel.centerXAnchor),
            textFieldSeparator.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24),
            textFieldSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            preferencesCollectionView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            preferencesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            preferencesCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            preferencesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
}

extension addedFoodPreference: UICollectionViewDelegate, UICollectionViewDataSource {

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
        //currentCell?.layer.borderColor = UIColor.ademGreen.cgColor
        currentCell?.preferencesIcon.backgroundColor = UIColor.ademGreen
        currentCell?.preferencesIcon.tintColor = UIColor.red
        //currentCell?.layer.borderWidth = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let currentCell = preferencesCollectionView.cellForItem(at: indexPath) as? signUpCellDesign
        //currentCell?.layer.borderColor = UIColor.ademGreen.cgColor
        currentCell?.preferencesIcon.backgroundColor = nil
    }
    
}
/*
extension addedFoodPreference: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        //for page in firstPage...lastPage {
            
        //}
        
        
        switch firstPage {
        case 0:
            return tasteProfile.count
            //return items.count
        case 1:
            return dietPreferences.count
        case 2:
            return storePreferences.count
        case 3:
            return thanks.count
        default:
            return thanks.count
        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let prefereneces = tableView.dequeueReusableCell(withIdentifier: self.adtest, for: indexPath) as? preferencesCustomCell
        
        let pref = tableView.dequeueReusableCell(withIdentifier: self.adtest, for: indexPath)
        

        pref.layer.cornerRadius = 10
        
        pref.layoutMargins = UIEdgeInsets.zero
        pref.contentView.layoutMargins.top = 20
        pref.contentView.layoutMargins.bottom = 20
        
        //Change the checkmark color
        pref.tintColor = UIColor.ademGreen
        pref.clipsToBounds = true
        pref.textLabel?.textAlignment = .center
        
//        if items[indexPath.row].isSelected {
//                   tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none) // (3)
//                } else {
//                   tableView.deselectRow(at: indexPath, animated: false) // (4)
//                }
        
        
        
        //needs a guard let statment to protect against screen switching without the data reloading
        switch firstPage {
        case 0:
            //pref.textLabel?.text = items[indexPath.row]
            
            pref.textLabel!.text = tasteProfile[indexPath.row]
        case 1:
            
            pref.textLabel!.text = dietPreferences[indexPath.row]
            //self.preferencesTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            //pref.isSelected = false
        case 2:
            pref.textLabel!.text = storePreferences[indexPath.row]
        case 3:
            pref.textLabel!.text = thanks[indexPath.row]
        default:
            pref.textLabel!.text = thanks[indexPath.row]
        }

        return pref
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let currentCell = preferencesTableView.cellForRow(at: indexPath)
            currentCell?.selectionStyle = .none
            
            //TODO: When the cells reload deselect the cells
            currentCell?.accessoryType = .checkmark
            selectedFoodPreferencesCells.insert(currentCell?.textLabel!.text! ?? "empty", at: 0)
            //selectedFoodPreferencesCells.insert(currentCell?[indexPath.row], at: 0)

            //print(currentCell?.textLabel!.text)
            print(selectedFoodPreferencesCells)
            //preferencesTableView.deselectRow(at: indexPath, animated: false)
        }
    
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            
            let currentCell = preferencesTableView.cellForRow(at: indexPath)
            currentCell?.accessoryType = .none
            selectedFoodPreferencesCells.remove(at: 0)
            
         /*
            for cell in selectedFoodPreferencesCells {
                if firstPage != 0 {
                    cell.
                }
            }
     */
            /*
            if let indexValue = selectedFoodPreferencesCells.index(of: "\(currentCell?.textLabel!.text)") {
                selectedFoodPreferencesCells.remove(at: indexValue)
            }
    */
            
            print(selectedFoodPreferencesCells)
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
    
}
*/
