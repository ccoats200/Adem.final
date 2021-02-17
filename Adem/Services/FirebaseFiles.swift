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
//let currentHome = firebaseAuth.
let firebaseAuth = Auth.auth()
let listId = privatehomeAttributes["listId"] as? String

let currentListID = defaults.value(forKey: "listId")
let homeListID = defaults.value(forKey: "uid")
let currentUserStatus = defaults.value(forKey: "isAnonymous")

let userfirebaseProducts = db.collection("user").document(currentUser!.uid).collection("public").document("products").collection("List")
let listfirebaseProducts = db.collection("lists")
let productAnalytics = listfirebaseProducts.document("\(currentListID!)").collection("list")

//let userfirebaseProducts = db.collection("home").document(currentUser!.uid).collection("members").document(currentUser!.uid).collection("public").document("products").collection("List")
let roomatesfirebaseProducts = db.collection("home").document("\(privatehomeAttributes["home"])").collection("members").document("\(privatehomeAttributes["home"])").collection("public").document("products").collection("List")


let userfirebasehome = db.collection("Users").document(currentUser!.uid).collection("private").document("UsersPrivateInfo")
//FIXME: Adding the products

let addProducts = db.collection("groceryProducts")
//FIXME: Adding the products


//let userfirebaseMeals = db.collection("Users").document(currentUser!.uid).collection("public").document("products").collection("meals")
let userfirebaseMeals = db.collection("Users").document(currentUser!.uid).collection("public").document("meals").collection("all")
let userfirebaseDietPreferences = db.collection("user").document(currentUser!.uid).collection("preferences")
//let userfirebaseDietPreferences = db.collection("home").document(currentUser!.uid).collection("members").document(currentUser!.uid).collection("preferences")
//let userfirebaseHomeSettings = db.collection("home").document(currentUser!.uid).collection("members").document(currentUser!.uid).collection("private").document("usersPrivateData")
//let userPrivateSettings = db.collection("home").document(currentUser!.uid).collection("members").document(currentUser!.uid).collection("private")
//let userfirebaseHousehold = db.collection("home").document(currentUser!.uid).collection("members").document(currentUser!.uid).collection("private").document("household")
let userfirebaseHomeSettings = db.collection("user").document(currentUser!.uid).collection("private").document("usersPrivateData")
let userPrivateSettings = db.collection("user").document(currentUser!.uid).collection("private")
let userfirebaseHousehold = db.collection("user").document(currentUser!.uid).collection("private").document("household")


//MARK: - Testing on

//MARK: - The home set up
/*
let userfirebaseProducts = db.collection("home").document("The Bev").collection("Users").document(currentUser!.uid).collection("public").document("products").collection("List")
//let userfirebaseMeals = db.collection("Users").document(currentUser!.uid).collection("public").document("products").collection("meals")
let userfirebaseMeals = db.collection("home").document("The Bev").collection("Users").document(currentUser!.uid).collection("public").document("meals").collection("all")
//let userfirebaseDietPreferences = db.collection("Users").document("B0DOT6FsvLfmhoUw9CIKGkWHxZM2").collection("preferences")
let userfirebaseDietPreferences = db.collection("home").document("The Bev").collection("Users").document(currentUser!.uid).collection("preferences")
*/

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

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

enum engagements: String {
    case added = "a"
    case list = "l"
    case pantry = "p"
    case removed = "r"
    case engaged = "e"
}

enum preference: String {
    case diet = "diet"
    case flavors = "flavor"
    case stores = "stores"
}

enum wasted: String {
    case oneHundred = "100%"
    case seventyFive = "75%"
    case fifty = "50%"
    case twentyFive = "25%"
    case none = "0%"
}

func getRootController () -> UIViewController { // function in global scope
    return (UIApplication.shared.delegate?.window!!.rootViewController)!
}

extension UIViewController {
    
    //MARK: -timeStamp
    func addTimeStamp(id: String, action: String) {
        //MARK: use engagements enum for action
        //https://firebase.google.com/docs/firestore/solutions/aggregation
        
        productAnalytics.document(id).collection("listDate").addDocument(data: [
                "date" : Firebase.Timestamp(),
                "action" : action,
                //every 7 days push to collection
            ])
        //use .updateData for adding a new listDate, pantryDate, etc.
    }
    
    //MARK: -Waste
    func addWasteAmount(id: String, amount: String) {
        
        productAnalytics.document(id).collection("wasteData").addDocument(data: [
                "time" : Firebase.Timestamp(),
                "value" : amount,
            ])
    }
    func topMostViewController() -> UIViewController {

        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }

        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }

        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }

        return self
    }
    
    //MARK: -Quantity
    func updateProductQuantityValue(id: String, quantity: Int) {
        // Or more likely change something related to this cell specifically.
       if arrayofProducts.contains(where: { $0.id == id}) {
        productAnalytics.document("\(id)").updateData([
               "productQuantity": quantity,
           ]) { err in
               if let err = err {
                   print("Error updating document: \(err)")
               } else {
                   print("Document successfully updated")
               }
           }
       } else if arrayofPantry.contains(where: { $0.id == id}) {
        productAnalytics.document("\(id)").updateData([
               "productQuantity": quantity,
           ]) { err in
               if let err = err {
                   print("Error updating document: \(err)")
               } else {
                   print("Document successfully updated")
               }
           }
       }
    }
    
    //MARK: -List/Pantry
    func updateProductLocationValues(indexPath: String, pantry: Bool, list: Bool){
        productAnalytics.document("\(indexPath)").updateData([
            "productPantry": pantry,
            "productList": list
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    //MARK: -Preferences
    func updatePreferences(preferenceDimension: String, preferenceMap: [String]) {
        //the dimension should be the diet, stores, flavors, etc. It has it's own doc in FB
        // the map should be the values that are in that dimension
        userfirebaseDietPreferences.document("\(preferenceDimension)").setData([
            "\(preferenceDimension)": preferenceMap,
        ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    
    //Might be useful
       func addCategory(id: String) {
        productAnalytics.document(id).setData([
               "category" : "Extract"], merge: true)
       }
    
    func newUserInformation(dietPreferences: [String]) {
        //MARK: Private data
        db.document(currentUser!.uid).collection("private").document("preferences").setData([
                "dietPreferences": dietPreferences
            ]) { (error) in
                
                if let error = error {
                    print("Error creating documents: \(error.localizedDescription)")
                }
            }
        }
    }

