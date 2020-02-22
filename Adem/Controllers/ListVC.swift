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
//import FirebaseFirestore
import AVFoundation
import CoreData

class listViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate {
    
    
    //Cells Selected stuff
    enum Mode {
        case view
        case selected
    }
    
    var mMode: Mode = .view {
        didSet {
            switch mMode {
            case .view:
                //edit.title = "Edit"
                print("User is in view mode")
            case .selected:
                //edit.title = "Done"
                print("User is in edit mode")
            }
        }
    }

    
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
        
//        MARK: Search bar
        tableViewSearchController.searchResultsUpdater = self
        tableViewSearchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        //navigationItem.searchController = tableViewSearchController
        tableViewSearchController.searchBar.tintColor = UIColor.white
        tableViewSearchController.searchBar.delegate = self

        tableViewSearchController.searchBar.autocorrectionType = .default
        tableViewSearchController.searchBar.enablesReturnKeyAutomatically = true
        tableViewSearchController.searchBar.placeholder = "What Can I Add For You?"
        
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        //refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
       
//        MARK: Setting up NAV bar buttons
        //self.navigationItem.leftBarButtonItem = editButtonItem
        //self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
        self.navigationItem.rightBarButtonItem = searching
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
//        self.edgesForExtendedLayout = UIRectEdge.bottom
        toolBarSetUp()
        countingCollections()
        
        setUpFilterView()
    }
    
    //MARK: Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpListView()
           
        let switchDefaults = UserDefaults.standard.bool(forKey: "SwitchKey")
        
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
    }
    
    func countingCollections() {

        let collection = db.collection("Users")
        print("starting observing")
        collection.getDocuments() { (allDocs, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in allDocs!.documents {
                
                print("hello \(document.documentID) => \(document.data())")
            }
            
            let sized = allDocs!.count
            //let bla = "fuck"
            print("kinda \(sized)")
            
        }
        //collection.observe(.value, with: { (snapshot: DataSnapshot!) in })
    }
}

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
       
    }
    
//    MARK: Spoon Api Reference
    var tableArray = [String] ()
    func parseJSON() {
        
        //https://api.spoonacular.com/food/products/search?query=pizza&apiKey=5f40f799c85b4be089e48ca83e01d3c0
        var searchterm = "pizza"
        let apiKey = "5f40f799c85b4be089e48ca83e01d3c0"
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
                  print("Not containing JSON")
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
    
//    MARK: Refresh
    var refreshControl = UIRefreshControl()
    @objc func refresh(sender: AnyObject) {
        //TODO: Code to refresh table view
    }

//    MARK: Table View
    var listTableView: UITableView!
//    MARK: CollectionView for Filtering
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

            collecAndTableFeatures()
            
            listTableView.translatesAutoresizingMaskIntoConstraints = false

            listTableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCell)

            createLayout()
        
            
        }
    }
    
    private func collecAndTableFeatures() {
//          MARK: DataSource and Delegate

        listTableView.dataSource = self
        listTableView.delegate = self
        
//          MARK: Background Color
        listTableView.backgroundColor = UIColor.white

                    
//          MARK: User interaction

        listTableView.allowsMultipleSelection = true
        
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
    
   
    var listProducts: [groceryItemCellContent] =  []
    //MARK: Table view cell properties - End
    
    //MARK: Search bar stuff - start
    var filteringproducts = [groceryProductsDatabase]()
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return tableViewSearchController.searchBar.text?.isEmpty ?? true
    }
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //self.mySearchBar.endEditing(true)
    }
    
    func filterProductsSearchText(for searchText: String) {
        filteringproducts = allproductsInList.filter { groceryProductsDatabase in
          return
            groceryProductsDatabase.groceryProductName.lowercased().contains(searchText.lowercased())
        }
        
        listTableView.reloadData()
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
        
        print(searchText)
        
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
    var selectedProductsIndexPath: [IndexPath: Bool] = [:]
    var groceryProductsSelected: [IndexPath] = []
    
   
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
        
        print("Camera button working")
    }
    
    //product Button
    @objc func handleProduct() {
        
        let productScreen = pantryProductVCLayout()
        productScreen.hidesBottomBarWhenPushed = true
        productScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(productScreen, animated: true, completion: nil)
        
        print("Settings Tab is active")
    }
    
    //product Button
    @objc func handleProductOptiontwo() {
        
        let productScreen = listProductVCLayout()
        productScreen.hidesBottomBarWhenPushed = true
        self.present(productScreen, animated: true, completion: nil)
        
        print("Settings Tab is active")
    }
    
    //product Button
    @objc func handleListProduct() {
        
        let productScreen = listProductVCLayout()
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
    var filterListCollectionView: UICollectionView!
    let filters = ["All","Dairy", "Meat", "Veggies","Fruit","Frozen"]
}


