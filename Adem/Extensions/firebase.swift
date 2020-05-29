//
//  firebase.swift
//  Adem
//
//  Created by Coleman Coats on 4/29/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import Firebase


extension QueryDocumentSnapshot {
    func decoded<Type: Decodable>() throws -> Type {
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        let object = try JSONDecoder().decode(Type.self, from: jsonData)
        return object
    }
}

//extension Array where Element: Equatable {
//    mutating func removeDuplicates() {
//        var result = [Element]()
//        for value in self {
//            if !result.contains(value) {
//                result.append(value)
//            }
//        }
//        self = result
//    }
//}
