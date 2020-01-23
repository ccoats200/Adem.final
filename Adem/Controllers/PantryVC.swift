//
//  PantryVC.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore
import AVFoundation


class PantryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {

    
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
                //collectionView.allowsSelection = false
                listCollectionView.allowsSelection = false
                print("User is in view mode")
            case .selected:
                edit.title = "Done"
                //collectionView.allowsSelection = true
                listCollectionView.allowsSelection = true
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
    var listProducts: [groceryItemCellContent] =  []
    
    //TODO: what do these do?
    //var products: [groceryProductsStruct] = groceryProducts.fetchGroceryProductImages()
    var selectedGroceryItems = [groceryItemCellContent]()
    var selectedCells = [UICollectionViewCell]()
    var groceriesSelected = [String]()
    
    var searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK: NavigationBar setup
        navigationItem.title = "Pantry"
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
        
        //Drag and Drop
        //self.collectionView.dragDelegate = self
        //self.collectionView.dropDelegate = self
        //self.collectionView.dragInteractionEnabled = true
        
        
        //MARK: Cirular transition
        //navigationController?.delegate = transitionCoordinator as? UINavigationControllerDelegate

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
        guard switchDefaults else {
            return setUpCollectionView()
        }
        
           //if switchDefaults != true {
               
