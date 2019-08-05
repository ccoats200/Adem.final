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

class listCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate {
    
    
    // Add a new document with a generated ID
    var docRef: DocumentReference!
    var handle: AuthStateDidChangeListenerHandle?
    let user = Auth.auth().currentUser
    
    let mostRecent = "most recent"
    let productRFIDNumber = "3860407808"
 
    //reuse ID's
    let cellID = "product"
    let headerID = "collectionViewHeader"
    
    var listProducts: [groceryItemCellContent]? = {
        /*
        var eggs = groceryItemCellContent()
        eggs.itemName = "Egg"
        eggs.itemImageName = "eggs"
        eggs.Quantity = "1"
        eggs.List = true
        eggs.Pantry = false
        
        var bb = groceryItemCellContent()
        bb.itemName = "BlueBerry"
        bb.itemImageName = "blueBerry"
        bb.Quantity = "1"
        bb.List = true
        bb.Pantry = false
 
        return [eggs, bb]
 */
        return []
    }()
    
    
    //var products: [groceryProductsStruct] = groceryProducts.fetchGroceryProductImages()
        var searchController = UISearchController(searchResultsController: nil)
    
    var selectedGroceryItems = [groceryItemCellContent]()
    var selectedCells = [UICollectionViewCell]()
    
    
    //var groceriesAddedFromList = [String]()

    var groceriesSelected = [String]()
    var groceryProductsSelected = [IndexPath]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.installsStandardGestureForInteractiveMovement = true
        
