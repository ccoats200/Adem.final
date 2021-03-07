//
//  fireStoreData.swift
//  Adem
//
//  Created by Coleman Coats on 5/8/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import Firebase
//allows for codable
import FirebaseFirestoreSwift
import Alamofire

//https://cs.opensource.google/firebase-sdk/firebase-ios-sdk
/*
class fireStoreDataStruct: NSObject, Identifiable, Codable {
       //@DocumentID Grabs the doc Id for me. don't add it as data in the doc
    @DocumentID var id: String?
    var productName: String
    var productPrice: Double
    var productDescription: String
    var productQuantity: Int
    var productImage: String
    var category: String?
    //can do the image url
    //var image: URL
    
}
*/


//var arrayofPantry = [fireStoreDataStruct]()
//FIXME: need to search even if the pantry tab isn't tapped. waiting for the pantry call too early.
var arrayofPantry = [fireStoreDataClass]()
var arrayofSearchEngaged = [fireStoreDataClass]()
var arrayofSearchEngagedStruct = [searchedProductsId]()
var arrayofHome = [individualHomeAttributes]()
var arrayofHouse = [collectiveHouseAttributes]()
//var arrayofProducts = [fireStoreDataStruct]()
//FIXME: need to search even if the pantry tab isn't tapped. waiting for the pantry call too early.
var arrayofProducts = [fireStoreDataClass]()
var arrayofAddProducts = [fireStoreDataClass]()

var sharedUser = [sharedHouseAttributes]()
var sharedUserNoClass = [String: Any]()


var arrayofMeals = [mealClass]()
var arrayofTestingPallette = [mealClass]()
var arrayofLikedMeals = [mealClass]()


var backUp = [fireStoreDataStruct]()
var backUp2 = [fireStoreDataStruct]()
var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
//Should be static add promote if none in filter
var productCategories = ["All", "Dairy","Fruit","Veggies", "Frozen","Meat","Other", "Extract","Grain"]
var personalProductCategories = ["All"]
var searchDimensions = ["Add","List"]

//MARK: - This is for Changing the home they are in
//Needs to be userdefaults
var privatehomeAttributes = [String: Any]()

//MARK: - This is for Changing the home they are in

class UserRepository {
    
    //https://www.iosapptemplates.com/blog/ios-development/data-persistence-ios-swift
    enum Key: String, CaseIterable {
            case name, avatarData
            func make(for userID: String) -> String {
                return self.rawValue + "_" + userID
            }
        }
        let userDefaults: UserDefaults
        // MARK: - Lifecycle
        init(userDefaults: UserDefaults = .standard) {
            self.userDefaults = userDefaults
        }
        // MARK: - API
        func storeInfo(forUserID userID: String, name: String, avatarData: Data) {
            saveValue(forKey: .name, value: name, userID: userID)
            saveValue(forKey: .avatarData, value: avatarData, userID: userID)
        }
        
        func getUserInfo(forUserID userID: String) -> (name: String?, avatarData: Data?) {
            let name: String? = readValue(forKey: .name, userID: userID)
            let avatarData: Data? = readValue(forKey: .avatarData, userID: userID)
            return (name, avatarData)
        }
        
        func removeUserInfo(forUserID userID: String) {
            Key
                .allCases
                .map { $0.make(for: userID) }
                .forEach { key in
                    userDefaults.removeObject(forKey: key)
            }
        }
        // MARK: - Private
        private func saveValue(forKey key: Key, value: Any, userID: String) {
            userDefaults.set(value, forKey: key.make(for: userID))
        }
        private func readValue<T>(forKey key: Key, userID: String) -> T? {
            return userDefaults.value(forKey: key.make(for: userID)) as? T
        }

}




struct individualHomeAttributes: Identifiable, Codable {

   //Grabs the doc Id for me
    @DocumentID var id: String?
    var homeName: String
    var home: String
    var uid: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case homeName
        case home
        case uid
   }
    
    enum ExpressionKeys: String {
        case id
        case homeName
        case home
        case uid
    }
    
    init(id: String, homeName: String, home: String, uid: String) {
        self.id = id
        self.homeName = homeName
        self.home = home
        self.uid = uid
    }
}
struct collectiveHouseAttributes: Identifiable, Codable {

    @DocumentID var id: String?
    var homeName: String
    var homeId: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case homeName
        case homeId
   }
    
    enum ExpressionKeys: String {
        case id
        case homeName
        case homeId
    }
    
    init(id: String, homeName: String, homeId: String) {
        self.id = id
        self.homeName = homeName
        self.homeId = homeId
    }
}

