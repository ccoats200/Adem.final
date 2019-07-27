//
//  toolBar.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//
import Foundation
import UIKit

extension UIBarButtonItem {
    
    static func custom(with image: UIImage, frame: CGRect = CGRect(x: 0, y: 0, width: 36, height: 36), isRounded: Bool = true, borderWidth: CGFloat = 0, borderColor: UIColor = .white, target: AnyObject?, action: Selector, controlEvents: UIControl.Event = .touchUpInside, showsTouchWhenHighlighted: Bool = true) -> UIBarButtonItem {
        
        let button = UIButton(frame: frame)
        button.setBackgroundImage(image, for: .normal)
        button.showsTouchWhenHighlighted = showsTouchWhenHighlighted
        button.addTarget(target, action: action, for: controlEvents)
        
        if isRounded {
            button.layer.cornerRadius = frame.size.height / 2
        }
        
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor.cgColor
        button.layer.masksToBounds = button.layer.cornerRadius > 0
        
        let buttonItem = UIBarButtonItem(customView: button)
        
        return buttonItem
    }
}
