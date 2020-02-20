//
//  Design.Elements.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//
import Foundation
import UIKit

//MARK: Fonts
let headerFont = "Montserrat"
let searchPromptFont = "Montserrat"
let buttonFont = "Avenir"
let productFont = "Open Sans"

//Color Extension
extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    //All custom color names
    static let ademGreen = UIColor.rgb(red: 2, green: 180, blue: 0)//30, green: 188, blue: 29)
    static let ademBlue = UIColor.rgb(red: 59, green: 94, blue: 101)
    static let ademRed = UIColor.rgb(red: 216, green: 15, blue: 4)
}

//Constraints Extension
extension UIView {
    func addConstraintsWithFormats(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

//SuperClass Collection View Cell
class CellBasics: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum deviceViews: Int {
    
    case Ble = 0, Ble1 = 1, Ble2 = 2, Ble3 = 3
}




extension UITextField {
    
    /// set icon of 20x20 with left padding of 8px
    func setLeftIcon(_ icon: UIImage) {
        
        let padding = 8
        let size = 20
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
}


//MARK: Gesture

class gesture {
    
    func gestSave() {
    //User interations
    let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(addLongGestureRecognizer))
    lpgr.minimumPressDuration = 0.35
//    self.listCollectionView.addGestureRecognizer(lpgr)
        
    }
    
    @objc func addLongGestureRecognizer(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        /*
        
        if gestureRecognizer.state != .began { return }
        //let p = gestureRecognizer.location(in: self.collectionView)
        let p = gestureRecognizer.location(in: self.listCollectionView)
        //if let indexPath = self.collectionView.indexPathForItem(at: p) {
        if let indexPath = self.listCollectionView.indexPathForItem(at: p) {
            //let cell = self.collectionView.cellForItem(at: indexPath)
            
            navigationController?.isEditing = true
            
        } else {
            print("can't find")
        }
        */
    }
}