struct sharedHouseAttributes: Identifiable, Codable {
    
    @DocumentID var id: String?
    var houseName: String
    var owner: String
    var sharedWith: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case houseName
        case owner
        case sharedWith
   }
    
    enum ExpressionKeys: String {
        case id
        case houseName
        case owner
        case sharedWith
    }
    
    init(id: String, houseName: String, owner: String, sharedWith: [String]) {
        self.id = id
        self.houseName = houseName
        self.owner = owner
        self.sharedWith = sharedWith
    }
}

struct fireStoreDataStruct: Identifiable, Codable {

    //Grabs the doc Id for me!
    @DocumentID var id: String?
    var productName: String
    var productPrice: Double
    var productDescription: String
    var productQuantity: Int
    var productImage: String
    var category: String?
    var productExpir: Date
    
    enum CodingKeys: String, CodingKey {
       case id
       case productName
       case productPrice
       case productDescription
       case productQuantity
       case productImage
       case category
       case productExpir
    }
 }

class mealClass: NSObject, Identifiable, Codable {

   //Grabs the doc Id for me
    @DocumentID var id: String?
    @objc var mealName: String
    @objc var mealRating: Int
    @objc var mealDescription: String
    @objc var mealImage: String
    @objc var mealIngrediants: [String]
    @objc var likedMeal: Bool
  
    enum CodingKeys: String, CodingKey {
        case id
        case mealName
        case mealRating
        case mealDescription
        case mealImage
        case mealIngrediants
        case likedMeal
      
   }
    
    enum ExpressionKeys: String {
        case id
        case mealName
        case mealRating
        case mealDescription
        case mealImage
        case mealIngrediants
        case likedMeal
        
    }
    
    init(id: String,mealName: String, mealRating: Int, mealDescription: String, mealImage: String, mealIngrediants: [String], likedMeal: Bool) {
        self.id = id
        self.mealName = mealName
        self.mealRating = mealRating
        self.mealDescription = mealDescription
        self.mealImage = mealImage
        self.mealIngrediants = mealIngrediants
        self.likedMeal = likedMeal
       
    }
}

class fireStoreDataClass: NSObject, Identifiable, Codable {

   //Grabs the doc Id for me!
    //MARK need to chang the id to fireBId for api call
   @DocumentID var fireBId: String?
   @objc var productName: String
   @objc var productPrice: Double
   @objc var productDescription: String
   @objc var productQuantity: Int
   @objc var productImage: String
   @objc var category: String?
   @objc var productExpir: Date
   
   enum CodingKeys: String, CodingKey {
      case fireBId
      case productName
      case productPrice
      case productDescription
      case productQuantity
      case productImage
      case category
      case productExpir
   }
    
    enum ExpressionKeys: String {
       case fireBId
       case productName
       case productPrice
       case productDescription
       case productQuantity
       case productImage
       case category
       case productExpir
    }
    
    init(fireBId: String, productName: String, productPrice: Double, productDescription: String, productQuantity: Int, productImage: String, category: String, productExpir: Date) {
        self.fireBId = fireBId
        self.productName = productName
        self.productPrice = productPrice
        self.productDescription = productDescription
        self.productQuantity = productQuantity
        self.productImage = productImage
        self.category = category
        self.productExpir = productExpir
    }
}

//MARK: class mapping
extension fireStoreDataClass: Displayable {
    var nameOfProduct: String {
        return productName
    }
    var idOfProduct: Int? {
        return productQuantity
    }
    var priceOfProduct: Double? {
        priceOfProduct
    }
    var upcOfProduct: String? {
        category
    }
}


struct dietPreferences {
    var dietPreferences: [String]?
}

//MARK: turns days into time remaining
extension Date {
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
}

//MARK: - struct end

class tryagain: NSObject {
    
    var itemImageName: String?
    var listImageName: String?
    var itemName: String?
    var Quantity: String?
    var List: Bool?
    var Pantry: Bool?
    
}

/*
class firestoreDataModel {
    //should only grab name Id and image?
    
    func firebase() {
        userfirebaseProducts.whereField("productList", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
           guard let documents = querySnapshot?.documents else {
             print("No documents")
             return
           }
             
            arrayofProducts = documents.compactMap { queryDocumentSnapshot -> fireStoreDataStruct? in
             return try? queryDocumentSnapshot.data(as: fireStoreDataStruct.self)
           }
            print("this is the new function maybe \(arrayofProducts)")
         }
        
    }
//MARK: - Last }

}
 */
