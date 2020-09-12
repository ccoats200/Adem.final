//
//  PantryVC.swift
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

//MARK: This needs to be a collection view
class PantryVC: UIViewController, UISearchControllerDelegate, UIGestureRecognizerDelegate {
   
    
    
    //MARK: - Navigation Bar Buttons - Start
//    lazy var searching = UIBarButtonItem(image: UIImage(named: "cart_1")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    
    lazy var searching = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(handleSearch))
    
    lazy var filter = UIBarButtonItem(image: UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAlert))
    
    lazy var done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleEditButtonClicked))
    
    //MARK: - Navigation buttons - End
    
    
    let mostRecent = "most recent"
    let productRFIDNumber = "3860407808"
 
    //MARK: Cell re-use ID
    let tableViewCell = "test"
    let cellID = "product"
    let headerID = "collectionViewHeader"
    var pantryCollectionView: UICollectionView!
    let mealsCellID = "meals"
    let mealsCCellID = "Cmeals"
    
    //Populate List
    var listProducts: [groceryItemCellContent] =  []
    
    //TODO: what do these do?
    //var products: [groceryProductsStruct] = groceryProducts.fetchGroceryProductImages()
    var selectedGroceryItems = [groceryItemCellContent]()
    var selectedCells = [UICollectionViewCell]()
    var groceriesSelected = [String]()
    
    var searchController: UISearchController!
    var pantryResultsTableController: PantryResultsTableController!
    var addResultsTableController: AddResultsTableController!
    var filteringPantry = arrayofPantry
    var filterPantry: [fireStoreDataClass] = []
    var pantryFilter = [fireStoreDataClass]()
    var productFilter = [fireStoreDataClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //MARK: NavigationBar setup
        navigationItem.title = "Pantry"
        
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
        
        
        
        setUpSearch()
        setUpListViews()
        setUpBarButtonItems()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
        longPress.delegate = self
        longPress.minimumPressDuration = 0.50
        self.pantryCollectionView?.addGestureRecognizer(longPress)
        
        firebaseDataFetch()
    }
    
   
    //MARK: Gestures
    @objc func panGestureRecognizerAction(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state != .began {
            
            return
        }
            //https://www.ioscreator.com/tutorials/delete-item-collection-view-controller-ios-tutorial
        setEditing(true, animated: true)

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
        self.isEditing = false
    }
    
//    MARK: Setting up NAV bar buttons
    private func setUpBarButtonItems() {
        self.navigationItem.leftBarButtonItem = filter
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
        self.navigationItem.rightBarButtonItem = searching
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
    }


//    MARK: - Table View
    
    
    func setUpListViews() {
        
        let mealsCollectionViewlayouts = UICollectionViewFlowLayout()
        mealsCollectionViewlayouts.scrollDirection = .vertical
        
        self.pantryCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: mealsCollectionViewlayouts)

          
        pantryCollectionView.showsHorizontalScrollIndicator = false
        self.pantryCollectionView.dataSource = self
        self.pantryCollectionView.delegate = self
        self.pantryCollectionView.register(pantryCell.self, forCellWithReuseIdentifier: mealsCCellID)
        if #available(iOS 13.0, *) {
            self.pantryCollectionView.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        self.pantryCollectionView.isUserInteractionEnabled = true
        self.pantryCollectionView.isScrollEnabled = true
        
        //CollectionView spacing
        pantryCollectionView.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        
        self.pantryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //adding subviews to the view controller
        self.view.addSubview(pantryCollectionView)
            
            
        NSLayoutConstraint.activate([
            pantryCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            pantryCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            pantryCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            pantryCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            ])
    }

    
 
  
    
    // MARK: - Put in edit mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        self.navigationItem.rightBarButtonItem?.isEnabled = !isEditing
        if let indexPaths = pantryCollectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
            if let cell = pantryCollectionView?.cellForItem(at: indexPath) as? pantryCell {
                cell.isEditing = editing
                }
            }
        }
        
        if self.isEditing {
            self.navigationItem.leftBarButtonItem = done
        } else {
            self.navigationItem.leftBarButtonItem = filter
        }
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
        
//        let alert = removeDataCapture()
        let alert = filterViewController()
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //Edit Button
    @objc func handleEditButtonClicked() {
        setEditing(false, animated: true)
//        self.isEditing = false
    }

    func firebaseDataFetch() {
        userfirebaseProducts.whereField("productPantry", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
           guard let documents = querySnapshot?.documents else {
             print("No documents")
             return
           }
            arrayofPantry = documents.compactMap { queryDocumentSnapshot -> fireStoreDataClass? in
                 return try? queryDocumentSnapshot.data(as: fireStoreDataClass.self)
            }
            self.pantryCollectionView.reloadData()
         }
    }
}

