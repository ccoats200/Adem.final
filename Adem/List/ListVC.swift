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
import AVFoundation
import CoreData
import FirebaseFirestoreSwift

class listViewController: UIViewController, UISearchControllerDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate {

    
//    MARK: Navigation Bar Buttons - Start
    lazy var cam = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(handlecamera))
//    lazy var add = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))
//    lazy var trashed = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleBatchDelete))
    //MARK: Navigation buttons - End
    
    //    MARK: - Var & Let
    let mostRecent = "most recent"
    let productRFIDNumber = "3860407808"
        
    //    MARK: FireBase List
    var products: [food] = [food]()
    var productsInList = [fireStoreDataClass]()
    var productsInListArray = arrayofProducts
    //    MARK: Search Controller implementation
    var tableViewSearchController: UISearchController!
    private var resultsTableController: ResultsTableController!
        
        
    //https://stackoverflow.com/questions/48569818/how-to-use-custom-view-controller-in-uisearchcontroller-for-results
    var tableArray = [String]()
    //    MARK: - Search bar
    var filteringproducts = arrayofProducts
    var filteredProducts: [String]?
    var filterProducts: [fireStoreDataStruct] = []
    
//    MARK: Table view
    var listTableView: UITableView!
    let tableViewCell = "test"
    let cellID = "product"
    let headerID = "collectionViewHeader"
//    MARK: Collection View
    var filterListCollectionView: UICollectionView!
    let cfilter = "test"
//    MARK: Filter
    var filter = [fireStoreDataStruct]()
    var productFilter = [fireStoreDataStruct]()
    //    MARK: - Var & Let
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        MARK: NavigationBar setup
        navigationItem.title = "List"
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.ademGreen
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationItem.rightBarButtonItem = cam

            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
            //MARK: Opt out of dark mode
            //overrideUserInterfaceStyle = .light
        } else {
            //Revert to default
        }
        //MARK: - sign in confirmation
        alreadySignedIn()
////        MARK: Search bar
//        searchBarSetUp()
//
////        MARK: Switch open view
//        switch productsGlobal?.isEmpty {
////        switch arrayofProducts.isEmpty {
//        case true:
//            tableViewIsEmpty()
//        default:
//            tableViewSetup()
//
//        }
//
////        MARK: Setting up NAV bar buttons
//        //self.navigationItem.leftBarButtonItem = editButtonItem
//        //self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
//
//        toolBarSetUp()
//        setUpFilterView()
//
//        //Firebase working below
//        firebaseDataFetch()
//        getFilterOptions()
    }
    
    //MARK: Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpLayouts()
            
        let switchDefaults = UserDefaults.standard.bool(forKey: "SwitchKey")
        print(currentUser?.email)
        handle = firebaseAuth.addStateDidChangeListener { (auth, user) in
            self.listTableView.reloadData()
        }
    }
    
    func setUpLayouts() {
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
//            firebaseAuth.removeStateDidChangeListener(handle!)
    }
    
    func alreadySignedIn() {
        
        if currentUser == nil {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = login()
            appDelegate.window?.makeKeyAndVisible()
        } else {
            //MARK: Search bar
            searchBarSetUp()
            //MARK: Switch open view
            tableViewSetup()
//            switch productsGlobal?.isEmpty {
////        switch arrayofProducts.isEmpty {
//            case true:
//                tableViewIsEmpty()
//            default:
//                tableViewSetup()
//            }
            //MARK: Setting up NAV bar buttons
            //self.navigationItem.leftBarButtonItem = editButtonItem
            //self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
            toolBarSetUp()
            setUpFilterView()
                   
            //Firebase working below
            firebaseDataFetch()
            getFilterOptions()
        }
    }
    
    //MARK: Gestures
    @objc func panGestureRecognizerAction(_ gesture: UILongPressGestureRecognizer) {
        gesture.minimumPressDuration = 0.50
        
        if gesture.state == .began {
            self.becomeFirstResponder()
            self.view = gesture.view
            self.listTableView.isEditing = true
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleEditButtonClicked))
        }
    }
    

    