//MARK: tableView extension
extension listViewController: UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: Table view cell properties - Start
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

        for productsInList in productsGlobal! {
            if productsInList.List == true {
                listProducts.append(productsInList)
            }
        }
        
        if tableViewSearchController.isActive && tableViewSearchController.searchBar.text != "" {
            return filteringproducts.count
        }
        //return listProducts.count
        return fuckthis.count
    }
    
    //FIXME: Delete Cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == UITableViewCell.EditingStyle.delete {
               fuckthis.remove(at: indexPath.row)
            listTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
           }
       }
       
       //MARK: Swipe actions
       func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->   UISwipeActionsConfiguration? {
           //If the product in not in the list and they are searching they can swipe to the left to add it to their list
         // Get current state from data source https://useyourloaf.com/blog/table-swipe-actions/
           let checkedAsInBasket = UIContextualAction(style: .normal, title: "Add") { (contextualAction, view, boolValue) in
               boolValue(true) // pass true if you want the handler to allow the action
               print("User has added the product to their basket in the store")
           }
           
           let addToPantry = UIContextualAction(style: .normal, title: "Pantry") { (contextualAction, view, boolValue) in
               boolValue(true) // pass true if you want the handler to allow the action
               print("User is adding the product back to their pantry")
           }
           addToPantry.backgroundColor = UIColor.ademGreen
           checkedAsInBasket.backgroundColor = UIColor.ademGreen
           
           let swipeActions = UISwipeActionsConfiguration(actions: [checkedAsInBasket])

           return swipeActions
       }
       
       
       func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           
           let deleteItemFromListAndPanty = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, boolValue) in
               boolValue(true) // pass true if you want the handler to allow the action
           }
           deleteItemFromListAndPanty.backgroundColor = UIColor.ademRed
           let swipeActions = UISwipeActionsConfiguration(actions: [deleteItemFromListAndPanty])
           return swipeActions
       }

    func numberOfSections(in tableView: UITableView) -> Int {
        let swippedToInCart = false
        
        if swippedToInCart == true {
            return 2
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Row = indexPath.row
        
        //let productsListViewLayout = tableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath) as! listTableViewCell
        let productsListViewLayout = tableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath)
        
        
        //FIXME: Placeholder table view cells
        let lProducts: groceryProductsDatabase
        let lProd: groceryItemCellContents
        
        if tableViewSearchController.isActive && tableViewSearchController.searchBar.text != "" {
            lProducts = filteringproducts[Row]
        } else  {
            lProducts = allproductsInList[Row]
        }
        
        productsListViewLayout.textLabel?.text = fuckthis[Row]

        //Default tableview cell attributes
        productsListViewLayout.imageView?.image = UIImage(named: "egg")
        productsListViewLayout.accessoryType = .disclosureIndicator
        
        return productsListViewLayout
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       

        switch indexPath.row {
        case 0:
            handleProductOptiontwo()
        case 1:
            handleListProduct()
        case 2:
            handleAlert()
        default:
            handleProductOptiontwo()
        }
        
        listTableView.deselectRow(at: indexPath, animated: false)
        
       }
       
       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           
           return "This needs to be filter options"
       }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

           return 60
       }
    
    func setUpFilterView() {
        
        let layouts = UICollectionViewFlowLayout()
        layouts.itemSize = CGSize(width: 75, height: self.view.frame.height)
        filterListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layouts)
        filterListCollectionView.register(filterCellLayout.self, forCellWithReuseIdentifier: "test")

        layouts.scrollDirection = .horizontal
        filterListCollectionView.showsHorizontalScrollIndicator = false
        
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
        filterListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

        filterListCollectionView.topAnchor.constraint(equalTo: headerView.topAnchor),
        filterListCollectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
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
        
        return filters.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("needs to be the name of the cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let filterCells = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! filterCellLayout
        filterCells.backgroundColor = UIColor.ademBlue
        filterCells.layer.cornerRadius = 5
        
        
        filterCells.productName.text = filters[indexPath.item]
        
        
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

