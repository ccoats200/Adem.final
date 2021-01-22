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
import Lottie

class listViewController: UIViewController, UISearchControllerDelegate, UIGestureRecognizerDelegate {

    
//    MARK: Navigation Bar Buttons - Start
    lazy var cam = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(handlecamera))
    lazy var find = UIBarButtonItem(image: UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAlert))
//    lazy var add = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))
//    lazy var trashed = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleBatchDelete))
    //MARK: Navigation buttons - End
    
    var filterController = filterViewController()
    
    //    MARK: - Var & Let
    let mostRecent = "most recent"
    let productRFIDNumber = "3860407808"
        
    //    MARK: FireBase List
    var products: [food] = [food]()
    var productsInList = [fireStoreDataClass]()
    var productsInListArray = arrayofProducts
    //    MARK: Search Controller implementation
    var tableViewSearchController: UISearchController!
    var resultsTableController: ResultsTableController!
    var addResultsTableController: AddResultsTableController!
        
    //Empty
    var footerView = emptyList()
    
    //https://stackoverflow.com/questions/48569818/how-to-use-custom-view-controller-in-uisearchcontroller-for-results
    var tableArray = [String]()
    //    MARK: - Search bar
    var filteringproducts = arrayofProducts
    var filteredProducts: [String]?
    var filterProducts: [fireStoreDataClass] = []
//    MARK: Table view
    var listTableView: UITableView!
    let tableViewCell = "test"
    let cellID = "product"
    let headerID = "collectionViewHeader"
//    MARK: Collection View
    //var filterListCollectionView: UICollectionView!
    //let cfilter = "filtercolletionview"
//    MARK: Filter
    var filter = [fireStoreDataClass]()
    var productFilter = [fireStoreDataClass]()
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
            setUpBarButtonItems()
            setUpLayouts()

            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
            //MARK: Opt out of dark mode
            //overrideUserInterfaceStyle = .light
        } else {
            //Revert to default
            setUpBarButtonItems()
            setUpLayouts()
        }
        firebaseDataFetch()
        setUpBarButtonItems()
        setUpLayouts()
        //MARK: - sign in confirmation
        
//        observAuthState()
        alreadySignedIn()
////        MARK: Search bar
        searchBarSetUp()

    }
    
    //MARK: Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpLayouts()
            
        print(currentUser?.email)
//        handle = firebaseAuth.addStateDidChangeListener { (auth, user) in
//            self.listTableView.reloadData()
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setUpLayouts()
        self.isEditing = false
