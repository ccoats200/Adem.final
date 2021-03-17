//
//  searchTVC.swift
//  Adem
//
//  Created by Coleman Coats on 6/25/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import UIKit
import Alamofire

protocol searchAddToListDelegate: class {
    func add(cell: searchTableViewCell)
//    func add(cell: IndexPath)
}

class ResultsTableController: UITableViewController {
    
    let tableViewCellIdentifier = "cellID"
    var filteredProducts = [fireStoreDataClass]()
//    weak var delegate: searchAddToListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(searchTableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as! searchTableViewCell
        let product = filteredProducts[indexPath.row]
//        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        addButton.setImage(UIImage(named: "addButton"), for: .normal)
//        addButton.addTarget(self, action: #selector(selectedButtonDidTap(_:)), for: .touchUpInside)
        cell.textLabel?.text = product.productName
        cell.delegate = self
//        cell.accessoryView = self.addButton
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
   
    
}

class searchTableViewCell: UITableViewCell {
    
    weak var delegate: searchAddToListDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        addButton.setImage(UIImage(named: "addButton"), for: .normal)
        addButton.addTarget(self, action: #selector(selectedButtonDidTap(_:)), for: .touchUpInside)
        self.accessoryView = addButton
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectedButtonDidTap(_ sender: Any) {
        delegate?.add(cell: self)
    }
}


extension ResultsTableController: searchAddToListDelegate {
    
    func add(cell: searchTableViewCell) {
        
        if let indexPath = tableView?.indexPath(for: cell) {
            //1. Change filteredProducts to api search
            let item = filteredProducts[indexPath.row].fireBId
            print(item)
            self.updateProductLocationValues(indexPath: item!, pantry: true, list: false)
            self.addTimeStamp(id: item!, action: engagements.added.rawValue)
        }
    }
}

class AddResultsTableController: UITableViewController {
    
    let tableViewCellIdentifier = "addProducts"
    var filteredProducts = [fireStoreDataClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        let product = filteredProducts[indexPath.row]
        cell.textLabel?.text = product.productName
    
        return cell
    }
    //https://lottiefiles.com/marketplace
    //https://spotify.design/
    //https://lottiefiles.com/27155-preparing-food
}

class PantryResultsTableController: UITableViewController {//, UISearchControllerDelegate {
    
    let tableViewCellIdentifier = "cellID"
    var filteredProducts = [fireStoreDataClass]()
    var productYouCanAdd: [Displayable] = []
    //var productYouCanAddId: [DisplayableId] = []
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        //setUpSearch()
        //fetchSearchProducts(
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setUpSearch()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productYouCanAdd.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
//        let product = filteredProducts[indexPath.item]
        let product = productYouCanAdd[indexPath.row]
        cell.textLabel?.text = product.nameOfProduct
        
