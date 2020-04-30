//
//  masterProductList.swift
//  Adem
//
//  Created by Coleman Coats on 3/20/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
 
public func fetchProducts(completion: @escaping (Int) -> (Int)) {
        handle = firebaseAuth.addStateDidChangeListener { (auth, user) in
            let known = db.collection("Users").document(user!.uid).collection("public").document("products").collection("List")
            known.addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                   print("Error fetching document: \(error!)")
                    return
                }
                print("Current number of items in list: \(document.count)")
               
            }
            known.whereField("productList", isEqualTo: true).getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in snapshot!.documents {
                        let productName = document.get("productName")
                        print(productName as! String)
                        print(document.documentID)
                        //append
                        firebaseDocuments.updateValue(productName as! String, forKey: document.documentID)
                    }
                }
            }
        }
    }
