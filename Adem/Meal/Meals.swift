//
//  Meals.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVFoundation


class Meals: UIViewController, UIGestureRecognizerDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    let mealsCellID = "meals"
    var mealCollectionView: UICollectionView!
    
    let ffCCellIDAdd = "header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: NavigationBar setup
        navigationItem.title = "Meals"
        //MARK: Below is for a later version
        //self.navigationItem.rightBarButtonItem = add
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        
        setUpNavigationBar()
        setUpSearchBar()
        setUpDifferentViews()
        firebaseMealFetch()
        
        //getmeals
        
        //refressss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mealCollectionView.reloadData()
//        mealsSearchController.searchBar.becomeFirstResponder()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mealCollectionView.reloadData()
    }
    
    
    func firebaseMealFetch() {
        //Adds to the list
        //MARK: See the Products.swift for the full info
        //FIXME: need to add some fields. think through
        /*
        let newMeal = "chicken parm"
        userfirebaseMeals.document(newMeal).setData([
            
            "mealImage": "pancake",
            "mealName": newMeal,
            "mealRating": 2,
            "mealIngrediants": ["Flour","Eggs","Milk","Almond Extract","Salt","Syrup","a good"],
            "mealDescription": "test",
            "likedMeal": false,
        ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        
        */
        //finds one meal! see Products.swift for other ones
        userfirebaseMeals.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            arrayofMeals = documents.compactMap { queryDocumentSnapshot -> mealClass? in
                return try? queryDocumentSnapshot.data(as: mealClass.self)
            }
            self.mealCollectionView.reloadData()
        }
        
    }
    func setUpNavigationBar() {
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.ademBlue]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false

        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.ademGreen
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.largeTitleDisplayMode = .always
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        //MARK: Search bar
//        setUpSearchBar()

    }
    
    lazy var searching = UIBarButtonItem(image: UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    //MARK: Below is for a later version
    //lazy var add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleCreate))
    let mealsSearchController = UISearchController(searchResultsController: nil)

    private func setUpSearchBar() {
        mealsSearchController.searchResultsUpdater = self
        mealsSearchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.navigationItem.searchController = mealsSearchController
        mealsSearchController.hidesNavigationBarDuringPresentation = false
        mealsSearchController.searchBar.tintColor = UIColor.white
        mealsSearchController.searchBar.delegate = self
        mealsSearchController.searchBar.autocorrectionType = .default
        mealsSearchController.searchBar.enablesReturnKeyAutomatically = true
        mealsSearchController.searchBar.placeholder = "What would you like to Make?"
        
        //filter
        self.navigationItem.leftBarButtonItem = searching
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func handleSearch() {
        print("filter tapped")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("test")
    }
    
    //Setting up views
    
    func setUpDifferentViews() {

        //Didn't die making prog
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        //tv
        //mealCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
//        self.view.addSubview(mealCollectionView)
//
//        mealCollectionView.delegate = self
//        mealCollectionView.dataSource = self
//
//
//        mealCollectionView.register(mealsCellLayout.self, forCellWithReuseIdentifier: mealsCellID)
//        mealCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
//            mealCollectionView.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 13.0, *) {
            let compositionalLayout: UICollectionViewCompositionalLayout = {
                let fraction: CGFloat = 1.75 / 3.0
                let inset: CGFloat = 5.0
                    
                    
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
                    
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalWidth(fraction))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                    
                // Section
                let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: inset, bottom: 0, trailing: inset)
                //https://lickability.com/blog/getting-started-with-uicollectionviewcompositionallayout/#orthogonal-scrolling
                section.orthogonalScrollingBehavior = .continuous
                
                
                // Header Supplementary Item
                //FIXME: figure out height for header in section
                let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35))//.estimated(100))
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [headerItem]
                    
                return UICollectionViewCompositionalLayout(section: section)
                }()
            
            mealCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: compositionalLayout)
            mealCollectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
            self.view.addSubview(mealCollectionView)
            mealCollectionView.showsVerticalScrollIndicator = false
            mealCollectionView.delegate = self
            mealCollectionView.dataSource = self

            
            mealCollectionView.register(mealsCellLayout.self, forCellWithReuseIdentifier: mealsCellID)
            mealCollectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ffCCellIDAdd)
            mealCollectionView.translatesAutoresizingMaskIntoConstraints = false
            mealCollectionView.backgroundColor = UIColor.systemGray6
        } else {
            // Fallback on earlier versions
        }
        
        
        NSLayoutConstraint.activate([

            mealCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            mealCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mealCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mealCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
}

extension Meals: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return arrayofMeals.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mealsCell = collectionView.dequeueReusableCell(withReuseIdentifier: mealsCellID, for: indexPath) as! mealsCellLayout
        let mealIndex = arrayofMeals[indexPath.item]
        mealsCell.clipsToBounds = true
        mealsCell.layer.masksToBounds = true
        
        //MARK: populate the preview
        //This needs to have a outline to it
        switch mealIndex.likedMeal {
        case true:
            mealsCell.favoriteButton.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        case false:
            mealsCell.favoriteButton.setBackgroundImage(UIImage(named: "fave-1"), for: .normal)
        default:
            mealsCell.favoriteButton.setBackgroundImage(UIImage(named: "fave-1"), for: .normal)
        }
        
        mealsCell.mealName.text = mealIndex.mealName.capitalized
        mealsCell.ratingsCount.text = "(\(mealIndex.mealRating))"
        mealsCell.mealImageView.image = UIImage(named: "\(mealIndex.mealImage)")
        
        return mealsCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct: mealClass!
        selectedProduct = product(forIndexPath: indexPath)
        let detailViewController = mealVCLayout.detailViewControllerForProduct(selectedProduct)

        self.present(detailViewController, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ffCCellIDAdd, for: indexPath) as? HeaderSupplementaryView else {
                    return HeaderSupplementaryView()
                }
                
                headerView.viewModel = HeaderSupplementaryView.ViewModel(title: "Section \(indexPath.section + 1)")
                return headerView
                
            case "new-banner":
                let bannerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NewBannerSupplementaryView", for: indexPath)
                bannerView.isHidden = indexPath.row % 5 != 0 // show on every 5th item
                return bannerView
                
            default:
                assertionFailure("Unexpected element kind: \(kind).")
                return UICollectionReusableView()
            }
        }
}

