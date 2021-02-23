//
//  alamoFireSearch.swift
//  Adem
//
//  Created by Coleman Coats on 2/22/21.
//  Copyright © 2021 Coleman Coats. All rights reserved.
//

import Foundation
import Alamofire

protocol Displayable {
  var nameOfProduct: String { get }
}

struct searchedProduct: Decodable {
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}

struct searchedProducts: Decodable {
  let all: [searchedProduct]
  
  enum CodingKeys: String, CodingKey {
    case all = "products"
  }
}

extension searchedProduct: Displayable {
    var nameOfProduct: String {
        title
      }
}
