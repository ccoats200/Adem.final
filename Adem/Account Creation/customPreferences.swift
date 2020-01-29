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

class addedFoodPreference: UIViewController {
        
    var items = [ViewModelItem]()
//    init() {
//        items = dataArray.map { ViewModelItem(item: $0) }
//    }
    
    
    
    
    var data = [friendsListInfo]()
    var refreshControl = UIRefreshControl()
        
    //reuse ID's
    let adtest = "privacy"
    let cellHeight = 60

    //MARK: Element calls
    var preferencesTableView: UITableView!
    var topView = preferenceProgressViews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setUpSubviews()
        setuplayoutConstraints()
        
        //MARK: Tableview attributes
        preferencesTableView.dataSource = self
        preferencesTableView.delegate = self
        preferencesTableView.separatorStyle = .none
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
    
    override func viewWillAppear(_ animated: Bool) {
        //var pathTest = self.preferencesTableView.indexPathForSelectedRow
        
        if let index = self.preferencesTableView.indexPathForSelectedRow {
            self.preferencesTableView.deselectRow(at: index, animated: true)
        }
    }
    
    var firstPage = 0
    let lastPage = 4
    //TODO: Should only be the number of arrays
    let numberOfPages = 3
    var prog: Float = 0.00
    
    @objc func handelNext() {
        
        //FIXME: This may be better as a if
        while firstPage < lastPage {
            firstPage+=1
            break
        }
        
        if prog < Float(lastPage/lastPage) {
            prog += (Float(lastPage/lastPage)/Float(numberOfPages))
            print(prog)
            topView.pBar.progress = prog
        }
        //topView.pBar.setProgress(Float(prog+0.25), animated: true)
        preferencesTableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        preferencesTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    let tasteProfile = ["Salty","Sweet","Spicy","Biter","Fruity"]
    let dietPreferences = ["Vegetarian","Vegan","Nuts","Lactose","Not on here", "None", "please"]
    let storePreferences = ["Walmart","Wegmans","Vons","Stater Bros","Not on here", "None", "please","work"]
    let thanks = ["Thanks"]

    func deselectOnRefresh() {
        if firstPage != 0 {
            //preferencesTableView.indexPathForSelectedRow
        }
    }

    //var selectedFoodPreferencesCells = [IndexPath]()
    var selectedFoodPreferencesCells = [String]()
    //let allItems = [Items]()
    //var selectedItems = [Items]()
    //var selectedFoodCells = [UITableViewCell]()
    
    
    private func setUpSubviews() {
        
        preferencesTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        preferencesTableView.register(UITableViewCell.self, forCellReuseIdentifier: adtest)
        

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
        
    }
    
    
    private func setuplayoutConstraints() {
        
        
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
