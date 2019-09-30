//
//  FirebaseFiles.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Firebase
import FirebaseFirestore

//MARK: ALL table View images need to be 22 px By 22 px

let db = Firestore.firestore()
var docRef: DocumentReference!
var colRef: CollectionReference!
var handle: AuthStateDidChangeListenerHandle?
let currentUser = Auth.auth().currentUser
let firebaseAuth = Auth.auth()


let usersInfo = "Users/user/info/fluid"
let userNames = "Users/user"
let productsInPantry = "Pantry"
let productsInList = "List"
let productsAvailable = "Products"

let usersCollection = "Users/\(currentUser!.uid)"


//Icons
let nutritionFacts = "nutritionFacts"

