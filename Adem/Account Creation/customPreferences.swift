//
//  customPreferences.swift
//  Adem
//
//  Created by Coleman Coats on 1/25/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

struct Model {
   var title: String
}

class ViewModelItem {
   private var item: Model
   var isSelected = false
   var title: String {
      return item.title
   }
   init(item: Model) {
      self.item = item
   }
}

let dataArray = [Model(title: "Salty"),
Model(title: "Sweet"),
Model(title: "Spicy"),
Model(title: "Biter"),
Model(title: "Fruity")]

