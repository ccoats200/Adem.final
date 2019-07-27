//
//  Circle Trasition.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class TransitionCoordinator: UICollectionViewCell, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UICollectionViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircularTransition()
    }
    
    
}
