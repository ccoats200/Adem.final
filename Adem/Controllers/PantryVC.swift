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
    
    var products: [groceryItemCellContent]? = {
        
        
        var eggs = groceryItemCellContent()
        eggs.itemName = "Egg"
        eggs.itemImageName = "bread"
        eggs.Quantity = "1"
        
        var bre = groceryItemCellContent()
        bre.itemName = "PantryVC"
        bre.itemImageName = "bread"
        bre.Quantity = "1"
        
        var tea = groceryItemCellContent()
        tea.itemName = "PantryVC"
        tea.itemImageName = "bread"
        tea.Quantity = "1"
        
        var a = groceryItemCellContent()
        a.itemName = "PantryVC"
        a.itemImageName = "bread"
        a.Quantity = "1"
        
        var b = groceryItemCellContent()
        b.itemName = "PantryVC"
        b.itemImageName = "bread"
        b.Quantity = "1"
        
        var c = groceryItemCellContent()
        c.itemName = "PantryVC"
        c.itemImageName = "bread"
        c.Quantity = "1"
        var d = groceryItemCellContent()
        d.itemName = "PantryVC"
        d.itemImageName = "bread"
        d.Quantity = "1"
        
        var e = groceryItemCellContent()
        e.itemName = "PantryVC"
        e.itemImageName = "bread"
        e.Quantity = "1"
        
        var f = groceryItemCellContent()
        f.itemName = "PantryVC"
        f.itemImageName = "bread"
        f.Quantity = "1"
        var g = groceryItemCellContent()
        g.itemName = "PantryVC"
        g.itemImageName = "bread"
        g.Quantity = "1"
        
        
        return [eggs, bre,tea,a,b,c,d,e,f,g]
    }()
    
    //reuse ID's
    let cellID = "product"
    let headerID = "collectionViewHeader"
    
    let searchController = UISearchController(searchResultsController: nil)
    weak var collectionView: UICollectionView!
    
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
        
        let layouts: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let pantryCollectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layouts)
        
        
        pantryCollectionView.dataSource = self
        pantryCollectionView.delegate = self
        pantryCollectionView.register(pantryCellLayout.self, forCellWithReuseIdentifier: cellID)
        pantryCollectionView.backgroundColor = UIColor.white
        pantryCollectionView.isUserInteractionEnabled = true
        pantryCollectionView.isScrollEnabled = true
        //pantryCollectionView.bounces = true
        //pantryCollectionView.alwaysBounceVertical = true
        
        
        //Maybe delete https://theswiftdev.com/2018/06/26/uicollectionview-data-source-and-delegates-programmatically/
        pantryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        pantryCollectionView.contentInset = UIEdgeInsets.init(top: 1, left: 1, bottom: 1, right: 1)
        
        let Columns: CGFloat = 3.15
        let insetDimension: CGFloat = 2.0
        let cellHeight: CGFloat = 125.0
        let cellWidth = (pantryCollectionView.frame.width/Columns) - insetDimension
        layouts.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
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
        
        
        let searching = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        
        self.navigationItem.rightBarButtonItem = searching
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.ademBlue
        
        
        //setup()
        self.view.addSubview(pantryCollectionView)
        
        //Maybe delete
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: pantryCollectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: pantryCollectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: pantryCollectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: pantryCollectionView.trailingAnchor),
            ])
        self.collectionView = pantryCollectionView
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(addLongGestureRecognizer))
        lpgr.minimumPressDuration = 0.35
        self.collectionView?.addGestureRecognizer(lpgr)
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchString = searchController.searchBar.text
        
        
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
            self.navigationItem.leftBarButtonItem = editButtonItem
            self.navigationItem.rightBarButtonItem = nil
            self.collectionView.allowsMultipleSelection = true
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.toolbar.barTintColor = UIColor.white
            self.navigationController?.isToolbarHidden = false
            
            var items = [UIBarButtonItem]()
            
            items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
            
            items.append(
                UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleBatchAdd))
            )
            
            items.append(
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            )
            
            items.append(
                UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleBatchDelete))
            )
            
            
            items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
            
            self.toolbarItems = items
            
            /*
             var items = [UIBarButtonItem]()
             
             let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
             fixedSpace.width = 75.0
             items.append(fixedSpace)
             
             let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleProduct))
             items.append(addButton)
             
             items.append(
             UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
             )
             let addToList: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleProduct))
             items.append(addToList)
             let fixedSpace2: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
             fixedSpace2.width = 75.0
             items.append(fixedSpace2)
             
             self.toolbarItems = items
             */
            
            
            
        } else {
            let searching = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleProduct))
            
            self.navigationItem.rightBarButtonItem = searching
            self.navigationItem.leftBarButtonItem = editButtonItem
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.isToolbarHidden = true
            //self.collectionView.allowsMultipleSelection = false
            
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
    
    //Delete item
    @objc func handleBatchDelete() {
        
        var selectedCells = [1,2]
        for cells in selectedCells {
            //cells.delegate = self as? pantryItemDelegate
        }
        
    }
    //Add item back
    @objc func handleBatchAdd() {
        
        let cController = productVCLayout()
        cController.hidesBottomBarWhenPushed = true
        cController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(cController, animated: true, completion: nil)
        
        print("User add items in their pantry to their list ")
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
    
    //MARK: CollectonView Setup
    //Number of cells. update later for collection of cells based on product type
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products!.count
    }
    
    //Initiating cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! pantryCellLayout
        
        productCell.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 255)
        productCell.gItem = products![indexPath.item]
        //collectionview.insertIems(at: indexPaths)
        productCell.layer.cornerRadius = 5
        
        return productCell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /*
         let selectedData = selectedGroceryItems[indexPath.item]
         if groceryItemSelected.contains(indexPath) {
         groceryItemSelected = groceryItemSelected.filter { $0 != indexPath }
         groceriesSelected = groceriesSelected.filter { $0 != selectedData }
         
         }*/
        
        //let selectedCell: pantryCellLayout = collectionView.cellForItem(at: indexPath as IndexPath)! as! pantryCellLayout
        //if selectedCell.selectedButton.backgroundColor == UIColor.red {}
        
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

