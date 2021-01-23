//
//  firebaseFetches.swift
//  Adem
//
//  Created by Coleman Coats on 1/21/21.
//  Copyright © 2021 Coleman Coats. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Resolver


class FirestoreFetches {
    
    
    
    func FirestoreListForAuthUser() {
        listfirebaseProducts.document("cpVa58Up92hrJ3i4o4tqvgvPOte2").collection("list").whereField("productList", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
        }
            arrayofProducts = documents.compactMap { queryDocumentSnapshot -> fireStoreDataClass? in
                return try? queryDocumentSnapshot.data(as: fireStoreDataClass.self)
            }
     }
    }
    
    func FirestorePantryForAuthUser() {
        let listId = privatehomeAttributes["listId"] as! String
        print(listId)
        listfirebaseProducts.document("\(listId)").collection("list").whereField("productPantry", isEqualTo: true).addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                arrayofPantry = documents.compactMap { queryDocumentSnapshot -> fireStoreDataClass? in
                    return try? queryDocumentSnapshot.data(as: fireStoreDataClass.self)
                }
    
            }
        }
    }