//    MARK: - Api Reference
    func parseJSON(product: String) {
        //https://api.spoonacular.com/food/products/search?query=pizza&apiKey=5f40f799c85b4be089e48ca83e01d3c0
        var searchterm = tableViewSearchController.searchBar.text
        let url = URL(string: "https://api.spoonacular.com/food/products/search?query=\(searchterm)&apiKey=\(apiKey)")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error ) in

          guard error == nil else {
              print("returned error")
              return
          }
            
          if error != nil {

          } else {
            print("returned error")
          }

          guard let content = data else {
              print("No data")
              return
          }

          guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                  return
          }
            if let array = json["companies"] as? [String] {
                    self.tableArray = array
                }
            print(self.tableArray)
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
        task.resume()
    }
//https://www.raywenderlich.com/3244963-urlsession-tutorial-getting-started
    //MARK: - Api end


//        MARK: -Search bar stuff - End


    
    
    
    
    //MARK: - Table view cell properties - End
    
    // MARK: - Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if self.isEditing {
            listTableView.isEditing = true
            self.navigationItem.rightBarButtonItem = nil
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.isToolbarHidden = false
        } else {
            self.navigationController?.isToolbarHidden = true
            self.navigationItem.leftBarButtonItem = nil
            self.tabBarController?.tabBar.isHidden = false
            listTableView.isEditing = false
        }
    }
    
    func toolBarSetUp() {

        let fixedWidth = 15
        let leftSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftSpacer.width = CGFloat(fixedWidth)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        let leftCenterSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let centerSpacer = UIBarButtonItem(title: "Select Groceries", style: .plain, target: nil, action: nil)
        centerSpacer.tintColor = UIColor.ademBlue
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: nil)
        let rightCenterSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let rightSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightSpacer.width = CGFloat(fixedWidth)
        self.setToolbarItems([leftSpacer, add, leftCenterSpacer, centerSpacer, rightCenterSpacer, delete, rightSpacer], animated: false)
    }
    
    //MARK: Button Functions - Start
    //Edit Button
    @objc func handleEditButtonClicked() {
        setEditing(false, animated: false)
//        if mMode == .view {
//            setEditing(true, animated: false)
//        } else {
//            setEditing(false, animated: false)
//        }
//        //setEditing(true, animated: false)
//        mMode = mMode == .view ? .selected : .view
        print("Edit button was clicked")
    }
    
    //product Button
    @objc func handlecamera() {
        if #available(iOS 13.0, *) {
            let productScreen = camVC()
            productScreen.hidesBottomBarWhenPushed = true
            productScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(productScreen, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
//    //product Button
//    @objc func handleSearch() {
//        if #available(iOS 13.0, *) {
////            let productScreen = searchController()
////            self.becomeFirstResponder()
//            productScreen.hidesBottomBarWhenPushed = true
//
//            productScreen.modalPresentationStyle = .overFullScreen
//            self.navigationController?.pushViewController(productScreen, animated: true)
////            self.present(productScreen, animated: true, completion: nil)
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//
    //MARK: bring user to product screen
    @objc func handleListProduct() {
        
        let productScreen = listProductVCLayout()
        productScreen.hidesBottomBarWhenPushed = true
        productScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(productScreen, animated: true, completion: nil)
    }
    //Search Button
    @objc func handleAlert() {
        
        let alert = addedItemAlert()
        alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(alert, animated: true, completion: nil)
    }
    
    //Button Functions - End
    
    //MARK: - Collection Filter
      
    //MARK: - Firebase lists should the app delegate

    func firebaseDataFetch() {
        
        userfirebaseProducts.whereField("productList", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
           
            guard let documents = querySnapshot?.documents else {
             print("No documents")
             return
           }
//            arrayofProducts = documents.compactMap { queryDocumentSnapshot -> fireStoreDataStruct? in
//                return try? queryDocumentSnapshot.data(as: fireStoreDataStruct.self)
//            }
            arrayofProducts = documents.compactMap { queryDocumentSnapshot -> fireStoreDataClass? in
                return try? queryDocumentSnapshot.data(as: fireStoreDataClass.self)
            }
            print("this is the new function maybe \(arrayofProducts)")
//            let firstProduct = arrayofProducts[0].id
//            let insertedIndexPath = IndexPath(index: firstProduct!.count)
//            self.listTableView.insertRows(at: [insertedIndexPath], with: .top)
            self.listTableView.reloadData()
         }
    }
    
    func getFilterOptions() {
        for i in arrayofProducts {
            productCategories.append(i.category ?? "test")
        print("categories \(productCategories)")
    }
        self.filterListCollectionView.reloadData()
    }
    
    //kinda
    func addCategory(id: String) {
        userfirebaseProducts.document(id).setData([
            "category" : "Extract"], merge: true)
    }
//MARK: - class end dont delete this }
}

//MARK: TableView Setup
extension listViewController {
    
    func tableViewSetup() {
        listTableView = UITableView(frame: self.view.bounds)
//          MARK: Subviews
        self.view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCell)
//            MARK: Constraints
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
            
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.backgroundColor = UIColor.white
        listTableView.allowsMultipleSelectionDuringEditing = true
        listTableView.allowsSelectionDuringEditing = true
            
//        MARK:- Edit Gesture
        let panGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
        self.listTableView.addGestureRecognizer(panGestureRecognizer)
    }
//    MARK: - Table View
    func tableViewIsEmpty() {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.ademRed
        self.view.addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: tableView constraints
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: view.topAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
}

//MARK: - tableView extension
extension listViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            listTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
       
    //MARK: Swipe actions
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->   UISwipeActionsConfiguration? {
        //If the product in not in the list and they are searching they can swipe to the left to add it to their list
        // Get current state from data source https://useyourloaf.com/blog/table-swipe-actions/
        let item = arrayofProducts[indexPath.row].id!
        let checkedAsInBasket = UIContextualAction(style: .normal, title: "Add") { (contextualAction, view, boolValue) in
            self.updateProductLocationValues(indexPath: item, pantry: true, list: false)
            self.addTimeStamp(id: item, action: engagements.added.rawValue)
            boolValue(true) // pass true if you want the handler to allow the action
            print("User has added the product to their basket in the store")
           }
           checkedAsInBasket.backgroundColor = UIColor.ademGreen
//           self.listTableView.reloadData()
        let swipeActions = UISwipeActionsConfiguration(actions: [checkedAsInBasket])
        return swipeActions
       }
       
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = arrayofProducts[indexPath.row].id!
        let deleteItemFromListAndPanty = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            self.updateProductLocationValues(indexPath: item, pantry: false, list: false)
            self.addTimeStamp(id: item, action: engagements.removed.rawValue)
            boolValue(true) // pass true if you want the handler to allow the action
        }
        deleteItemFromListAndPanty.backgroundColor = UIColor.ademRed
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItemFromListAndPanty])
        return swipeActions
    }
    
    //MARK: Table view cell properties - Start
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (self.tableViewSearchController.isActive) {
            return filteringproducts.count
        } else {
            return arrayofProducts.count
        }
        