extension Meals: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = mealCollectionView.bounds.width
            let numberOfItemsPerRow: CGFloat = 3
            let spacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
            let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
            let itemDimension = floor(availableWidth / numberOfItemsPerRow)
            return CGSize(width: itemDimension, height: itemDimension)
        }
    
    func product(forIndexPath: IndexPath) -> mealClass {
        var product: mealClass!
        product = arrayofMeals[forIndexPath.item]
        return product
    }
}

class HeaderSupplementaryView: UICollectionReusableView {
    
    //https://github.com/Lickability/collection-view-compositional-layout-demo/tree/main/Photos
    
    /// Encapsulates the properties required to display the contents of the view.
    struct ViewModel {
        /// The title to display in the view.
        let title: String
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myCustomInit()
        self.backgroundColor = UIColor.ademBlue
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.myCustomInit()
    }
    
    
    let welcomeLabel: UILabel = {
        let welcome = UILabel()
        welcome.textAlignment = .left
        welcome.textColor = UIColor.white
        welcome.font = UIFont(name: productFont, size: 30.0)
        //welcome.font = UIFont.systemFont(ofSize: 40)
        //welcome.font = UIFont.boldSystemFont(ofSize: 16)
        
        welcome.translatesAutoresizingMaskIntoConstraints = false
        return welcome
    }()
    
    /// The cell’s view model. Setting the view model updates the display of the view’s contents.
    var viewModel: ViewModel? {
        didSet {
            welcomeLabel.text = viewModel?.title
        }
    }
    
    func myCustomInit() {
        self.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            welcomeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            welcomeLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            welcomeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            welcomeLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
           
        ])
    }
}
