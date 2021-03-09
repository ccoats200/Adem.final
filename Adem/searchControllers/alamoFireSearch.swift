//
//  alamoFireSearch.swift
//  Adem
//
//  Created by Coleman Coats on 2/22/21.
//  Copyright © 2021 Coleman Coats. All rights reserved.
//

import Foundation
import Alamofire
import Firebase
//allows for codable
import FirebaseFirestoreSwift

//https://www.raywenderlich.com/6587213-alamofire-5-tutorial-for-ios-getting-started

protocol Displayable {
    var nameOfProduct: String { get }
    var priceOfProduct: Double? { get }
    var idOfProduct: Int? { get }
//    var nameOfingredients: String { get }
    var upcOfProduct: String? { get }
}


protocol DisplayableMeal {
    var nameOfMeal: String { get }
}
//MARK: ProductSearch Start -
struct searchedProduct: Decodable {
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}

struct searchedProducts: Decodable {
  let all: [searchedProduct]
  
  enum CodingKeys: String, CodingKey {
    case all = "products"
  }
}

extension searchedProduct: Displayable {
    var priceOfProduct: Double? {
        nil
    }
    
    
    var upcOfProduct: String? {
        nil
    }
    
    var idOfProduct: Int? {
        id
    }
    var nameOfProduct: String {
        title
      }
}
//MARK: ProductSearch End -

//MARK: ProductSearchId Start -
struct searchedProductsId: Codable {
    //let all: searchedProductId
    let id: Int
    let name: String
    let upc: String
    let price: Double
    //let ingredients: [searchedProductId]
  
  enum CodingKeys: String, CodingKey {
    case id
    case price
    case name = "title"
    case upc
  }
    
    enum ExpressionKeys: String {
        case id
        case name
        case upc
        case price
    }

    init(id: Int, name: String, upc: String, price: Double) {
        self.id = id
        self.name = name
        self.upc = upc
        self.price = price
    }
}

extension searchedProductsId: Displayable {
    var priceOfProduct: Double? {
        price
    }
    
    var idOfProduct: Int? {
        id
    }
    var nameOfProduct: String {
        name
      }

    var upcOfProduct: String? {
        upc
    }
    
}

struct convertToClass: Decodable {
    let convert: [searchedProductsId]
    
    enum CodingKeys: String, CodingKey {
        case convert = "results"
      }

}
//MARK: ProductSearchId End -


//MARK: - ProductSearchClass Start
class downloadSearchedProduct: NSObject, Codable {
    
    //https://api.spoonacular.com/food/products/22347
    @objc var id: Int
    @objc var title: String
    @objc var price: Double
    @objc var upc: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case upc
    }
    
    enum ExpressionKeys: String {
        case id
        case title
        case price
        case upc
    }
    
    init(id: Int, title: String, price: Double, upc: String) {
        self.id = id
        self.title = title
        self.upc = upc
        self.price = price
    }
}

extension downloadSearchedProduct: Displayable {
    var priceOfProduct: Double? {
        price
    }
    
    var idOfProduct: Int? {
        id
    }
    
    var upcOfProduct: String? {
        upc
    }
    
    var nameOfProduct: String {
        title
      }
    
}


//MARK: - ProductSearchClass End

//MARK: ProductMeal Start -
struct searchedMeal: Decodable {
    let id: Int
    let meal: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case meal
    }
}

struct searchedMeals: Decodable {
  let all: [searchedMeal]
  
  enum CodingKeys: String, CodingKey {
    case all = "meal"
  }
}

extension searchedMeal: DisplayableMeal {
    var nameOfMeal: String {
        meal
      }
}
//MARK: - ProductMeal End
