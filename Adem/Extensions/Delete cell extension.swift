//
//  Delete cell extension.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


extension listCollectionView : ListItemDelegate {
    
    func delete(cell: productCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            //    products?[indexPath.section].itemName?.remove(at: indexPath.item)
            
            //    collectionView?.deleteItems(at: [indexPath])
            //}
            //collectionView?.deleteItems(at: [indexPath])
        }
    }
}