extension PantryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

       
        return arrayofPantry.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pantryItemsCell = collectionView.dequeueReusableCell(withReuseIdentifier: mealsCCellID, for: indexPath) as! pantryCell
    
        let pantryList = arrayofPantry[indexPath.item]
        
        pantryItemsCell.pantryItemName.text = pantryList.productName
        pantryItemsCell.quantity.text = "Q: \(pantryList.productQuantity)"
        pantryItemsCell.pantryItemImageView.image = UIImage(named: pantryList.productImage)
        //Use this for the Date
        pantryItemsCell.expiryDate.text = " \(pantryList.productExpir.interval(ofComponent: .day, fromDate: Date())) Days"
        
        if pantryList.productExpir.interval(ofComponent: .day, fromDate: Date()) <= 0 {
            pantryItemsCell.backgroundColor = UIColor.ademRed
            pantryItemsCell.pantryItemName.textColor = UIColor.white
            pantryItemsCell.quantity.textColor = UIColor.white
            pantryItemsCell.expiryDate.textColor = UIColor.white
        }

        pantryItemsCell.layer.cornerRadius = 5
        pantryItemsCell.delegate = self
        return pantryItemsCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct: fireStoreDataClass!
        selectedProduct = product(forIndexPath: indexPath)
        let detailViewController = listProductVCLayout.detailViewControllerForProduct(selectedProduct)

        self.present(detailViewController, animated: true, completion: nil)
        //let cell = pantryCollectionView.cellForItem(at: indexPath)
        
        addTimeStamp(id: arrayofPantry[indexPath.row].id!, action: engagements.engaged.rawValue)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //MARK: Changes the size of the image in pantry
        return CGSize(width: 112.5, height: 125)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
//MARK: For product selection
extension PantryVC {
    
    func product(forIndexPath: IndexPath) -> fireStoreDataClass {
        var product: fireStoreDataClass!
        product = arrayofPantry[forIndexPath.item]
        return product
    }
    
}
//Add button
extension PantryVC: pantryDelegate {
    
    func delete(cell: pantryCell) {
        if let indexPath = pantryCollectionView?.indexPath(for: cell) {
            //1. Change value in data source
            let item = arrayofPantry[indexPath.row].id
            
            let actionTest = [1: "100%",2: "75%",3: "50%",4 :"25%",5: "0%"]
            let sorted = actionTest.sorted {$0.key < $1.key}
            let actionSheetController: UIAlertController = UIAlertController(title: "How Much Was Left?", message: "This helps us learn how to help you!", preferredStyle: .actionSheet)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Not Done Yet", style: .cancel) { action -> Void in }
            for actions in sorted {
                let quantity: UIAlertAction = UIAlertAction(title: String(actions.value), style: .default) { action -> Void in
                    self.addWasteAmount(id: item!, amount: actions.value)
                    self.updateProductLocationValues(indexPath: item!, pantry: false, list: true)
                    self.addTimeStamp(id: item!, action: engagements.added.rawValue)
                }
                actionSheetController.addAction(quantity)
            }
            actionSheetController.addAction(cancelAction)
            self.present(actionSheetController, animated: true, completion: nil)
        }
    }
}


extension PantryVC: UISearchBarDelegate {
    
    func setUpSearch() {
        //MARK: Search bar
        pantryResultsTableController = PantryResultsTableController()
        //pantryResultsTableController.tableView.delegate = self
        //pantryResultsTableController.collectionView.delegate = self
        searchController = UISearchController(searchResultsController: pantryResultsTableController)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self // Monitor when the search button is tapped.
        definesPresentationContext = true
                
                //instantiate the controller
                
                // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController
                
            //Design elements
        searchController.searchBar.placeholder = "Looking for something?"
        searchController.searchBar.autocorrectionType = .default
        searchController.searchBar.enablesReturnKeyAutomatically = true
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.tintColor = UIColor.white
                
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.textColor = UIColor.white
        } else {
            // Fallback on earlier versions
        }
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
              
        func filterProductsSearchText(for searchText: String) {
         
            filteringPantry = arrayofPantry.filter { fireStoreDataClass in
                return fireStoreDataClass.productName.lowercased().contains(searchText.lowercased())
            }
            pantryCollectionView.reloadData()
        }
            
        var isSearchBarEmpty: Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        }
            
        var isFiltering: Bool {
            return searchController.isActive && !isSearchBarEmpty
        }
}
