//
//  Products.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase

//might be able to remove because useing snapshots
//import FirebaseFirestoreSwift

struct friendFamily {
    var friendImage: String?
    var friendName: String?
}

struct meals {
    var mealImage: String?
    var mealName: String?
    var mealRating: Double?
    var ingrediants = [String?]()
}

struct recomend {
    var itemImage: String?
   
}
var recCell = [
    recomend(itemImage: "eggs"),
    recomend(itemImage: "almondExtract"),
    recomend(itemImage: "flour"),
]



var friends = [
    friendFamily(friendImage: "boy", friendName: "Will"),
    friendFamily(friendImage: "boy", friendName: "Dan"),
    friendFamily(friendImage: "boy", friendName: "Cole"),
    friendFamily(friendImage: "girl", friendName: "Alex")
]

var mealsMaster = [
    meals(mealImage: "pancake", mealName: "Pancakes", mealRating: 4.5, ingrediants: ["Chicken","pasta"]),
    meals(mealImage: "spaghetti", mealName: "Spaghetti carbonara", mealRating: 4.5, ingrediants: ["Chicken","pasta"]),
    meals(mealImage: "tacos", mealName: "Tacos", mealRating: 4.5, ingrediants: ["Chicken","pasta"]),
    meals(mealImage: "dumps", mealName: "Dumplings", mealRating: 4.5, ingrediants: ["Chicken","pasta"]),
    meals(mealImage: "jBacon", mealName: "Jalapeno poppers", mealRating: 4.5, ingrediants: ["Chicken","pasta"]),
    meals(mealImage: "eggsb", mealName: "Eggs & Bacon", mealRating: 4.5, ingrediants: ["Chicken","pasta"]),
]


//MARK: Wrong
var productsMaster = [


    productSKU(productSKU: nil, productName: "Butter", productImage: "butter", productNutritionLabel: "nutrition", productIngrediants: ["flour": "f"], productDescription: "Butter is needed for eggs", productList: false, productPantry: true, productExpirDate: "3", productPrice: 5.99, productQuantity: 2, recomemnded: ["eggs","bacon"]),



]


struct productSKU {
    
    var productSKU: String?
    var productName: String?
    
    //reference
    var productImage: String?
    var productNutritionLabel: String?
    
    //map
    var productIngrediants: [String: Any]?
    
    var diet: [String]?
    //for filters
    var productCategory: [String]?
    
    
    var productDescription: String?
    var productList: Bool?
    var productPantry: Bool?
    //date
    var productExpirDate: String?
    var productPrice: Double?
    var productQuantity: Int?
    
    //map or reference
    var meals: [String: Any]?
    
    //calculation (net weight/estiamat used)
    var waste: Double?
    

    //Map
    var recomemnded: [String]?

}
struct filters {
    var filter: String
    
    //probably need protocol / extension
    
    init?(data: [String: Any]) {

    guard let filter = data["category"] as? String
         else {
            return nil
    }
        self.filter = filter
    }
}

var arrayofFilter = [filters]()




//MARK: - Delete
struct groceryProductsDatabase {
    
    //USER Specific
    var groceryProductName: String
}

var allproductsInList = [
    groceryProductsDatabase(groceryProductName: "Eggs"),
    groceryProductsDatabase(groceryProductName: "Bacon"),
    groceryProductsDatabase(groceryProductName: "Waffels"),
    groceryProductsDatabase(groceryProductName: "Chicken"),
    groceryProductsDatabase(groceryProductName: "Kale"),
    groceryProductsDatabase(groceryProductName: "Kraft Mac and cheese"),
    groceryProductsDatabase(groceryProductName: "Milk"),
    groceryProductsDatabase(groceryProductName: "Fuck")
]

//Product attributes
class groceryItemCellContent: NSObject {
    
    var itemImageName: String?
    var listImageName: String?
    var itemName: String?
    var Quantity: String?
    var List: Bool?
    var Pantry: Bool?
    
}

var productsGlobal: [groceryItemCellContent]? = {
    
    var eggs = groceryItemCellContent()
    eggs.itemName = "Egg"
    eggs.itemImageName = "eggs"
    eggs.Quantity = "2"
    eggs.List = true
    eggs.Pantry = false
    
    var bacon = groceryItemCellContent()
    bacon.itemName = "bacon"
    bacon.itemImageName = "bacon"
    bacon.Quantity = "2"
    bacon.List = true
    bacon.Pantry = false
    
    return [eggs, bacon]
}()