//MARK: Dont delete
        //        works for population
//        return productsGlobal!.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productsListCell = listTableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath)
        productsListCell.accessoryType = .disclosureIndicator
        
        /*
        let product = arrayofProducts[indexPath.row]
//        works for population on didset
//        let product = productsGlobal![indexPath.row]
        productsListCell.textLabel?.text = product.productName
        */
        
        if (tableViewSearchController.isActive) {
            let product = filteringproducts[indexPath.row]
            productsListCell.textLabel?.text = product.productName
            return productsListCell
            
        } else {
            let product = arrayofProducts[indexPath.row]
            productsListCell.textLabel?.text = product.productName
            return productsListCell
        }
//        return productsListCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //https://developer.apple.com/documentation/uikit/view_controllers/displaying_searchable_content_by_using_a_search_controller
        //work backwards
        let selectedProduct: fireStoreDataClass!
//        if tableView === self.listTableView {
//            selectedProduct = product(forIndexPath: indexPath)
//        }
        
        if self.listTableView.isEditing {
            
//            var selectedRows = listTableView.indexPathsForSelectedRows
//            var items = [String]()
//
//            for indexPath in selectedRows {
//                items.append(arrayofProducts[indexPath.row])
//            }
        } else {
            addTimeStamp(id: arrayofProducts[indexPath.row].id!, action: engagements.engaged.rawValue)
//        addCategory(id: arrayofIds[indexPath.row].id)
            selectedProduct = product(forIndexPath: indexPath)
            let detailViewController = listProductVCLayout.detailViewControllerForProduct(selectedProduct)

            self.present(detailViewController, animated: true, completion: nil)
            //self.present(cell, animated: true, completion: nil)
            listTableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
       
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Works
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white

        headerView.addSubview(filterListCollectionView)
//        filterListCollectionView.layer.masksToBounds = true
//        filterListCollectionView.clipsToBounds = true
        filterListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterListCollectionView.heightAnchor.constraint(equalTo: headerView.heightAnchor),
            filterListCollectionView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            filterListCollectionView.widthAnchor.constraint(equalTo: headerView.widthAnchor),
            filterListCollectionView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
        ])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if arrayofProducts.isEmpty {
            let footerView = UIView()
            footerView.backgroundColor = UIColor.white
            self.view.addSubview(footerView)
            footerView.translatesAutoresizingMaskIntoConstraints = false
            
            //MARK: tableView constraints
            NSLayoutConstraint.activate([
                footerView.topAnchor.constraint(equalTo: view.topAnchor),
                footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                ])
            return footerView
        } else {
            let footerView = UIView()
            footerView.backgroundColor = UIColor.white
            return footerView
        }
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = 60
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        setEditing(true, animated: true)
    }
    
    
}

