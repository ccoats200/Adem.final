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

class listViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate {
    
    
    //Cells Selected stuff
//    enum Mode {
//        case view
//        case selected
//    }
//
//    var mMode: Mode = .view {
//        didSet {
//            switch mMode {
//            case .view:
//                //edit.title = "Edit"
//                print("User is in view mode")
//            case .selected:
//                //edit.title = "Done"
//                print("User is in edit mode")
//            }
//        }
//    }

    
//    MARK: Navigation Bar Buttons - Start
    lazy var searching = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(handleSearch))
    
//    lazy var added = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleBatchAdd))
    
//    lazy var edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditButtonClicked))
    
//    lazy var trashed = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleBatchDelete))
    //MARK: Navigation buttons - End
    
    
    let mostRecent = "most recent"
    let productRFIDNumber = "3860407808"
 
//    MARK: Cell re-use ID
    let tableViewCell = "test"
    let cellID = "product"
    let headerID = "collectionViewHeader"
    
//    MARK: FireBase Populate List
    var products: [food] = [food]()
    
//    Search Controller implementation
    let tableViewSearchController = UISearchController(searchResultsController: nil)
    
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
            
//            MARK: Opt out of dark mode
            overrideUserInterfaceStyle = .light
        }
        setupSearch()
        setUpListView()
        
        
        listTableView.dataSource = self
        listTableView.delegate = self
        
        listTableView.backgroundColor = UIColor.white
        listTableView.allowsMultipleSelection = true
        
       
//        MARK: Setting up NAV bar buttons
        //self.navigationItem.leftBarButtonItem = editButtonItem
        //self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
        self.navigationItem.rightBarButtonItem = searching
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        
        toolBarSetUp()
        setUpFilterView()

        
        //Firebase working below
        firebaseDataFetch()
        getFilters()
    }
    
    //MARK: Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpLayouts()
//        structform()
        
        
        let switchDefaults = UserDefaults.standard.bool(forKey: "SwitchKey")
        self.listTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpLayouts()
    }
    
    func setUpLayouts() {
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
    }
    
    private func setupSearch() {
        //        MARK: Search bar
        self.tableViewSearchController.searchBar.delegate = self
        
        self.definesPresentationContext = true
        self.navigationItem.searchController = tableViewSearchController
        self.tableViewSearchController.isActive = true
        tableViewSearchController.searchResultsUpdater = self
        tableViewSearchController.searchBar.autocorrectionType = .default
        tableViewSearchController.searchBar.enablesReturnKeyAutomatically = true
        tableViewSearchController.obscuresBackgroundDuringPresentation = true
        
        tableViewSearchController.hidesNavigationBarDuringPresentation = false
        tableViewSearchController.searchBar.tintColor = UIColor.white
        if #available(iOS 13.0, *) {
            tableViewSearchController.searchBar.searchTextField.textColor = UIColor.white
        } else {
            // Fallback on earlier versions
        }
        tableViewSearchController.searchBar.placeholder = "What Can I Add For You?"
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
    }
    
