//
//  ProductCell.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var calCount: UILabel!
    
}

class pantryProductFirstCell: UICollectionViewCell {
    //This cell is for basic info on the product and has general price and prdouct infor as well as buttons to view controllers that have text boxes. ie: Vegan, nurtuition info
    
    
}

class pantryProductSecondCell: UICollectionViewCell {
    //This Cell is for similar products scroll view and recepies scroll view
}

class pantryProductThirdCell: UICollectionViewCell {
    //This Cell is for reviews
}