        //cell.textLabel?.backgroundColor = UIColor.orange
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productYouCanAdd[indexPath.row]
        let test = product.idOfProduct
        arrayofSearchEngaged.removeAll()
        arrayofSearchEngagedStruct.removeAll()
//        fetchSearchIdProduct(indexPath: indexPath, Id: test!)
        downloadSearchIdProduct(indexPath: indexPath, Id: test!)
        print(arrayofSearchEngaged.count)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            //https://www.zerotoappstore.com/create-a-delay-or-wait-in-swift.html
            let selectedProduct: fireStoreDataClass!
            selectedProduct = self.productSelected(forIndexPath: indexPath)
            let detailViewController = listProductVCLayout.detailViewControllerForProduct(selectedProduct)
            self.present(detailViewController, animated: true, completion: nil)
        })
        //Also Download data and upload to firebase once they add to a list or pantry.
    }
    

    func fetchSearchIdProduct(indexPath: IndexPath, Id: Int) {

        //https://stackoverflow.com/questions/35906568/wait-until-swift-for-loop-with-asynchronous-network-requests-finishes-executing
        //let url = "https://api.spoonacular.com/food/products/search"
        //need sku and upc for store and manufacturers
        
        //let url = "https://api.spoonacular.com/food/products/upc/041631000564?apiKey=5f40f799c85b4be089e48ca83e01d3c0"
        let url = "https://api.spoonacular.com/food/products/30004?apiKey=5f40f799c85b4be089e48ca83e01d3c0"
        let urlCall = "https://api.spoonacular.com/food/products/"
        let other = Id
        let last = "?apiKey=5f40f799c85b4be089e48ca83e01d3c0"
        let complete = urlCall+"\(other)"+last
        //let parameters: [String: String] = ["query": name]
        //AF.request(url, parameters: parameters)
        //FIXME: This is working but is not great
        //https://stackoverflow.com/questions/51183795/how-to-convert-one-type-of-object-array-into-another
        AF.request(complete)
            .validate()
            .responseDecodable(of: searchedProductsId.self) { (response) in
                guard let products = response.value else { return }

                //Need to grab data here. populate the next screen based on grab. See list page tableview select.
                print(products.name)
                print(products.id)
                print(products.upc)
                print(products.price)
        }
    }
    func downloadSearchIdProduct(indexPath: IndexPath, Id: Int) {
        //https://stackoverflow.com/questions/43204249/wait-until-alamofire-is-done-getting-request-and-making-object
        
        let urlCall = "https://api.spoonacular.com/food/products/"
        let other = Id
        let last = "?apiKey=5f40f799c85b4be089e48ca83e01d3c0"
        let complete = urlCall+"\(other)"+last
        //https://learnappmaking.com/codable-json-swift-how-to/
        
        AF.request(complete).validate().responseJSON { response in
            switch (response.result) {
            case .success( _):
                do {
                    //https://stackoverflow.com/questions/53932841/converting-json-response-to-a-struct-in-swift
                    let users = try? JSONDecoder().decode(searchedProductsId.self, from: response.data!)
                    arrayofSearchEngagedStruct.append(users!)
                    print(arrayofSearchEngagedStruct.count)
                    print(arrayofSearchEngagedStruct.map {$0.nutrition.nutrients[0]})
                    

                    arrayofSearchEngaged = arrayofSearchEngagedStruct.map { item -> fireStoreDataClass in

                        let title = item.name
                        let id = item.id
                        let upc = item.upc
                        let price = item.price
                        let brand = item.brand
                        let image = item.images[0]


                        return fireStoreDataClass(fireBId: title, productName: title, productPrice: price, productDescription: brand, productQuantity: 1, productImage: image, category: title, productExpir: nil, productList: false, productPantry: false)
                    }
                    print(" there are blank \(arrayofSearchEngaged.count)")
                    print(arrayofSearchEngaged.map {$0.productImage})
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                   // */
                }
            case .failure(let error):
                print("Request error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchSearchProduct(for name: String) {
       //MARK: Use GTIN number
        //let url = "https://api.spoonacular.com/food/products/search"
        let url = "https://api.spoonacular.com/food/products/search?query="
        let other = name
        let last = "&apiKey=5f40f799c85b4be089e48ca83e01d3c0"
        let parameters: [String: String] = ["query": name]
        //AF.request(url, parameters: parameters)
        //FIXME: This is working but is not great. need to use param
        AF.request(url+other+last)
            .validate()
            .responseDecodable(of: searchedProducts.self) { (response) in
            guard let products = response.value else { return }
                print(products.all[0].id)
                self.productYouCanAdd = products.all
            self.tableView.reloadData()
        }
    }
}
//MARK: For product selection
extension PantryResultsTableController {
    
    func productSelected(forIndexPath: IndexPath) -> fireStoreDataClass {
        var product: fireStoreDataClass!
        product = arrayofSearchEngaged[forIndexPath.item]
        return product
    }
    
}

/*
extension PantryResultsTableController: UISearchBarDelegate {
    
    func setUpSearch() {
        //MARK: Search bar
        //pantryResultsTableController = PantryResultsTableController()
        //pantryResultsTableController.tableView.delegate = self
        //pantryResultsTableController.collectionView.delegate = self
        searchController = UISearchController(searchResultsController: self)
        searchController.delegate = self
        //searchController.searchResultsUpdater = self
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
           
        //let keywords = searchBar.text
        
        guard let productName = searchBar.text else { return }
        PantryResultsTableController().fetchSearchProduct(for: productName)
        
        //        let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "+")
        //           searchUrl = "https://api.spotify.com/v1/search?q=\(finalKeywords!)&type=track"
        
        //self.view.endEditing(true)
        print(productName)
        //searchBar.resignFirstResponder()
        }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let productName = searchBar.text else { return }
        PantryResultsTableController().fetchSearchProduct(for: productName)
        print(productName)
        
    }
        
    
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = nil
            searchBar.resignFirstResponder()
            
            self.dismiss(animated: true, completion: nil)
        }
            
        var isSearchBarEmpty: Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        }
}

*/
/*
 class PantryResultsTableController: UICollectionViewController {//UITableViewController,  {
     
     let tableViewCellIdentifier = "cellID"
     var filteredProducts = [fireStoreDataClass]()
     
     override func viewDidLoad() {
         super.viewDidLoad()

         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: tableViewCellIdentifier)
         //tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
     }
     
     // MARK: - UITableViewDataSource
     
 //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 //        return filteredProducts.count
 //    }
     override func numberOfSections(in collectionView: UICollectionView) -> Int {
         return filteredProducts.count
     }
     
 //    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 //        return 60
 //    }
     
     
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tableViewCellIdentifier, for: indexPath) as! mealsCellLayout//.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
         let product = filteredProducts[indexPath.item]
         cell.mealName.text = product.productName
         //cell?.mealImageView?.backgroundColor = UIColor.orange
         return cell
     }
     
 //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 //        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
 //        let product = filteredProducts[indexPath.item]
 //        cell.textLabel?.text = product.productName
 //        cell.textLabel?.backgroundColor = UIColor.orange
 //
 //        return cell
 //    }
 }

 */
