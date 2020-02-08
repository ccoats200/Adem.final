//
//  PantryDataModel.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
//import FirebaseFirestore
import Firebase


//copy of https://www.youtube.com/watch?v=iID0I0aEzGw&list=PLHmNdpdzx21ElULY_ok6-BBa5z4n0SVDi&index=3&t=0s

struct PhotoCategory {
    var categoryImageName: String
    var title: String
    var imageName: [String]
    
    
}

class PhotosLibrary {
    class func fetchPhotos() -> [PhotoCategory] {
        
        var categories = [PhotoCategory]()
        let photosData = PhotosLibrary.downloadPhotosData()
        
        for (categoryTitle, dict) in photosData {
            if let dict = dict as? [String : Any] {
                let categoryImageName = dict["categoryImageName"] as! String
                if let imageNames = dict["imageNames"] as? [String] {
                    let newCategory = PhotoCategory(categoryImageName: categoryImageName, title: categoryTitle, imageName: imageNames)
                    categories.append(newCategory)
                }
            }
        }
        return categories
    }
    
    class func downloadPhotosData()  -> [String : Any] {
        return [
            "Family" : [
                "categoryImageName" : "family",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "f", numberOfImages: 9),
            ],
            "Foods" : [
                "categoryImageName" : "foods",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "f0", numberOfImages: 8),
            ],
            "Travel" : [
                "categoryImageName" : "travel",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "t", numberOfImages: 8),
            ],
            "Nature" : [
                "categoryImageName" : "nature",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "n", numberOfImages: 9),
            ],
            
        ]
    }
    private class func generateImage(categoryPrefix: String, numberOfImages: Int) -> [String] {
        var imageNames = [String]()
        for i in 1...numberOfImages {
            imageNames.append("\(categoryPrefix)\(i)")
        }
        return imageNames
    }
}
//End Copy

struct pantryProductsStruct {
    
    //MARK: USER Specific
    var productDocumentReferenceID: [String]
}

class dataBaseProducts {
    
    // Add a new document with a generated ID
    var docRef: DocumentReference!
    var handle: AuthStateDidChangeListenerHandle?
    
    
    class func fetchPantryProductImages() -> [pantryProductsStruct] {
        var pantryItemCategories = [pantryProductsStruct]()
        let pantryProductImages = dataBaseProducts.downloadPantryProductInfo()
        
        for (productDocumentReference, dict) in pantryProductImages {
            if let dict = dict as? [String : Any] {
                if let productDocumentReference = dict["productDocumentReferenceID"] as? [String] {
                    let newPhoto = pantryProductsStruct(productDocumentReferenceID: productDocumentReference)
                    
                    pantryItemCategories.append(newPhoto)
                }
                
                
            }
        }
        return pantryItemCategories
    }
    
    class func downloadPantryProductInfo() -> [String : Any] {
        let fdb = Firestore.firestore()
        
        let userdocumentsReference = fdb.collection("users").document().documentID
        
        return [
            "Products" : [
                "productDocumentReference" : dataBaseProducts.generateImage(categoryPrefix: "A", numberOfImages: 9),
                
            ]
            
        ]
        
    }
    
    private class func generateImage(categoryPrefix: String, numberOfImages: Int) -> [String] {
        var pantryProductName = [String]()
        for i in 1...numberOfImages {
            pantryProductName.append("\(categoryPrefix)\(i)")
        }
        return pantryProductName
    }
    
    
}