extension listViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func setUpFilterView() {
        //move to viewdidload?
        let layouts = UICollectionViewFlowLayout()
        let collectionLayout = UICollectionViewLayout()
        layouts.itemSize = CGSize(width: 75, height: (self.view.frame.height)-1)
        filterListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layouts)
        filterListCollectionView.register(filterCellLayout.self, forCellWithReuseIdentifier: "test")

        layouts.scrollDirection = .horizontal
        filterListCollectionView.showsHorizontalScrollIndicator = false
        //Why isnt it working?
        filterListCollectionView.contentInsetAdjustmentBehavior = .never
        filterListCollectionView.backgroundColor = UIColor.white
        filterListCollectionView.dataSource = self
        filterListCollectionView.delegate = self
        filterListCollectionView.isUserInteractionEnabled = true
        filterListCollectionView.isScrollEnabled = true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = productCategories[indexPath.item]
        filterListCollectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.ademGreen
        
        let dairy = arrayofProducts.filter { ($0.category == item) }
        if item == "All" {
            firebaseDataFetch()
            filterListCollectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.ademBlue
        } else {
            
            filterListCollectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.ademGreen
            arrayofProducts = arrayofProducts.filter { ($0.category == item) }
            
            self.listTableView.reloadData()
        }
        print("Trying to filter for \(productCategories[indexPath.row])")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = filterListCollectionView.cellForItem(at: indexPath)!
        cell.backgroundColor = UIColor.ademBlue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCells = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! filterCellLayout
        filterCells.backgroundColor = UIColor.ademBlue
        filterCells.productName.text = productCategories[indexPath.row]
        return filterCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension listViewController: UISearchBarDelegate {
    
    func searchBarSetUp() {
    //        MARK: - Search bar
        tableViewSearchController = UISearchController(searchResultsController: resultsTableController)
        tableViewSearchController.delegate = self
        navigationItem.searchController = tableViewSearchController
        tableViewSearchController.searchResultsUpdater = self
        tableViewSearchController.obscuresBackgroundDuringPresentation = true
        tableViewSearchController.searchBar.sizeToFit()
        definesPresentationContext = true
        
        tableViewSearchController.searchBar.delegate = self
        
        //Design elements
        tableViewSearchController.searchBar.placeholder = "How can I help?"
        tableViewSearchController.searchBar.autocorrectionType = .default
        tableViewSearchController.searchBar.enablesReturnKeyAutomatically = true
        tableViewSearchController.hidesNavigationBarDuringPresentation = true
        tableViewSearchController.searchBar.tintColor = UIColor.white
        
        tableViewSearchController.searchBar.scopeButtonTitles = searchDimensions
        
        if #available(iOS 13.0, *) {
            self.tableViewSearchController.searchBar.searchTextField.textColor = UIColor.white
        } else {
            // Fallback on earlier versions
        }
        //https://www.iosapptemplates.com/blog/ios-programming/uisearchcontroller-swift
    }
    
    //    MARK: - Search bar start
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("started searching")
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("ended searching")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keywords = searchBar.text
    //        let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "+")
    //           searchUrl = "https://api.spotify.com/v1/search?q=\(finalKeywords!)&type=track"
        self.view.endEditing(true)
        print(keywords)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
        
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return tableViewSearchController.searchBar.text?.isEmpty ?? true
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    //        filterProductsSearchText(searchBar.text!, category: searchBar.scopeButtonTitles![selectedScope])
    }
        
    func filterProductsSearchText(for searchText: String) {
        filteringproducts = arrayofProducts.filter { fireStoreDataStruct in
            return fireStoreDataStruct.productName.lowercased().contains(searchText.lowercased())
        }
        listTableView.reloadData()
    }
            
    func searchBarisFiltering() -> Bool {
        return tableViewSearchController.isActive && !searchBarIsEmpty()
    }
            
    
        
    var isSearchBarEmpty: Bool {
        return tableViewSearchController.searchBar.text?.isEmpty ?? true
    }
        
    var isFiltering: Bool {
        return tableViewSearchController.isActive && !isSearchBarEmpty
    }
            
    func updateSearchResults(for searchController: UISearchController) {
        //https://developer.apple.com/documentation/uikit/view_controllers/displaying_searchable_content_by_using_a_search_controller
        let searchResults = arrayofProducts
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]
//        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
//            findMatches(searchString: searchString)
//        }
        
        let resultsController = tableViewSearchController.searchResultsController as? ResultsTableController
        
