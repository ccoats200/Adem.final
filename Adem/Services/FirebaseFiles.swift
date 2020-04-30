//
//  FirebaseFiles.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Firebase

//MARK: ALL table View images need to be 22 px By 22 px
let db = Firestore.firestore()
var docRef: DocumentReference!
var colRef: CollectionReference!
var handle: AuthStateDidChangeListenerHandle?
let currentUser = firebaseAuth.currentUser
let firebaseAuth = Auth.auth()
let userfirebaseProducts = db.collection("Users").document(currentUser!.uid).collection("public").document("products").collection("List")
let userfirebaseMeals = db.collection("Users").document(currentUser!.uid).collection("public").document("products").collection("meals")

//MARK: might delete
let userNames = "Users/user"
let usersColc = "Users"
let privateColc = "private"
let privateinfoDoc = "UsersPrivateInfo"
let productsInPantry = "Pantry"
let productsInList = "List"
let productsAvailable = "Products"
let usersCollection = "Users/\(currentUser!.uid)"

//MARK: spoonacular API
let apiKey = "5f40f799c85b4be089e48ca83e01d3c0"

//Icons
let nutritionFacts = "nutritionFacts"
let heartImage = "heart"
let infoImage = "Info"
let nutImage = "nut_selected"
let fishImage = "fish_selected"

class food {
    var key: String
    var name: String
    
    init(dictionary: [String: Any], key: String) {
        self.key = key
        self.name = dictionary["Users"] as! String
    }
    
}
