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
//    var nameOfingredients: String { get }
    var upcOfProduct: String { get }
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
//MARK: ProductSearch End -

//MARK: ProductSearchId Start -
struct searchedProductId: Decodable {
    let id: Int
    let title: String
    //let ingredients: String
    //let generatedText: String
    let upc: String
    
    //Omit properties from the CodingKeys enumeration if they won't be present when decoding instances, or if certain properties shouldn't be included in an encoded representation. A property omitted from CodingKeys needs a default value in order for its containing type to receive automatic conformance to Decodable or Codable. https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
    

    enum CodingKeys: String, CodingKey {
        case id
        case title
        //case ingredients
        //case generatedText
        case upc
    }
}


struct searchedProductsId: Decodable {
    //let all: searchedProductId
    let title: String
    let upc: String
    //let ingredients: [searchedProductId]
  
  enum CodingKeys: String, CodingKey {
//    case title = "title"
    //case all = "upc"
    case title
    case upc
    //case ingredients = "ingredients"
  }
    enum ExpressionKeys: String {
        case title
        case upc
    }
    init(title: String, upc: String) {
        self.title = title
        self.upc = upc
    }
}

extension searchedProductId: DisplayableId {
    var idOfProduct: Int {
        id
    }
    var nameOfProduct: String {
        title
      }
//    var nameOfingredients: String {
//        ingredients
//      }
    var upcOfProduct: String {
        upc
    }
    
}
//MARK: ProductSearchId End -


//MARK: - ProductSearchClass Start
class downloadSearchedProduct: NSObject, Codable {
    
    //https://api.spoonacular.com/food/products/22347
//    @objc var id: Int
    @objc var title: String
//    @objc var ingredients: [String: String]?
//    @objc var nutrition: [String: String]
//    @objc var price: Double
    @objc var upc: String
    
    
    enum CodingKeys: String, CodingKey {
//        case id
        case title
//        case ingredients
//        case nutrition
//        case price
        case upc
    }
    
    enum ExpressionKeys: String {
//        case id
        case title
//        case ingredients
//        case nutrition
//        case price
        case upc
    }
    
//    init(id: Int, title: String, ingredients: [String: String], nutrition: [String: String], price: Double, upc: String) {
//        self.id = id
//        self.title = title
//        self.ingredients = ingredients
//        self.nutrition = nutrition
//        self.price = price
//        self.upc = upc
//    }
    init(title: String, upc: String) {
        self.title = title
        self.upc = upc
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