//            firebaseAuth.removeStateDidChangeListener(handle!)
    }
    
    func observAuthState() {
        handle = firebaseAuth.addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.sendToLogIn()
            } else {
                self.sendToListScreen()
                self.listTableView.reloadData()
             
            }
        }
    }
    
    func setUpLayouts() {
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
    }
    
    
    private func setUpBarButtonItems() {
        self.navigationItem.rightBarButtonItem = cam
        self.navigationItem.leftBarButtonItem = find
        
    }

    func alreadySignedIn() {
        
        if currentUser == nil {
            sendToLogIn()
        } else {
            
            //MARK: Search bar
            searchBarSetUp()
            //FIXME: why is this not working
//            if arrayofProducts.count == 0 {
//                tableViewIsEmpty()
//            } else {
//                tableViewSetup()
//            }
            tableViewSetup()

            toolBarSetUp()
            //setUpFilterView()
            
            //MARK: Firebase working below
            firebaseDataFetch()
        }
    }
    
    //MARK: Gestures
    /*
    @objc func panGestureRecognizerAction(_ gesture: UILongPressGestureRecognizer) {
        gesture.minimumPressDuration = 0.50
        
        if gesture.state == .began {
            self.becomeFirstResponder()
            self.view = gesture.view
            self.listTableView.isEditing = true
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleEditButtonClicked))
        }
    }
    
    */
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
            //self.navigationItem.leftBarButtonItem = nil
            self.tabBarController?.tabBar.isHidden = false
            listTableView?.isEditing = false
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

    //MARK: bring user to product screen
    @objc func handleListProduct() {
        
        let productScreen = listProductVCLayout()
        productScreen.hidesBottomBarWhenPushed = true
        productScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(productScreen, animated: true, completion: nil)
    }
    
    private var detailsTransitioningDelegate: halfwayControllerTransitioningDelegate!
    //Search Button
    @objc func handleAlert() {
        getFilterOptions()
        let alert = filterViewController()
        detailsTransitioningDelegate = halfwayControllerTransitioningDelegate(from: self, to: alert)
        alert.modalPresentationStyle = UIModalPresentationStyle.custom
        alert.transitioningDelegate = detailsTransitioningDelegate
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    //Button Functions - End
      
    //MARK: - Firebase lists should the app delegate
    func isUserLoggedIn() -> Bool {
      return firebaseAuth.currentUser != nil
    }

    func firebaseDataFetch() {
        

        //let listId = privatehomeAttributes["listId"] as! String
        print(listId)
        
//        userfirebaseMeals.whereField("likedMeal", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//            arrayofTestingPallette = documents.compactMap { queryDocumentSnapshot -> mealClass? in
//                return try? queryDocumentSnapshot.data(as: mealClass.self)
//            }
//        }
        
        
        if isUserLoggedIn() {
            
            // userfirebaseProducts
            listfirebaseProducts.document("cpVa58Up92hrJ3i4o4tqvgvPOte2").collection("list").whereField("productList", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                arrayofProducts = documents.compactMap { queryDocumentSnapshot -> fireStoreDataClass? in
                    return try? queryDocumentSnapshot.data(as: fireStoreDataClass.self)
                }
                print("this is another test of the find \(arrayofProducts)")
                self.listTableView.reloadData()
         }
        
        } else {
            sendToLogIn()
        }
    }
    
    func getFilterOptions() {
        for i in arrayofProducts {
            if personalProductCategories.contains(i.category!) {
                //probably could be cleaner
                //Need a reset once no longer found
                print("already here")
            } else {
            personalProductCategories.append(i.category ?? "test")
            print("categories \(personalProductCategories)")
            }
        //filterViewController().filterCollectionView.reloadData()
        }
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
       // let panGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
        //self.listTableView.addGestureRecognizer(panGestureRecognizer)
    }
//    MARK: - Table View
    @objc func handelGooglesignUp() {
        tableViewSearchController.isActive = true
        tableViewSearchController.searchBar.becomeFirstResponder()
    }
    
    func tableViewIsEmpty() {
        view.addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.GoogleLoginImage.roundLoginImage.addTarget(self, action: #selector(handelGooglesignUp), for: .touchUpInside)
        
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
       
    //MARK: - Swipe actions
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->   UISwipeActionsConfiguration? {
        //If the product in not in the list and they are searching they can swipe to the left to add it to their list
        // Get current state from data source https://useyourloaf.com/blog/table-swipe-actions/
        let item = arrayofProducts[indexPath.row].id!
        let checkedAsInBasket = UIContextualAction(style: .normal, title: "Add") { (contextualAction, view, boolValue) in
            self.updateProductLocationValues(indexPath: item, pantry: true, list: false)
            self.addTimeStamp(id: item, action: engagements.pantry.rawValue)
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productsListCell = listTableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath)
        //MARK: - need custom for the time lead
        productsListCell.accessoryType = .disclosureIndicator
        
        if (tableViewSearchController.isActive) {
            let product = filteringproducts[indexPath.row]
            productsListCell.textLabel?.text = product.productName
            return productsListCell
            
        } else if (tableViewSearchController.isActive) {
            let product = filteringproducts[indexPath.row]
            productsListCell.textLabel?.text = product.productName
            print("filter tapped")
            return productsListCell
            
        } else {
            let product = arrayofProducts[indexPath.row]
            productsListCell.textLabel?.text = product.productName
            return productsListCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //https://developer.apple.com/documentation/uikit/view_controllers/displaying_searchable_content_by_using_a_search_controller
        //work backwards
        let selectedProduct: fireStoreDataClass!

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

//FIXME: remove header with filter
extension listViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCells = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! filterCellLayout
        filterCells.backgroundColor = UIColor.ademBlue
        filterCells.productName.text = productCategories[indexPath.row]
        return filterCells
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filterCells = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! filterCellLayout
        
        let item = productCategories[indexPath.item]
        
//        //let dairy = arrayofProducts.filter { ($0.category == item) }
//        if item == "All" {
//            firebaseDataFetch()
//            filterListCollectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.ademBlue
//        } else {
//
//            filterListCollectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.ademGreen
//            arrayofProducts = arrayofProducts.filter { ($0.category == item) }
//
//            self.listTableView.reloadData()
//        }
        print("Trying to filter for \(productCategories[indexPath.row])")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

extension listViewController: UISearchBarDelegate {
    
    func searchBarSetUp() {
    //        MARK: - Search bar
       
//        let currentScope = tableViewSearchController.searchBar.selectedScopeButtonIndex
        
//        if selectedScopeButtonIndex == 0 {
//            addResultsTableController = AddResultsTableController()
//            addResultsTableController.tableView.delegate = self
//            tableViewSearchController = UISearchController(searchResultsController: addResultsTableController)
//        } else {
//        addResultsTableController = AddResultsTableController()
//        addResultsTableController.tableView.delegate = self
//        tableViewSearchController = UISearchController(searchResultsController: addResultsTableController)
        
        //MARK: - SEARCH LOCAL LIST
        resultsTableController = ResultsTableController()
        resultsTableController.tableView.delegate = self
        tableViewSearchController = UISearchController(searchResultsController: resultsTableController)
//        }
        tableViewSearchController.delegate = self
        tableViewSearchController.searchResultsUpdater = self
        tableViewSearchController.obscuresBackgroundDuringPresentation = false
        tableViewSearchController.searchBar.delegate = self // Monitor when the search button is tapped.
        definesPresentationContext = true
        
        //instantiate the controller
        
        // Place the search bar in the navigation bar.
        navigationItem.searchController = tableViewSearchController
        
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

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        let keywords = searchBar.text
    //        let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "+")
    //           searchUrl = "https://api.spotify.com/v1/search?q=\(finalKeywords!)&type=track"
        self.view.endEditing(true)
        print(keywords)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
        
//    func searchBarIsEmpty() -> Bool {
//        // Returns true if the text is empty or nil
//        return tableViewSearchController.searchBar.text?.isEmpty ?? true
//    }
//
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //might break it
        print(selectedScope)
        
        switch selectedScope {
        case 1:
            resultsTableController = ResultsTableController()
            resultsTableController.tableView.delegate = self
            tableViewSearchController = UISearchController(searchResultsController: resultsTableController)
            updateSearchResults(for: tableViewSearchController)
        default:
            addResultsTableController = AddResultsTableController()
            addResultsTableController.tableView.delegate = self
            tableViewSearchController = UISearchController(searchResultsController: addResultsTableController)
            updateSearchResults(for: tableViewSearchController)
        }
    
        
        
    //        filterProductsSearchText(searchBar.text!, category: searchBar.scopeButtonTitles![selectedScope])
    }
        
    func filterProductsSearchText(for searchText: String) {
     
        filteringproducts = arrayofProducts.filter { fireStoreDataClass in
            return fireStoreDataClass.productName.lowercased().contains(searchText.lowercased())
        }
        listTableView.reloadData()
    }
            
//    func searchBarisFiltering() -> Bool {
//        return tableViewSearchController.isActive && !searchBarIsEmpty()
//    }
//
    
        
    var isSearchBarEmpty: Bool {
        return tableViewSearchController.searchBar.text?.isEmpty ?? true
    }
        
    var isFiltering: Bool {
        return tableViewSearchController.isActive && !isSearchBarEmpty
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

extension listViewController {
    //    MARK: - Api Reference
        func parseJSON(product: String) {
            //https://api.spoonacular.com/food/products/search?query=pizza&apiKey=5f40f799c85b4be089e48ca83e01d3c0
            var searchterm = tableViewSearchController.searchBar.text
            var semaphore = DispatchSemaphore (value: 0)

            var request = URLRequest(url: URL(string: "https://api.wegmans.io/products/search?query=\(searchterm ?? "something went wrong")&api-version=2018-10-18")!,timeoutInterval: Double.infinity)
            request.addValue("c455d00cb0f64e238a5282d75921f27e", forHTTPHeaderField: "Subscription-Key")

            request.httpMethod = "GET"

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                return
              }
              print(String(data: data, encoding: .utf8)!)
              semaphore.signal()
            }

            task.resume()
            semaphore.wait()
    }

        //MARK: - Api end
}