//    MARK: - Api Reference
    var tableArray = [String] ()
    func parseJSON() {
        //https://api.spoonacular.com/food/products/search?query=pizza&apiKey=5f40f799c85b4be089e48ca83e01d3c0
        var searchterm = tableViewSearchController.searchBar.text
        print(searchterm)
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

//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let keywords = searchBar.text
//        let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "+")
//
//           searchUrl = "https://api.spotify.com/v1/search?q=\(finalKeywords!)&type=track"
//           callAlamo(url: searchUrl)
//           self.view.endEditing(true)
//    }

//    MARK: Table View
    var listTableView: UITableView!
    let cfilter = "test"
    func setUpListView() {
        
        //TODO: If empty
        switch productsGlobal?.isEmpty {
        case true:
            
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
            
        default:
            
            listTableView = UITableView(frame: self.view.bounds)
            
//          MARK: Subviews
            self.view.addSubview(listTableView)
            listTableView.translatesAutoresizingMaskIntoConstraints = false
            listTableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCell)
            createLayout()
  
        }
    }
    
    private func createLayout() {
//            MARK: Constraints
        NSLayoutConstraint.activate([

            listTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
    //MARK: - Table view cell properties - End
    
    //MARK: - Search bar start
    var filteringproducts = [groceryProductsDatabase]()
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return tableViewSearchController.searchBar.text?.isEmpty ?? true
    }
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //self.mySearchBar.endEditing(true)
    }
    
    
    func filterProductsSearchText(for searchText: String) {
//        filteringproducts = allproductsInList.filter { groceryProductsDatabase in
//          return
//            groceryProductsDatabase.groceryProductName.lowercased().contains(searchText.lowercased())
//        }
        
//        listTableView.reloadData()
    }
    
    func searchBarisFiltering() -> Bool {
        return tableViewSearchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = tableViewSearchController.searchBar.text else { return }
        filterProductsSearchText(for: searchController.searchBar.text ?? "")
        
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        //let searchItems = strippedString.components(separatedBy: " ") as [String]
        
    }
    //MARK: Search bar stuff - End

    
    // MARK: - Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if self.isEditing {
            listTableView.isEditing = true
            self.navigationItem.rightBarButtonItem = nil
            self.tabBarController?.tabBar.isHidden = true
            //self.navigationItem.rightBarButtonItems = [added, trashed]
            self.navigationController?.isToolbarHidden = false
        } else {
            self.navigationController?.isToolbarHidden = true
            self.navigationItem.rightBarButtonItems = [searching]
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
//    @objc func handleEditButtonClicked() {
//        if mMode == .view {
//            setEditing(true, animated: false)
//        } else {
//            setEditing(false, animated: false)
//        }
//        //setEditing(true, animated: false)
//        mMode = mMode == .view ? .selected : .view
//        print("Edit button was clicked")
//    }
    
   
    //product Button
    @objc func handleSearch() {

        if #available(iOS 13.0, *) {
            let productScreen = camVC()
            productScreen.hidesBottomBarWhenPushed = true
            productScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(productScreen, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        
    }
    /*
    //might Delete
    @objc func handleProduct() {
        
        let productScreen = pantryProductVCLayout()
        productScreen.hidesBottomBarWhenPushed = true
        productScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(productScreen, animated: true, completion: nil)
        
    }
    
    */
    //product Button
    @objc func handleListProduct() {
        
        let productScreen = listProductVCLayout()
        productScreen.hidesBottomBarWhenPushed = true
        productScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(productScreen, animated: true, completion: nil)
        
    }
    //Button Functions - End
    
    //Search Button
    @objc func handleAlert() {
        
        let alert = addedItemAlert()
        alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(alert, animated: true, completion: nil)
        
    }
    //MARK: - Filter
    var filterListCollectionView: UICollectionView!
    
    //MARK: - need a collection of types of food
  
    //MARK: - Firebase lists should the app delegate

    func firebaseDataFetch() {
        userfirebaseProducts.whereField("productList", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
           guard let documents = querySnapshot?.documents else {
             print("No documents")
             return
           }
            
            arrayofProducts = documents.compactMap { queryDocumentSnapshot -> fireStoreDataStruct? in
                print(arrayofProducts)
                return try? queryDocumentSnapshot.data(as: fireStoreDataStruct.self)
                
            
           }
            
            
            print("this is the new function maybe \(arrayofProducts)")
            self.listTableView.reloadData()
            
         }
        
    }
    
    func getFilters() {

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
    
    func addTimeStamp(id: String, action: String) {
        //https://firebase.google.com/docs/firestore/solutions/aggregation


            userfirebaseProducts.document(id).collection("listDate").addDocument(data: [
                "date" : Firebase.Timestamp(),
                "action" : action,
                //every 7 days push to collection
            ])
        let add = "a"
        let remove = "r"
        let engaged = "e"
        //us .updateData for adding a new listDate, pantryDate, etc.

    }
    

    //filter
    var filter = [fireStoreDataStruct]()
    var productFilter = [fireStoreDataStruct]()
//MARK: - class end
}


//MARK: - tableView extension
extension listViewController: UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    //FIXME: Delete Cell
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
            self.addTimeStamp(id: item, action: "a")
            
//
//            if let index = arrayofIds.index(of: arrayofIds[indexPath.row].productName) {
//                arrayofIds.remove(at: index)
//            }
//            arrayofIds.remove(at: <#T##Int#>)
            
            
            boolValue(true) // pass true if you want the handler to allow the action

            print("User has added the product to their basket in the store")
           }
           checkedAsInBasket.backgroundColor = UIColor.ademGreen
//           self.listTableView.reloadData()
        let swipeActions = UISwipeActionsConfiguration(actions: [checkedAsInBasket])
        return swipeActions
       }
    
    func updateProductLocationValues(indexPath: String, pantry: Bool, list: Bool){
         
        // Or more likely change something related to this cell specifically.
//        let cell = listTableView.cellForRow(at: indexPath)
//        for i in arrayofProducts {//where i.productName == cell?.textLabel?.text {
            
            userfirebaseProducts.document("\(indexPath)").updateData([
                "productPantry": pantry,
                "productList": list
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            //TimeStamp
            
//        }
        
        self.listTableView.reloadData()
    }
    
       
       func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let item = arrayofProducts[indexPath.row].id!
           let deleteItemFromListAndPanty = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
            
            self.updateProductLocationValues(indexPath: item, pantry: false, list: false)
            self.addTimeStamp(id: item, action: "r")
               
            boolValue(true) // pass true if you want the handler to allow the action
           }
        
           deleteItemFromListAndPanty.backgroundColor = UIColor.ademRed
           let swipeActions = UISwipeActionsConfiguration(actions: [deleteItemFromListAndPanty])
           return swipeActions
       }
    
    
    
    //MARK: Table view cell properties - Start
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
            return arrayofProducts.count
        //        works for population
