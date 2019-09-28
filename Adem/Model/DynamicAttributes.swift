//
//  DynamicAttributes.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//


import Foundation
import UIKit
import FirebaseFirestore
import Firebase

/*
 struct groceryProductCellAttributes {
 //might need to be Bool
 var associated = false
 var list: Bool
 var pantry: Bool
 var productsName: String
 var productsImage: String
 }
 
 class grabProductsFromFirebase {
 
 class func fetchingGroceryProductImages() -> [groceryProductCellAttributes] {
 let db = Firestore.firestore()
 var groceryProduct = [groceryProductCellAttributes]()
 let groceryProductImages = groceryProducts.downloadGroceryProductInfo()
 
 
 
 handle = Auth.auth().addStateDidChangeListener { (auth, user) in
 
 let user = Auth.auth().currentUser
 if let user = user {
 let nameOfUser = user.email
 
 }
 
 colRef.getDocuments { (colSnapshot, error) in
 guard let colSnapshot = colSnapshot, colSnapshot.isEmpty else { return }
 let collectionData = colSnapshot.documents
 }
 docRef.addSnapshotListener { (docSnapshot, error) in
 guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
 let userNameData = docSnapshot.data()
 let usersName = userNameData?["FirstName"] as? String ?? ""
 profileImageCellLayout().userProfileName.text = "\(usersName)"
 profileImageCellLayout().userProfileImageView.image = UIImage(named: "eggs")
 }
 
 }
 }
 */

struct groceryProductsStruct {
    
    //USER Specific
    var groceryProductImageName: String
    var groceryProductName: [String]
    var groceryProductQuantity: String
    var groceryProductCategory: String
    
    /*
     //Manufacture produced Info
     var groceryProductServingSize: String
     var groceryProductCalories: String
     var groceryProductTotalFat: String
     var groceryProductSaturatedFat: String
     var groceryProductTransFat: String
     var groceryProductCholesterol: String
     var groceryProductSodium: String
     var groceryProductTotalCarbohydrate: String
     var groceryProductDietaryFiber: String
     var groceryProductSugars: String
     var groceryProductProtein: String
     var groceryProductVitmans: String
     */
    
    
}


class groceryProducts {
    
    class func fetchGroceryProductImages() -> [groceryProductsStruct] {
        var groceryItemCategories = [groceryProductsStruct]()
        let groceryProductImages = groceryProducts.downloadGroceryProductInfo()
        
        for (productCategory, dict) in groceryProductImages {
            if let dict = dict as? [String : Any] {
                let groceryProductQuantities = dict["groceryProductQuantity"] as! String
                let groceryProductImageName = dict["groceryProductImageName"] as! String
                if let groceryProductNames = dict["groceryProductName"] as? [String] {
                    let newPhoto = groceryProductsStruct(groceryProductImageName: groceryProductImageName, groceryProductName: groceryProductNames, groceryProductQuantity: groceryProductQuantities, groceryProductCategory: productCategory)
                    
                    groceryItemCategories.append(newPhoto)
                }
                
                
            }
        }
        return groceryItemCategories
    }
    
    class func downloadGroceryProductInfo() -> [String : Any] {
        let groceryProductcount = 1
        
        return [
            "Products" : [
                "groceryProductCategory" : "foods",
                "groceryProductImageName" : "Eggs",
                "groceryProductName" : "Eggs",
                "groceryProductQuantity" : "\(groceryProductcount)",
            ]
            
        ]
        
    }
}

//Product attributes
class groceryItemCellContent: NSObject {
    
    //    var docRef: DocumentReference!
    //
    //    docRef.getDocument(completion: { (docSnapshot, error) in
    //    guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
    //    let personNameData = docSnapshot.data()
    //    let nameData = personNameData?["list"] as? String ?? ""
    //
    //    })
    
    var itemImageName: String?
    var itemName: String?
    var Quantity: String?
    var List: Bool?
    var Pantry: Bool?
}



//Profile attributes
class profileContent: NSObject {
    
    
    var profileImage: String?
    var profielImageIdentifier: String?
    var personName: String?
    var devices: String?
    var family: String?
    var allergies: String?
    var deviceImage: String?
    var userNameLabel: String?
    var accountImage: String?
    var privacyImage: String?
}

struct thrownOutAlert: alertInformation {
    
    var alertProductName: String?
    var alertProductImageName: String?
    
}


//Alert Elements
class thrownOut: NSObject {
    
    
    var thrownItemImage: String?
    var thrownItemName: String?
}



