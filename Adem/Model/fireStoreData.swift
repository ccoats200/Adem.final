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
var arrayofPantry = [fireStoreDataClass]()
//var arrayofProducts = [fireStoreDataStruct]()
var arrayofProducts = [fireStoreDataClass]()
var backUp = [fireStoreDataStruct]()
var backUp2 = [fireStoreDataStruct]()
var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
//Should be static add promote if none in filter
var productCategories = ["All", "Dairy","Fruit","Veggies", "Frozen","Meat","Other", "Extract"]
var personalProductCategories = ["All",]
var searchDimensions = ["Add","List"]

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

class fireStoreDataClass: NSObject, Identifiable, Codable {

   //Grabs the doc Id for me!
   @DocumentID var id: String?
   @objc var productName: String
   @objc var productPrice: Double
   @objc var productDescription: String
   @objc var productQuantity: Int
   @objc var productImage: String
   @objc var category: String?
   @objc var productExpir: Date
   
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
    
    enum ExpressionKeys: String {
       case id
       case productName
       case productPrice
       case productDescription
       case productQuantity
       case productImage
       case category
       case productExpir
    }
    
    init(id: String, productName: String, productPrice: Double, productDescription: String, productQuantity: Int, productImage: String, category: String, productExpir: Date) {
        self.id = id
        self.productName = productName
        self.productPrice = productPrice
        self.productDescription = productDescription
        self.productQuantity = productQuantity
        self.productImage = productImage
        self.category = category
        self.productExpir = productExpir
    }
    
    /*
    //MARK: This is where things are weird
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        productName = try container.decode(String.self, forKey: .productName)
        productPrice = try container.decode(Double.self, forKey: .productPrice)
        productDescription = try container.decode(String.self, forKey: .productDescription)
        productQuantity = try container.decode(Int.self, forKey: .productQuantity)
        productImage = try container.decode(String.self, forKey: .productImage)
        category = try container.decode(String.self, forKey: .category)
        productExpir = try container.decode(Date.self, forKey: .productExpir)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(productName, forKey: .productName)
        try container.encode(productPrice, forKey: .productPrice)
        try container.encode(productDescription, forKey: .productDescription)
        try container.encode(productQuantity, forKey: .productQuantity)
        try container.encode(productImage, forKey: .productImage)
        try container.encode(category, forKey: .category)
        try container.encode(productExpir, forKey: .productExpir)
    }
 */
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
