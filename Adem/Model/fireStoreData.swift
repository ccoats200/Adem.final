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

var arrayofProducts = [fireStoreDataStruct]()
//Should be static promote if none in filter
var productCategories = ["All", "Dairy","Fruits","Veggies", "Frozen","Meats","Other"]
var personalProductCategories = ["All"]


struct fireStoreDataStruct: Identifiable, Codable {
    //Grabs the doc Id for me!
     @DocumentID var id: String?
     var productName: String
     var productPrice: Double
     var productDescription: String
     var productQuantity: Int
     var productImage: String
     var category: String?

//     enum CodingKeys: String, CodingKey {
//         case id
//         case productName
//         case productPrice
//         case productDescription
//         case productQuantity
//         case productImage
//     }
//    
 }
 
 
//MARK: - struct end


//var arrayofProducts = [fireStoreDataStruct]()
//Product attributes

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
