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
import AVFoundation

//MARK: This needs to be a collection view
class PantryVC: UIViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate {
    
    //MARK: - Navigation Bar Buttons - Start
//    lazy var searching = UIBarButtonItem(image: UIImage(named: "cart_1")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    
    lazy var searching = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(handleSearch))
 
    
    lazy var added = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleBatchAdd))
    
    lazy var edit = UIBarButtonItem(image: UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAlert))
    
    lazy var trashed = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleBatchDelete))
    //MARK: - Navigation buttons - End
    
    
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
        self.navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        self.searchController.isActive = true
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.autocorrectionType = .default
        self.searchController.searchBar.enablesReturnKeyAutomatically = true
        self.searchController.obscuresBackgroundDuringPresentation = true
        self.searchController.searchBar.placeholder = "What Can I Add For You?"
        self.searchController.searchBar.tintColor = UIColor.white
        if #available(iOS 13.0, *) {
            self.searchController.searchBar.searchTextField.textColor = UIColor.white
        } else {
            // Fallback on earlier versions
        }
        setUpListView()
        setUpBarButtonItems()
        
       
    }
    
//    MARK: Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
           self.navigationController?.view.layoutIfNeeded()
           self.navigationController?.view.setNeedsLayout()
    }
    
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
       }
       
    
//    MARK: TableView Refresh
    var refreshControl = UIRefreshControl()
    @objc func refresh(sender: AnyObject) {
        //TODO: Code to refresh table view
    }
    
//    MARK: Setting up NAV bar buttons
    private func setUpBarButtonItems() {
        self.navigationItem.leftBarButtonItem = edit
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
        self.navigationItem.rightBarButtonItem = searching
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }




//    MARK: - Table View
    var pantryTableView: UITableView!
    //    MARK: CollectionView for Filtering
    let cfilter = "test"
//    TODO: Does this need to be a weak var?
    func setUpListView() {
    
        //Maybe delete https://theswiftdev.com/2018/06/26/uicollectionview-data-source-and-delegates-programmatically/


        pantryTableView = UITableView(frame: self.view.bounds, style: .grouped)
        if #available(iOS 13.0, *) {
            pantryTableView.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        
        pantryTableView.register(pantryTableViewCell.self, forCellReuseIdentifier: tableViewCell)
        pantryTableView.dataSource = self
        pantryTableView.delegate = self
        
        self.view.addSubview(pantryTableView)
        pantryTableView.translatesAutoresizingMaskIntoConstraints = false
     
        //View contstaints
        
//        TODO: Decide if I remove the other View
        NSLayoutConstraint.activate([
    
            pantryTableView.topAnchor.constraint(equalTo: view.topAnchor),
            pantryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pantryTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            pantryTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
    
    func printDate(string: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        print(string + formatter.string(from: date))
    }
    
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
//            self.listCollectionView.allowsMultipleSelection = false
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
        
        groceryProductsSelected = []
    }

    
    //MARK: Alert product Button
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
    
    
    //Search Button
    @objc func handleAlert() {
        
        let alert = removeDataCapture()
        alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //Edit Button
    @objc func handleEditButtonClicked() {
        print("Edit button was clicked")
    }
    
    
    
}


//MARK: Cell Setup For products
extension PantryVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Head and Footer for tableView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let he = tableViewHeader()
        switch section {
        case 0:
            he.title.text = "Breakfast"
        default:
            he.title.text = "Dairy"
        }
        return he
    }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
        

        
        //MARK: Table view cell properties - Start
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return 1
        }
    
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let productsListViewLayout = tableView.dequeueReusableCell(withIdentifier: self.tableViewCell, for: indexPath) as! pantryTableViewCell
            productsListViewLayout.cellDelegate = self
            let pt = productsListViewLayout.pantryCollectionView.cellForItem(at: indexPath) as? pantryCell
            pt?.addBackButton.addTarget(self, action: #selector(handleAlert), for: .touchDown)
            
            return productsListViewLayout
        }
     
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return CGFloat(200)
        }
        
        //MARK: Table view cell properties - End
    
    
    
}

extension PantryVC: CustomCollectionCellDelegate {
    
    
    func collectionView(collectioncell: UICollectionViewCell?, didTappedInTableview TableCell: UITableViewCell) {
        //https://slicode.com/collectionview-inside-tableview-cell-part-3/
        let productScreen = listProductVCLayout()
        
        productScreen.hidesBottomBarWhenPushed = true
        self.present(productScreen, animated: true, completion: nil)
    }
    
}


extension PantryVC: CellButtonTap {
    
    func buttonTapped(collectioncell: UICollectionViewCell?, button: UIButton?) {
        let alert = removeDataCapture()
        alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(alert, animated: true, completion: nil)
    }
    
}
