//
//  ListVC.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import AVFoundation
import CoreData

class listCollectionView: UIViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {

    
    //Cells Selected stuff
    enum Mode {
        case view
        case selected
    }
    
    var mMode: Mode = .view {
        didSet {
            switch mMode {
            case .view:
                edit.title = "Edit"
                print("User is in view mode")
            case .selected:
                edit.title = "Done"
                print("User is in edit mode")
            }
        }
    }

    
    //MARK: Navigation Bar Buttons - Start
    lazy var searching = UIBarButtonItem(image: UIImage(named: "cart_1")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    
    lazy var added = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleBatchAdd))
    
    lazy var edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditButtonClicked))
    
    lazy var trashed = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleBatchDelete))
    //MARK: Navigation buttons - End
    
    
    let mostRecent = "most recent"
    let productRFIDNumber = "3860407808"
 
    //MARK: Cell re-use ID
    let tableViewCell = "test"
    let cellID = "product"
    let headerID = "collectionViewHeader"
    
    //Populate List
    var settingsOptions = ["List view","Account","About","Privacy","Security","Help","Log out"]
    //Populate colllection
    
    //TODO: what do these do?
    //var products: [groceryProductsStruct] = groceryProducts.fetchGroceryProductImages()
    var selectedGroceryItems = [groceryItemCellContent]()
    var selectedCells = [UICollectionViewCell]()
    var groceriesSelected = [String]()
    
    var searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK: NavigationBar setup
        navigationItem.title = "List"
        //MARK: might be for ios 12
        //let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.ademBlue]
        //navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        //navigationController?.navigationBar.barTintColor = UIColor.ademGreen
        //navigationController?.navigationBar.titleTextAttributes = textAttributes
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.isTranslucent = false
        //navigationController?.navigationBar.scrollEdgeAppearance
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.ademGreen
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
        }
        
        //MARK: Search bar
        self.searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        self.searchController.isActive = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocorrectionType = .default
        searchController.searchBar.enablesReturnKeyAutomatically = true
        searchController.obscuresBackgroundDuringPresentation = true
        self.searchController.searchBar.placeholder = "What Can I Add For You?"
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        //refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        setUpBarButtonItems()
    }
    
    //MARK: Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listScreenDesign()
        
           self.navigationController?.view.layoutIfNeeded()
           self.navigationController?.view.setNeedsLayout()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.searchController.isActive = false
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
       }
       
    
    //MARK: Refresh
    var refreshControl = UIRefreshControl()
    @objc func refresh(sender: AnyObject) {
        //TODO: Code to refresh table view
    }
    
    //MARK: Setting up NAV bar buttons
    private func setUpBarButtonItems() {
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
        self.navigationItem.rightBarButtonItem = searching
    }

    
    func listScreenDesign() {
        setUpListView()
        
        let switchDefaults = UserDefaults.standard.bool(forKey: "SwitchKey")
     
       }
    

    //MARK: Table View
    var listTableView: UITableView!
    //TODO: Does this need to be a weak var?
    func setUpListView() {
        
        //SetUp views from own class
        //let ss: CGRect = UIScreen.main.bounds
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
    
        listTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        listTableView.backgroundColor = UIColor.white
        
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCell)
        //listTableView.register(listTableViewCell.self, forCellReuseIdentifier: tableViewCell)
        listTableView.dataSource = self
        listTableView.delegate = self
        
        self.view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
     
        //View contstaints
        
        //TODO: Decide if I remove the other View
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        //listTableView.isEditing = true
    }
    
  
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            boolValue(true) // pass true if you want the handler to allow the action
            print("Leading Action style .normal")
        }
        deleteItem.backgroundColor = UIColor.ademRed
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem])

        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->   UISwipeActionsConfiguration? {

      // Get current state from data source https://useyourloaf.com/blog/table-swipe-actions/
      let contextItem = UIContextualAction(style: .normal, title: "Add") { (contextualAction, view, boolValue) in
            boolValue(true) // pass true if you want the handler to allow the action
            print("Leading Action style .normal")
        }
        let addtopantry = UIContextualAction(style: .normal, title: "Pantry") { (contextualAction, view, boolValue) in
            boolValue(true) // pass true if you want the handler to allow the action
            print("Leading Action style .normal")
        }
        addtopantry.backgroundColor = UIColor.ademGreen
        contextItem.backgroundColor = UIColor.ademBlue
        
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem, addtopantry])

        return swipeActions
    }
    
    
    var listProducts: [groceryItemCellContent] =  []
    //MARK: Table view cell properties - Start
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        for i in productsGlobal! {
            if i.List == true {
                listProducts.append(i)
            }
            //print("for loop is working and there are \(listProducts.count as Any) products")
        }
        print("\(productsGlobal?.count)")
        
        //return settingsOptions.count
        return listProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let productsListViewLayout = tableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath) as! listTableViewCell
        let productsListViewLayout = tableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath)
        //let row = indexPath.row
        
        //productsListViewLayout.textLabel?.text = settingsOptions[row]
        //productsListViewLayout.imageView?.image = UIImage(named: "nutritionFacts")
        productsListViewLayout.imageView?.image = UIImage(named: "egg")
        //productsListViewLayout.textLabel!.text = settingsOptions[indexPath.row]
        //productsListViewLayout.textLabel!.text = listProducts[indexPath.row]
        productsListViewLayout.accessoryType = .disclosureIndicator
        return productsListViewLayout
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cellRow = indexPath.row
        handleProduct()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
           footerView.backgroundColor = UIColor.ademBlue
        
        //let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        
        //label.text = "Adem is further than it was this morning"
        //footerView.addSubview(label)
           return footerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = 50
        
        return CGFloat(cellHeight)
    }
    //MARK: Table view cell properties - End
    
    // MARK: - Private instance methods
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        selectedGroceryItems = (listProducts.filter({( groceryItems : groceryItemCellContent) -> Bool in
            return (groceryItems.itemName?.lowercased().contains(searchText.lowercased()))!
        }))
        //TODO: Why is this breaking when I switch back from list to collection view
        
        //collectionView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    /*
    func setupKeyboardDismissRecognizer(){
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(listCollectionView.searchBarSearchButtonClicked))
        
        
        self.view.addGestureRecognizer(tapRecognizer)
        //setup()
    }
   */
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        //filterContentForSearchText(searchController.searchBar.text!)
        
        
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString =
            searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        
    }
  
    
    // MARK: - Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if self.isEditing {
            self.navigationItem.rightBarButtonItem = nil
            self.tabBarController?.tabBar.isHidden = true
            self.navigationItem.rightBarButtonItems = [added, trashed]
            
        } else {
            
            self.navigationItem.rightBarButtonItems = [searching]
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    var groceryProductsSelected: [IndexPath] = []
    var selectedGroceryProducts = [groceryItemCellContent]()
    
   
    
    //Button Functions - Start
    var selectedProductsIndexPath: [IndexPath: Bool] = [:]
    
    @objc func handleBatchDelete() {
        
        for (key, value) in selectedProductsIndexPath {
            if value {
                groceryProductsSelected.append(key)
            }
        }
        
        for i in listProducts {
            if i.Pantry == true {
                i.Pantry = false
            }
        }
        let nada = "nada"
        for i in groceryProductsSelected.sorted(by: { $0.item > $1.item }) {
            print("User is about to remove \(listProducts[i.item].itemName ?? nada) from their pantry and delete it from their list and pantry")
            listProducts.remove(at: i.item)
        }
        selectedProductsIndexPath.removeAll()
        setEditing(false, animated: false)
    }
    
    //Edit Button
    @objc func handleEditButtonClicked() {
        if mMode == .view {
            setEditing(true, animated: false)
        } else {
            setEditing(false, animated: false)
        }
        //setEditing(true, animated: false)
        mMode = mMode == .view ? .selected : .view
        print("Edit button was clicked")
    }
    
    //Add item back
    @objc func handleBatchAdd() {
        
        for (key, value) in selectedProductsIndexPath {
            if value {
                groceryProductsSelected.append(key)
            }
        }
        
        //watch out for nil val in future
        for i in listProducts {
            print("there were \(listProducts.count as Any) products")
            
            if i.List == true {
                i.List = false
                i.Pantry = true
            }
        }
        
        let nada = "nada"
        for i in groceryProductsSelected.sorted(by: { $0.item > $1.item }) {
            
            
            print("User is about to remove \(listProducts[i.item].itemName ?? nada) from their pantry and add it to their list")
            listProducts.remove(at: i.item)
            
        }
        selectedProductsIndexPath.removeAll()
        setEditing(false, animated: false)
        
        //listCollectionView().collectionView.reloadData()
        groceryProductsSelected = []
    }

    
    //product Button
    @objc func handleSearch() {

    }
    
    //product Button
    @objc func handleProduct() {
        
        let productScreen = pantryProductVCLayout()
        productScreen.hidesBottomBarWhenPushed = true
        productScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(productScreen, animated: true, completion: nil)
        
        print("Settings Tab is active")
    }
    //Button Functions - End
    
    
    //Search Button
    @objc func handleAlert() {
        
        let alert = addedItemAlert()
        alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(alert, animated: true, completion: nil)
        
    }

}