//        if let resultsController = tableViewSearchController.searchResultsController as? ResultsTableController {
//            resultsController.filteredProducts = filteredResults
//            resultsController.tableView.reloadData()
//
//            resultsController.resultsLabel.text = resultsController.filteredProducts.isEmpty ?
//                NSLocalizedString("NoItemsFoundTitle", comment: "") :
//                String(format: NSLocalizedString("Items found: %ld", comment: ""),
//                       resultsController.filteredProducts.count)
//        }
        
//        filterProductsSearchText(for: searchBar.text!)
//        guard let searchText = tableViewSearchController.searchBar.text else { return }
//        filterProductsSearchText(for: searchController.searchBar.text ?? "")
        
        
        
    }
}

//MARK: For product selection
extension listViewController {
    
    func product(forIndexPath: IndexPath) -> fireStoreDataClass {
        var product: fireStoreDataClass!
        product = arrayofProducts[forIndexPath.row]
        return product
    }
    
}



extension listViewController: UNUserNotificationCenterDelegate {

    
    
    //for displaying notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        //If you don't want to show notification when app is open, do something here else and make a return here.
        //Even you you don't implement this delegate method, you will not see the notification on the specified controller. So, you have to implement this delegate and make sure the below line execute. i.e. completionHandler.

        completionHandler([.alert, .badge, .sound])
    }

    // For handling tap and user actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        switch response.actionIdentifier {
        case "action1":
            print("Action First Tapped")
        case "action2":
            print("Action Second Tapped")
        default:
            break
        }
        completionHandler()
    }
}

