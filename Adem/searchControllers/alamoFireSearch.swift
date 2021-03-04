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

protocol Displayable {
    var nameOfProduct: String { get }
    var idOfProduct: Int { get }
}
protocol DisplayableId {
    var nameOfProduct: String { get }
    var idOfProduct: Int { get }
    var nameOfBread: String { get }
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
    var idOfProduct: Int {
        id
    }
    var nameOfProduct: String {
        title
      }
}

struct searchedProductId: Decodable {
    let id: Int
    let title: String
    let breadcrumbs: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case breadcrumbs
    }
}

struct searchedProductsId: Decodable {
  let all: [searchedProduct]
  
  enum CodingKeys: String, CodingKey {
    case all = "products"
  }
}

extension searchedProductId: DisplayableId {
    var idOfProduct: Int {
        id
    }
    var nameOfProduct: String {
        title
      }
    var nameOfBread: String {
        breadcrumbs
      }
    
}


//MARK: Downloading data
class downloadSearchedProduct: NSObject, Identifiable, Codable {
    
    //https://api.spoonacular.com/food/products/22347
    @objc var id: Int
    @objc var ingredients: [String: String]?
    @objc var nutrition: [String: String]
    @objc var price: Double
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case ingredients
        case nutrition
        case price
    }
    
    enum ExpressionKeys: String {
        case id
        case ingredients
        case nutrition
        case price
    }
    
    init(id: Int, ingredients: [String: String], nutrition: [String: String], price: Double) {
        self.id = id
        self.ingredients = ingredients
        self.nutrition = nutrition
        self.price = price
    }
}


//MARK: - ProductSearch End

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