//        return productsGlobal!.count

        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productsListCell = listTableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath)
        productsListCell.accessoryType = .disclosureIndicator
        let product = arrayofProducts[indexPath.row]
//        works for population on didset
//        let product = productsGlobal![indexPath.row]
        productsListCell.textLabel?.text = product.productName
        return productsListCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        print("this is the index path row \(indexPath.row)")
        print("this is the index path row \(listTableView.indexPathForSelectedRow?.row)")
        //FireStore data collection
        addTimeStamp(id: arrayofProducts[indexPath.row].id!, action: "e")
//        addCategory(id: arrayofIds[indexPath.row].id)

        
        let cell = listProductVCLayout()
        let product = arrayofProducts[indexPath.row]
//        cell.productVariableElements = product
        
//        works for population
//        let product = productsGlobal![indexPath.row]
//        cell.elements = product
        
        let storageRef = Storage.storage().reference(withPath: "groceryProducts/almondExtract.jpeg")
            storageRef.getData(maxSize: (4 * 1024 * 1024)) { [weak self] (data, error ) in
                if let error = error {
                    print("got error \(error.localizedDescription)")
                    return
                }
                if let image = data {
                    cell.productImageSection.productImage.image = UIImage(data: image)
                }
            }
        
        print("show all \(arrayofProducts)")

        self.present(cell, animated: true, completion: nil)
        listTableView.deselectRow(at: indexPath, animated: false)
       }
    
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 60
        
       }
    
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
           
           let footerView = UIView()
           footerView.backgroundColor = UIColor.white
       
           return footerView
       }
       
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           let cellHeight = 60
           
           return CGFloat(cellHeight)
       }
       
       //Multiple selection
       func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
           //https://developer.apple.com/documentation/uikit/uitableviewdelegate/selecting_multiple_items_with_a_two-finger_pan_gesture
           return true
       }
       
       func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
           setEditing(true, animated: true)
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

