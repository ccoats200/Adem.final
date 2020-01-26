//
//  Products.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import Firebase


struct groceryProductsDatabase {
    
    //USER Specific
    //var groceryProductImgUrl: String
    var groceryProductName: String
    //var groceryProductCategory: String
}

var allproductsInList = [
    groceryProductsDatabase(groceryProductName: "Eggs"),
    groceryProductsDatabase(groceryProductName: "Bacon"),
    groceryProductsDatabase(groceryProductName: "Waffels"),
    groceryProductsDatabase(groceryProductName: "Chicken"),
    groceryProductsDatabase(groceryProductName: "Kale"),
    groceryProductsDatabase(groceryProductName: "Kraft Mac and cheese"),
    groceryProductsDatabase(groceryProductName: "Milk"),
    groceryProductsDatabase(groceryProductName: "Fuck")
]
var fuckthis = [
    "fuck", "Eggs", "Bacon", "Waffels","Chicken","Kale","Kraft Mac and cheese","Milk","Fuck"
]


//Product attributes
class groceryItemCellContent: NSObject {
    
    var itemImageName: String?
    var listImageName: String?
    var itemName: String?
    var Quantity: String?
    var List: Bool?
    var Pantry: Bool?
    
}
struct groceryItemCellContents {
    
    var itemImageName: String?
    var listImageName: String?
    var itemName: String?
    var Quantity: String?
    var List: Bool?
    var Pantry: Bool?
    
}

var productsGlobal: [groceryItemCellContent]? = {
    
    var eggs = groceryItemCellContent()
    eggs.itemName = "Egg"
    eggs.itemImageName = "eggs"
    eggs.Quantity = "2"
    eggs.List = true
    eggs.Pantry = false
    
    var bb = groceryItemCellContent()
    bb.itemName = "BlueBerry"
    bb.itemImageName = "blueBerry"
    bb.Quantity = "3"
    bb.List = true
    bb.Pantry = false
    
    var bre = groceryItemCellContent()
    bre.itemName = "Bacon"
    bre.itemImageName = "bread"
    bre.Quantity = "1"
    bre.List = true
    bre.Pantry = false
    
    var tea = groceryItemCellContent()
    tea.itemName = "Kale"
    tea.itemImageName = "bread"
    tea.Quantity = "1"
    tea.List = true
    tea.Pantry = true
    
    var a = groceryItemCellContent()
    a.itemName = "Water"
    a.itemImageName = "bread"
    a.Quantity = "1"
    a.List = false
    a.Pantry = true
    
    var b = groceryItemCellContent()
    b.itemName = "Salt"
    b.itemImageName = "bread"
    b.Quantity = "1"
    b.List = false
    b.Pantry = true
    
    var c = groceryItemCellContent()
    c.itemName = "Tea"
    c.itemImageName = "bread"
    c.Quantity = "1"
    c.List = false
    c.Pantry = true
    
    var d = groceryItemCellContent()
    d.itemName = "Coffee"
    d.itemImageName = "bread"
    d.Quantity = "1"
    d.List = false
    d.Pantry = true
    
    var e = groceryItemCellContent()
    e.itemName = "Chicken"
    e.itemImageName = "bread"
    e.Quantity = "1"
    e.List = false
    e.Pantry = true
    
    var f = groceryItemCellContent()
    f.itemName = "Seltzer"
    f.itemImageName = "bread"
    f.Quantity = "1"
    f.List = true
    f.Pantry = false
    
    var g = groceryItemCellContent()
    g.itemName = "Bread"
    g.itemImageName = "bread"
    g.Quantity = "1"
    g.List = false
    g.Pantry = true
    
    return [eggs, bb, bre,tea,a,b,c,d,e,f,g]
}()
