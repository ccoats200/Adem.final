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

class listViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
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
    
    //MARK: FireBase Populate List
    var products: [food] = [food]()
    
    //Search Controller implementation
    let tableViewSearchController = UISearchController(searchResultsController: nil)
    
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
            
            //MARK: Opt out of dark mode
            overrideUserInterfaceStyle = .light
        }
        
        //MARK: Search bar
        tableViewSearchController.searchResultsUpdater = self
        tableViewSearchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = tableViewSearchController
        tableViewSearchController.searchBar.tintColor = UIColor.white
        tableViewSearchController.searchBar.delegate = self
        //tableViewSearchController.searchBar.showsBookmarkButton = true
        //tableViewSearchController.searchBar.setImage(UIImage(named: "Vegan"), for: .bookmark, state: .normal)


        tableViewSearchController.searchBar.autocorrectionType = .default
        tableViewSearchController.searchBar.enablesReturnKeyAutomatically = true
        tableViewSearchController.searchBar.placeholder = "What Can I Add For You?"
        
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        //refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
       
        //MARK: Setting up NAV bar buttons
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
        self.navigationItem.rightBarButtonItem = searching
        
        toolBarSetUp()
        countingCollections()
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
        //self.searchController.isActive = false
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
       
    }
       
    
    
    //MARK: Spoon Api Reference
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
    
    
    
    
    //MARK: Refresh
    var refreshControl = UIRefreshControl()
    @objc func refresh(sender: AnyObject) {
        //TODO: Code to refresh table view
    }
    
//    func listScreenDesign() {
//        setUpListView()
//        
//        let switchDefaults = UserDefaults.standard.bool(forKey: "SwitchKey")
//     
//       }
//    

    //MARK: Table View
    
    //TODO: Does this need to be a weak var?
    var listTableView: UITableView!
    func setUpListView() {
        
        //SetUp views from own class
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
    
        listTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        listTableView.backgroundColor = UIColor.white
        
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCell)
        //listTableView.register(listTableViewCell.self, forCellReuseIdentifier: tableViewCell)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.allowsMultipleSelection = true
        
        self.view.addSubview(listTableView)
        
        //MARK: tableView constraints
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
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
        checkedAsInBasket.backgroundColor = UIColor.ademBlue
        
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

    var listProducts: [groceryItemCellContent] =  []
    
    //MARK: Table view cell properties - Start
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        /*
        for i in productsGlobal! {
            if i.List == true {
                listProducts.append(i)
            }
            //print("for loop is working and there are \(listProducts.count as Any) products")
        }
        print("\(productsGlobal?.count)")
        */
        
        if tableViewSearchController.isActive && tableViewSearchController.searchBar.text != "" {
            return filteringproducts.count
        }
        
        return allproductsInList.count
        
        //FIXME: Placeholder table view cells
        //return settingsOptions.count
        
        //FIXME: Products list
        //return listProducts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let productsListViewLayout = tableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath) as! listTableViewCell
        let productsListViewLayout = tableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath)
        let Row = indexPath.row
        
        
        //TODO: Custom Selected color
        /*
        let selectedView = UIView()
        selectedView.backgroundColor = .ademGreen
        productsListViewLayout.selectedBackgroundView = selectedView
 */
        
        //FIXME: Placeholder table view cells
        let lProducts: groceryProductsDatabase
        if tableViewSearchController.isActive && tableViewSearchController.searchBar.text != "" {
            lProducts = filteringproducts[Row]
        } else  {
            lProducts = allproductsInList[Row]
        }
        
        productsListViewLayout.textLabel?.text = lProducts.groceryProductName
        
        //FIXME: Products list
        //productsListViewLayout.textLabel!.text = listProducts[indexPath.row]
        
        //Default tableview cell attributes
        productsListViewLayout.imageView?.image = UIImage(named: "egg")
        productsListViewLayout.accessoryType = .disclosureIndicator
        
        return productsListViewLayout
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            handleProductOptiontwo()
        } else {
            handleListProduct()
    }

        listTableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "What are you cooking today"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
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
    
    //MARK: Table view cell properties - End
    
    //MARK: Search bar stuff - start
    
    //TODO: what do these do?
    //var selectedGroceryItems = [groceryItemCellContent]()
    //var groceriesSelected = [String]()
    
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
            self.navigationItem.rightBarButtonItems = [added, trashed]
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
    //var selectedGroceryProducts = [groceryItemCellContent]()
    
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

}