           //}
       }
    
    //MARK: Setting up Collection View
    var productUpdateLocationButtonView = addOrDeleteProduct()
    var listCollectionView: UICollectionView!
    
    func setUpCollectionView() {

        //SetUp views from own class
        view.addSubview(productUpdateLocationButtonView)
        productUpdateLocationButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        let layouts: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        listCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layouts)
        
        listCollectionView.register(itemCellLayout.self, forCellWithReuseIdentifier: cellID)
        listCollectionView.dataSource = self
        listCollectionView.delegate = self
        self.view.addSubview(listCollectionView)
        
        listCollectionView.backgroundColor = UIColor.white
        listCollectionView.isUserInteractionEnabled = true
        listCollectionView.isScrollEnabled = true
        listCollectionView.isPrefetchingEnabled = true
                
        //FIXME: Search bar won't go back to hidden if there aren't enough cells
        listCollectionView.bounces = true
        listCollectionView.alwaysBounceVertical = true
        
        
        //Maybe delete https://theswiftdev.com/2018/06/26/uicollectionview-data-source-and-delegates-programmatically/
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //TODO: Need to understand
        listCollectionView.contentInset = UIEdgeInsets.init(top: 10, left: 5, bottom: 1, right: 5)
        listCollectionView.showsVerticalScrollIndicator = true
        
        //FIXME: Size of cell
        let Columns: CGFloat = 3.14
        let insetDimension: CGFloat = 10.0
        let cellHeight: CGFloat = 125.0
        let cellWidth = (listCollectionView.frame.width/Columns) - insetDimension
        layouts.itemSize = CGSize(width: cellWidth, height: cellHeight)
        print("the sss = \(listCollectionView.frame.width/3 - insetDimension)")
        
        //Collection View contstaints
        //TODO: Decide if I remove the other View
        NSLayoutConstraint.activate([
            listCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: productUpdateLocationButtonView.topAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productUpdateLocationButtonView.heightAnchor.constraint(equalToConstant: 75),
            productUpdateLocationButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            productUpdateLocationButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productUpdateLocationButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])

        
        //User interations
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(addLongGestureRecognizer))
        lpgr.minimumPressDuration = 0.35
        self.listCollectionView.addGestureRecognizer(lpgr)
    }
    
    
    //MARK: CollectionView for Filtering
    var filterCollectionView: UICollectionView!
    let cfilter = "test"
    //MARK: Table View
    var listTableView: UITableView!
    //TODO: Does this need to be a weak var?
    func setUpListView() {
        
        let layouts: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        filterCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layouts)
        
        //filterCollectionView.register(filterCellLayout.self, forCellWithReuseIdentifier: cfilter)
        filterCollectionView.register(itemCellLayout.self, forCellWithReuseIdentifier: cellID)
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        
        filterCollectionView.backgroundColor = UIColor.ademBlue
        filterCollectionView.isUserInteractionEnabled = true
        filterCollectionView.isScrollEnabled = true
        filterCollectionView.isPrefetchingEnabled = true
        
        //Maybe delete https://theswiftdev.com/2018/06/26/uicollectionview-data-source-and-delegates-programmatically/
        
        
        
        //TODO: Need to understand
        filterCollectionView.contentInset = UIEdgeInsets.init(top: 10, left: 5, bottom: 1, right: 5)
        filterCollectionView.showsVerticalScrollIndicator = true
        
        //FIXME: Size of cell
        let cellHeight: CGFloat = 50
        let cellWidth: CGFloat = 10
        layouts.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
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
     
        self.view.addSubview(filterCollectionView)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //View contstaints
        
        //TODO: Decide if I remove the other View
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 100),
            filterCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            listTableView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        //listTableView.isEditing = true
    }
    
    //MARK: Head and Footer for tableView
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            let test = "This needs to be filter options"
            return test
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
           footerView.backgroundColor = UIColor.ademBlue
        
        //let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        
        //label.text = "Adem is further than it was this morning"
        //footerView.addSubview(label)
           return footerView
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
        contextItem.backgroundColor = UIColor.ademBlue
        
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
    
    //MARK: Table view cell properties - Start
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allproductsInList.count
        //return settingsOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let productsListViewLayout = tableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath) as! listTableViewCell
        let productsListViewLayout = tableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath)
        //let row = indexPath.row
        
        //productsListViewLayout.textLabel?.text = settingsOptions[row]
        //productsListViewLayout.imageView?.image = UIImage(named: "nutritionFacts")
        productsListViewLayout.imageView?.image = UIImage(named: "egg")
        productsListViewLayout.textLabel!.text = settingsOptions[indexPath.row]
        productsListViewLayout.accessoryType = .disclosureIndicator
        return productsListViewLayout
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cellRow = indexPath.row
        handleProduct()
    }
    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        print(string + formatter.string(from: date))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
            //self.collectionView.allowsMultipleSelection = true
            self.listCollectionView.allowsMultipleSelection = true
            self.tabBarController?.tabBar.isHidden = true
            self.navigationItem.rightBarButtonItems = [added, trashed]
            
        } else {
            
            self.navigationItem.rightBarButtonItems = [searching]
            self.tabBarController?.tabBar.isHidden = false
            //self.collectionView.allowsMultipleSelection = false
            self.listCollectionView.allowsMultipleSelection = false
        }
        
        //if let indexPaths = collectionView?.indexPathsForVisibleItems {
        if let indexPaths = listCollectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = listCollectionView?.cellForItem(at: indexPath) as? itemCellLayout {
                //if let cell = collectionView?.cellForItem(at: indexPath) as? itemCellLayout {
                    cell.isEditing = editing
                }
            }
        }
    }
    
    
    
    @objc func addLongGestureRecognizer(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        
        if gestureRecognizer.state != .began { return }
        //let p = gestureRecognizer.location(in: self.collectionView)
        let p = gestureRecognizer.location(in: self.listCollectionView)
        //if let indexPath = self.collectionView.indexPathForItem(at: p) {
        if let indexPath = self.listCollectionView.indexPathForItem(at: p) {
            //let cell = self.collectionView.cellForItem(at: indexPath)
            
            navigationController?.isEditing = true
            
        } else {
            print("can't find")
        }
    }

    //MARK: CollectonView Setup
    //Number of cells. update later for collection of cells based on product type
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering() {
            return selectedGroceryItems.count
        }
        
        for i in productsGlobal! {
            print("for loop is working and there are \(listProducts.count as Any) products")
            if i.Pantry == true {
                listProducts.append(i)
            }
        }
        
        print("there are \(listProducts.count as Any) products")
        
        return allproductsInList.count
        //return listProducts.count
    }
    
    
    //Initiating cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! itemCellLayout
        let filterCells = collectionView.dequeueReusableCell(withReuseIdentifier: cfilter, for: indexPath) as! filterCellLayout
        filterCells.backgroundColor = UIColor.ademRed
        productCell.backgroundColor = UIColor.ademBlue
        
        //        for _ in (productsGlobal)! {
        //            if groceryItemCellContent().List == true {
        //                productCell.gItem = productsGlobal![indexPath.item]
        //            }
        //        }
        
        productCell.gItem = listProducts[indexPath.item]
        productCell.layer.cornerRadius = 5
        
        var productsInFilter: groceryItemCellContent
        if isFiltering() {
            productsInFilter = selectedGroceryItems[indexPath.item]
        } else {
            productsInFilter = (listProducts[indexPath.item])
        }
        return productCell
        //return filterCells
    }
    
    var groceryProductsSelected: [IndexPath] = []
    var selectedGroceryProducts = [groceryItemCellContent]()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /*
         let selectedData = selectedGroceryItems[indexPath.item]
         if groceryProductsSelected.contains(indexPath) {
         groceryProductsSelected = groceryProductsSelected.filter { $0 != indexPath }
         groceriesSelected = groceriesSelected.filter { $0 != selectedData }
         
         }
         */
        
        
        //let selectedCell: pantryCellLayout = collectionView.cellForItem(at: indexPath as IndexPath)! as! pantryCellLayout
        
        switch isEditing {
        case true:
            selectedProductsIndexPath[indexPath] = true
        case false:
            collectionView.deselectItem(at: indexPath, animated: true)
            handleProduct()
            
            /*
             switch indexPath.item {
             case 1:
             handleProduct()
             default:
             handleAlert()
             }*/
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
        if isEditing {
            selectedProductsIndexPath[indexPath] = false
        }
    }
    
    
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
        //collectionView.deleteItems(at: groceryProductsSelected)
        listCollectionView.deleteItems(at: groceryProductsSelected)
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
        //collectionView.deleteItems(at: groceryProductsSelected)
        listCollectionView.deleteItems(at: groceryProductsSelected)
        selectedProductsIndexPath.removeAll()
        setEditing(false, animated: false)
        
        //listCollectionView().collectionView.reloadData()
        groceryProductsSelected = []
    }

    
    //product Button
    @objc func handleSearch() {
        
        //self.navigationItem.searchController = searchController
        //searchController.isActive = true
        
        print("Settings Tab is active")
    }
    
    //product Button
    @objc func handleProduct() {
        
        //transition testing
        //let transitionCoordinator = TransitionCoordinator()
        
        //let cController = productVCLayout()
        let productScreen = pantryProductVCLayout()
        productScreen.hidesBottomBarWhenPushed = true
        //transition testing
        //cController.transitioningDelegate = TransitionCoordinator.self as? UIViewControllerTransitioningDelegate
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
    
    
    //Space between rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