        //MARK: NavigationBar setup
        navigationItem.title = "List"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.ademBlue]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        
        self.searchController = UISearchController(searchResultsController: nil)
        //Drag and Drop
        //self.collectionView.dragDelegate = self
        //self.collectionView.dropDelegate = self
        //self.collectionView.dragInteractionEnabled = true
        //self.collectionView.dataSource = self
        
        
        //MARK: Cirular transition
        //navigationController?.delegate = transitionCoordinator as? UINavigationControllerDelegate
        
        //MARK: CollectionView setup
        self.collectionView.isScrollEnabled = true
        self.collectionView.isUserInteractionEnabled = true
        
        //self.collectionView.allowsMultipleSelection = true
        self.collectionView.dragInteractionEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.bounces = false
        //        if (collectionView.contentOffset.y == 0) {
        //            collectionView.bounces = true
        //            collectionView.alwaysBounceVertical = true
        //        } else if (collectionView.contentOffset.y > 1) {
        //            collectionView.bounces = false
        //            collectionView.alwaysBounceVertical = false
        //        }
        //
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(pantryCellLayout.self, forCellWithReuseIdentifier: cellID)
        
        //This moves the Cells to the correct offsets, Stylistic choice
        collectionView?.contentInset = UIEdgeInsets.init(top: 1, left: 1, bottom: 1, right: 1)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 50, right: 0)
        
        
        let shoppingCart = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleProduct))
        
        self.navigationItem.rightBarButtonItem = shoppingCart
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
        //setup()
        //setUpAddDismiss()
        
        //MARK: Search Setup
        //self.collectionView.contentOffset = CGPoint(x: 0.0, y: 11.0)
        //searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        self.searchController.isActive = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocorrectionType = .default
        searchController.searchBar.enablesReturnKeyAutomatically = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        print("the search bar is visible \(searchController.isActive)")
        
        
        //self.tabBarController?.delegate = self as? UITabBarControllerDelegate
        
        let Columns: CGFloat = 3.0
        let insetDimension: CGFloat = 2.0
        let cellHeight: CGFloat = 125.0
        let cellWidth = (collectionView.frame.width/Columns) - insetDimension
        let layouts = collectionViewLayout as! UICollectionViewFlowLayout
        layouts.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        
        //searchBar.delegate = self
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(addLongGestureRecognizer))
        //lpgr.delegate = self
        lpgr.minimumPressDuration = 0.35
        self.collectionView?.addGestureRecognizer(lpgr)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //disable bounce only at the top of the screen
        if collectionView.contentOffset.y == 0 {
            collectionView.bounces = true
            collectionView.alwaysBounceVertical = true
            collectionView.contentOffset.y = 0
        }
        //        if (collectionView.contentOffset.y == 0) {
        //            collectionView.bounces = true
        //            collectionView.alwaysBounceVertical = true
        //        } else if (collectionView.contentOffset.y > 0) {
        //            collectionView.bounces = false
        //            collectionView.alwaysBounceVertical = false
        //        }
    }
    
   
    //Start Long Press
    
    @objc func addLongGestureRecognizer(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        /*
         
         //Attempt to set into editing Style
         https://mobikul.com/ios-longpress-drag-and-drop-using-uicollectionview-with-animation/
         switch (gestureRecognizer.state) {
         case .began:
         guard let selectedIndexPath = collectionView.indexPathForItem(at: gestureRecognizer.location(in: self.collectionView)) else {
         return
         }
         collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
         case .changed:
         collectionView.updateInteractiveMovementTargetPosition(gestureRecognizer.location(in: gestureRecognizer.view!))
         case .ended:
         collectionView.endInteractiveMovement()
         self.collectionView.reloadData()
         
         default:
         collectionView.cancelInteractiveMovement()
         }
         //Attempt to set into editing Style
         
         
         */
        
        if gestureRecognizer.state != .began { return }
        let p = gestureRecognizer.location(in: self.collectionView)
        if let indexPath = self.collectionView.indexPathForItem(at: p) {
            //let cell = self.collectionView.cellForItem(at: indexPath)
            
            navigationController?.isEditing = true
            
        } else {
            print("can't find")
        }
    }
    
    //End long press
    
    
    //Authentication State listner
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.searchController.isActive = true
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
        
        handle = Auth.auth().addStateDidChangeListener { (auth, User) in
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.searchController.isActive = false
        self.navigationController?.view.layoutIfNeeded()
        self.navigationController?.view.setNeedsLayout()
        
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    
    // MARK: - Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        
        if self.isEditing {
            self.navigationItem.leftBarButtonItem = editButtonItem
            let added = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleBatchAdd))
            let trashed = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleBatchDelete))
            
            self.navigationItem.rightBarButtonItems = [added, trashed]
            self.collectionView.allowsMultipleSelection = true
            
        } else {
            let shoppingCart = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleProduct))
            
            self.navigationItem.rightBarButtonItems = [shoppingCart]
            self.navigationItem.leftBarButtonItem = editButtonItem
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
    
    //Delete item
    @objc func handleBatchDelete() {
        
        
    }
    //Add item back
    @objc func handleBatchAdd() {
        
        let cController = productVCLayout()
        cController.hidesBottomBarWhenPushed = true
        cController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(cController, animated: true, completion: nil)
        
        print("User add items in their pantry to their list ")
    }
    
    
    
    //MARK: SearchController setup
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        
    }
    
    
    // MARK: - Private instance methods
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        selectedGroceryItems = (listProducts?.filter({( groceryItems : groceryItemCellContent) -> Bool in
            return (groceryItems.itemName?.lowercased().contains(searchText.lowercased()))!
        }))!
        
        collectionView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    //Keyboard disappears
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchControllers().searchBars.resignFirstResponder()
        view.endEditing(true)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.isActive = false
        
        //collectionView.reloadData()
        self.navigationController?.view.setNeedsLayout()
        self.navigationController?.view.layoutIfNeeded()
        
        
    }
    
    func setupKeyboardDismissRecognizer(){
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(listCollectionView.searchBarSearchButtonClicked))
        
        
        self.view.addGestureRecognizer(tapRecognizer)
        //setup()
    }
    
    func setup() {
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
        
        panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(down))
        swipeDown.direction = .down
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(up))
        swipeUp.direction = .up
        
        
        //self.view.addGestureRecognizer(swipeDown)
        //self.view.addGestureRecognizer(swipeUp)
        
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
                // self.searchController.hidesNavigationBarDuringPresentation = true
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
        
        
        /*
         var translation = gesture.translation(in: collectionView)
         gesture.setTranslation(CGPoint(x: 0,y: 0), in: collectionView)
         print(translation)
         
         let touchPoint = gesture.location(in: self.view?.window)
         
         switch gesture.state {
         case .began:
         initialTouchPoint = touchPoint
         case .changed:
         if touchPoint.y - initialTouchPoint.y > 50 {
         self.navigationItem.searchController = self.searchController
         self.searchController.isActive = true
         self.navigationController?.view.setNeedsLayout()
         self.navigationController?.view.layoutIfNeeded()
         self.searchController.hidesNavigationBarDuringPresentation = false
         
         } else if touchPoint.y - initialTouchPoint.y < 0 {
         self.searchController.isActive = false
         self.navigationController?.view.setNeedsLayout()
         self.navigationController?.view.layoutIfNeeded()
         
         }
         case .cancelled:
         if touchPoint.y - initialTouchPoint.y > 200 {
         
         self.searchController.isActive = false
         self.navigationController?.view.setNeedsLayout()
         self.navigationController?.view.layoutIfNeeded()
         }
         case .ended:
         if touchPoint.y - initialTouchPoint.y > 200 {
         
         self.searchController.isActive = false
         self.navigationController?.view.setNeedsLayout()
         self.navigationController?.view.layoutIfNeeded()
         }
         default:
         UIView.animate(withDuration: 0.3, animations: {
         self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
         })
         }
         */
    }
    
    //Swipe Down to search
    @objc func down(sender: UIGestureRecognizer) {
        print("User swiped down to search")
        
        //show bar
        UINavigationBar.animate(withDuration: 0.50, animations: { () -> Void in
            
            //self.navigationItem.searchController = self.searchController
            self.definesPresentationContext = true
            //self.searchController.isActive = true
            
            //self.searchController.hidesNavigationBarDuringPresentation = true
            self.searchController.searchBar.becomeFirstResponder()
            
        }, completion: { (Bool) -> Void in
        })
    }
    
    @objc func up(sender: UIGestureRecognizer) {
        print("User Swipped up dismiss search")
        
        
        UINavigationBar.animate(withDuration: 0.50, animations:  { () -> Void in
            //self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationItem.searchController = nil
            self.navigationController?.view.setNeedsLayout()
            self.navigationController?.view.layoutIfNeeded()
            
        }, completion: { (Bool) -> Void in
        })
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
    
    //MARK: CollectonView Setup
    //Number of cells. update later for collection of cells based on product type
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering() {
            return selectedGroceryItems.count
        }
        
        for i in productsGlobal! {
            print("for loop is working")
            if i.List == true {
               listProducts?.append(i)
            }
        }
        return listProducts!.count
    }
    
    func finding() {
    for i in ([productsGlobal]) {
    if groceryItemCellContent().List == true {
        //listProducts?.append(i)
            }
        }
    }

    //Initiating cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! pantryCellLayout
        
        productCell.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 255)
        
//        for _ in (productsGlobal)! {
//            if groceryItemCellContent().List == true {
//                productCell.gItem = productsGlobal![indexPath.item]
//            }
//        }
        
        productCell.gItem = listProducts![indexPath.item]
        productCell.layer.cornerRadius = 5

        var productsInFilter: groceryItemCellContent
        if isFiltering() {
            productsInFilter = selectedGroceryItems[indexPath.item]
        } else {
            productsInFilter = (listProducts?[indexPath.item])!
        }
        return productCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
            //self.products?.remove(at: indexPath.item)
            //collectionView.deleteItems(at: [indexPath])
            
            //MARK: Add bottom bar here
            pantryCellLayout().selectedButton.isHidden = !isEditing
            
        default:
            switch indexPath.item {
            case 1:
                handleProduct()
            default:
                handleAlert()
            }
        }
        print(pantryCellLayout().selectedButton.backgroundColor!)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
        //let cellToDeselect:pantryCellLayout = collectionView.cellForItem(at: indexPath as IndexPath)! as! pantryCellLayout
        //cellToDeselect.selectedButton.backgroundColor = UIColor.white
    }
    
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
