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


class PantryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate {
 
    
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
                collectionView.allowsSelection = false
                print("User is in view mode")
            case .selected:
                edit.title = "Done"
                collectionView.allowsSelection = true
                print("User is in edit mode")
            }
        }
    }
    
    //Navigation buttons - Start
    lazy var searching = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    
    lazy var added = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleBatchAdd))
    
    lazy var edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEditButtonClicked))
    
    lazy var trashed = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleBatchDelete))
    //Navigation buttons - End

    var products: [groceryItemCellContent] = []
    
    //reuse ID's
    let cellID = "product"
    let headerID = "collectionViewHeader"
    
    //Additional Views
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: NavigationBar setup
        navigationItem.title = "Pantry"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.ademBlue]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.searchController = searchController

        //Search
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        
        
        self.searchController.searchBar.placeholder = "Search for Items"
        
        //This moves the Cells to the correct offsets, Stylistic choice
        //pantryCollectionView.contentInset = UIEdgeInsets.init(top: 1, left: 1, bottom: 1, right: 1)
        //pantryCollectionView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 50, right: 0)
    
        
        //Initializing the Collection view and add/delete view
        setUpDifferentViews()
        setUpBarButtonItems()
    }
   
    //Setting up views
    var productUpdateLocationButtonView = addOrDeleteProduct()
    weak var collectionView: UICollectionView!
    func setUpDifferentViews() {
        //SetUp views from own class
        let ss: CGRect = UIScreen.main.bounds
        productUpdateLocationButtonView = addOrDeleteProduct(frame: CGRect(x: 0, y: 0, width: ss.width, height: 75))
       
        let layouts: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let pantryCollectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layouts)
        
        //adding subviews to the view controller
        self.view.addSubview(pantryCollectionView)
        self.view.addSubview(productUpdateLocationButtonView)
        
        pantryCollectionView.dataSource = self
        pantryCollectionView.delegate = self
        pantryCollectionView.register(pantryCellLayout.self, forCellWithReuseIdentifier: cellID)
        pantryCollectionView.backgroundColor = UIColor.white
        pantryCollectionView.isUserInteractionEnabled = true
        pantryCollectionView.isScrollEnabled = true
        pantryCollectionView.bounces = true
        pantryCollectionView.alwaysBounceVertical = true
        
        
        //Maybe delete https://theswiftdev.com/2018/06/26/uicollectionview-data-source-and-delegates-programmatically/
        pantryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productUpdateLocationButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        pantryCollectionView.contentInset = UIEdgeInsets.init(top: 1, left: 1, bottom: 1, right: 1)
        
        let Columns: CGFloat = 3.14
        let insetDimension: CGFloat = 2.0
        let cellHeight: CGFloat = 125.0
        let cellWidth = (pantryCollectionView.frame.width/Columns) - insetDimension
        layouts.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        //View contstaints
        NSLayoutConstraint.activate([
            pantryCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            pantryCollectionView.bottomAnchor.constraint(equalTo: productUpdateLocationButtonView.topAnchor),
            pantryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pantryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productUpdateLocationButtonView.heightAnchor.constraint(equalToConstant: 75),
            productUpdateLocationButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            productUpdateLocationButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productUpdateLocationButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        self.collectionView = pantryCollectionView
        
        //User interations
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(addLongGestureRecognizer))
        lpgr.minimumPressDuration = 0.35
        self.collectionView?.addGestureRecognizer(lpgr)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        //var searchString = searchController.searchBar.text
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
 
        searchController.searchBar.resignFirstResponder()
    }
    
    
    //Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.searchController.isActive = true
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.searchController.isActive = false
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
    }

    
    
    // MARK: - Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if self.isEditing {
            self.navigationItem.rightBarButtonItem = nil
            self.collectionView.allowsMultipleSelection = true
            self.tabBarController?.tabBar.isHidden = true
            self.navigationItem.rightBarButtonItems = [added, trashed]
            
        } else {
           
            self.navigationItem.rightBarButtonItems = [searching]
            self.tabBarController?.tabBar.isHidden = false
            self.collectionView.allowsMultipleSelection = false
            
        }
        
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? pantryCellLayout {
                    cell.isEditing = editing
                }
            }
        }
    }
    
    
    
    @objc func addLongGestureRecognizer(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        
        if gestureRecognizer.state != .began { return }
        let p = gestureRecognizer.location(in: self.collectionView)
        if let indexPath = self.collectionView.indexPathForItem(at: p) {
            //let cell = self.collectionView.cellForItem(at: indexPath)
            
            navigationController?.isEditing = true
            
        } else {
            print("can't find")
        }
    }
    
    func setup() {
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(down))
        swipeDown.direction = .down
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(up))
        swipeUp.direction = .up
        
        
        self.view.addGestureRecognizer(swipeDown)
        self.view.addGestureRecognizer(swipeUp)
        
    }
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    let interactor = Interactor()
    @objc func panGestureRecognizerAction(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)
        
        let progress = searchProgression.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .Down
        )
        
        let close = searchProgression.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .Up
        )
        //down
        searchProgression.mapGestureStateToInteractor(
            gestureState: gesture.state,
            progress: progress,
            interactor: interactor) {
                // 6
                self.navigationItem.searchController = self.searchController
                self.searchController.isActive = true
                self.navigationController?.view.setNeedsLayout()
                self.navigationController?.view.layoutIfNeeded()
                self.searchController.hidesNavigationBarDuringPresentation = false
        }
        //UP
        searchProgression.mapGestureStateToInteractor(
            gestureState: gesture.state,
            progress: close,
            interactor: interactor) {
                // 6
                //self.navigationItem.searchController = nil
                self.searchController.isActive = false
                self.navigationController?.view.setNeedsLayout()
                self.navigationController?.view.layoutIfNeeded()
                
        }
    }
    
    //Swipe Down to search
    @objc func down(sender: UIGestureRecognizer) {
        print("User swiped down to search")
        
        self.navigationController?.view.setNeedsLayout()
        self.navigationController?.view.layoutIfNeeded()
        
        
        //show bar
        UINavigationBar.animate(withDuration: 0.50, animations: { () -> Void in
            
            self.navigationItem.searchController = self.searchController
            self.definesPresentationContext = true
            self.navigationController?.view.setNeedsLayout()
            self.navigationController?.view.layoutIfNeeded()
            //self.searchController.isActive = true
            
            self.searchController.hidesNavigationBarDuringPresentation = false
            self.searchController.searchBar.becomeFirstResponder()
            
        }, completion: { (Bool) -> Void in
        })
    }
    
    @objc func up(sender: UIGestureRecognizer) {
        print("User Swipped up dismiss search")
        
        
        UINavigationBar.animate(withDuration: 0.50, animations:  { () -> Void in
            //self.navigationItem.searchController = nil
            self.navigationController?.view.setNeedsLayout()
            self.navigationController?.view.layoutIfNeeded()

        }, completion: { (Bool) -> Void in
        })
    }
    
    
    
    //MARK: CollectonView Setup
    //Number of cells. update later for collection of cells based on product type
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        for i in productsGlobal! {
            print("for loop is working")
            if i.Pantry == true {
                //print(groceryItemCellContent().itemName)
                products.append(i)
            }
        }
        return products.count
    }
    
    //Initiating cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! pantryCellLayout
        
        productCell.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 255)
        productCell.gItem = products[indexPath.item]
        //productCell.gItem = productsGlobal![indexPath.item]
        
        
        //collectionview.insertIems(at: indexPaths)
        productCell.layer.cornerRadius = 5
        
        return productCell
    }
    
    
    
    var groceryProductsSelected: [IndexPath] = []
    var selectedGroceryProducts = [groceryItemCellContent]()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /*
         let selectedData = selectedGroceryItems[indexPath.item]
         if groceryItemSelected.contains(indexPath) {
         groceryItemSelected = groceryItemSelected.filter { $0 != indexPath }
         groceriesSelected = groceriesSelected.filter { $0 != selectedData }
         }
         */
        
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
        
        for i in products {
            if i.Pantry == true {
                i.Pantry = false
            }
        }
        
        for i in groceryProductsSelected.sorted(by: { $0.item > $1.item }) {
            print("User is about to remove \(products[i.item].itemName) from their pantry and delete it from their list and pantry")
            products.remove(at: i.item)
        }
        collectionView.deleteItems(at: groceryProductsSelected)
        selectedProductsIndexPath.removeAll()
        setEditing(false, animated: false)
    }
    
    //Setting up bar buttons
    private func setUpBarButtonItems() {
        self.navigationItem.leftBarButtonItem = editButtonItem
        //self.navigationItem.leftBarButtonItem = edit
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
        self.navigationItem.rightBarButtonItem = searching
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
        for i in products {
            print("there were \(products.count as Any) products")
            
            if i.Pantry == true {
                i.Pantry = false
                i.List = true
            }
        }
        
        for i in groceryProductsSelected.sorted(by: { $0.item > $1.item }) {
                        
            print("User is about to remove \(products[i.item].itemName) from their pantry and add it to their list")
            products.remove(at: i.item)
            
        }
        collectionView.deleteItems(at: groceryProductsSelected)
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
        
        let cController = productVCLayout()
        cController.hidesBottomBarWhenPushed = true
        //transition testing
        //cController.transitioningDelegate = TransitionCoordinator.self as? UIViewControllerTransitioningDelegate
        cController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(cController, animated: true, completion: nil)
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

