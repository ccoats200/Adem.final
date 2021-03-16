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
    var brandOfProduct: String? { get }
    var imagesOfProduct: [String]? { get }
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
    var imagesOfProduct: [String]? {
        nil
    }
    
    var brandOfProduct: String? {
        nil
    }
    
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
    var id: Int
    var name: String
    var upc: String
    var price: Double
    var brand: String
    var images: [String]
    var nutrition: nutrition
    //let ingredients: [searchedProductId]
    //might need additionalInformationKeys https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
  
  enum CodingKeys: String, CodingKey {
    case id
    case price
    case name = "title"
    case upc
    case brand
    case images
    case nutrition = "nutrition"
  }
    
    enum ExpressionKeys: String {
        case id
        case name
        case upc
        case price
        case brand
        case images
        case nutrition
    }

    init(id: Int, name: String, upc: String, price: Double, brand: String, images: [String], nutrition: nutrition) {
        self.id = id
        self.name = name
        self.upc = upc
        self.price = price
        self.brand = brand
        self.images = images
        self.nutrition = nutrition
    }
}

struct nutrition: Codable {
    
    var nutrients: [nutrients]

  enum CodingKeys: String, CodingKey {
    case nutrients = "nutrients"
  }

}

struct nutrients: Codable {
    
    var name: String
    var title: String
    var amount: Double
    var unit: String
    var percentOfDailyNeeds: Double

  
  enum CodingKeys: String, CodingKey {
    case name
    case title
    case amount
    case unit
    case percentOfDailyNeeds
  }
    
    enum ExpressionKeys: String {
        case name
        case title
        case amount
        case unit
        case percentOfDailyNeeds
        
    }

    init(name: String, title: String, amount: Double, unit: String, percentOfDailyNeeds: Double) {
        self.name = name
        self.title = title
        self.amount = amount
        self.unit = unit
        self.percentOfDailyNeeds = percentOfDailyNeeds
    }
}



//struct nutProductsId: Codable {
//
//    var title: String
//    var name: String
//
//    //let ingredients: [searchedProductId]
//    //might need additionalInformationKeys https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
//
//  enum CodingKeys: String, CodingKey {
//    case title
//    case name
//
//  }
//
//    enum ExpressionKeys: String {
//        case title
//        case name
//
//    }
//
//    init(title: String, name: String) {
//        self.title = title
//        self.name = name
//    }
//}

//For the list of nutriton

struct NutritionList {
    var name: String
    var amount: Double
    var unit: String
    var percentOfDailyNeeds: Double

    enum CodingKeys: String, CodingKey {
        case name
        case amount
        case unit
        case percentOfDailyNeeds
    }
    
    enum AdditionalInfoKeys: String, CodingKey {
        case elevation
    }
}


extension searchedProductsId: Displayable {
    var imagesOfProduct: [String]? {
        images
    }
    
    var brandOfProduct: String? {
        brand
    }
    
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
    var imagesOfProduct: [String]? {
        nil
    }
    
    
    var brandOfProduct: String? {
        nil
    }
    
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
