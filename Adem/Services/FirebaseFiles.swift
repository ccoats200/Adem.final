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

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

enum engagements: String {
    case added = "a"
    case removed = "r"
    case engaged = "e"
}

enum wasted: String {
    case oneHundred = "100%"
    case seventyFive = "75%"
    case fifty = "50%"
    case twentyFive = "25%"
    case none = "0%"
}

extension UIViewController {
    
    func addTimeStamp(id: String, action: String) {
        //MARK: use engagements enum for action
        //https://firebase.google.com/docs/firestore/solutions/aggregation
        
        userfirebaseProducts.document(id).collection("listDate").addDocument(data: [
                "date" : Firebase.Timestamp(),
                "action" : action,
                //every 7 days push to collection
            ])
        //use .updateData for adding a new listDate, pantryDate, etc.
    }
    
    func addWasteAmount(id: String, amount: String) {
        
        userfirebaseProducts.document(id).collection("wasteData").addDocument(data: [
                "time" : Firebase.Timestamp(),
                "value" : amount,
            ])
    }
    
    func updateProductQuantityValue(id: String, quantity: Int) {
        // Or more likely change something related to this cell specifically.
        for i in arrayofProducts where i.id == id {
            
            userfirebaseProducts.document("\(i.id!)").updateData([
                "productQuantity": quantity,
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            //TimeStamp
            
            print("hello \(i)")
        }
    }
    
    func updateProductLocationValues(indexPath: String, pantry: Bool, list: Bool){
             
            // Or more likely change something related to this cell specifically.
    //        let cell = listTableView.cellForRow(at: indexPath)
    //        for i in arrayofProducts {//where i.productName == cell?.textLabel?.text {
                
                userfirebaseProducts.document("\(indexPath)").updateData([
                    "productPantry": pantry,
                    "productList": list
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
                //TimeStamp
                
    //        }
    //        let firstProduct = arrayofProducts[0].id
    //        let insertedIndexPath = IndexPath(index: firstProduct!.count)
    //        self.listTableView.insertRows(at: [insertedIndexPath], with: .top)
    //        self.listTableView.reloadData()
        }
}
