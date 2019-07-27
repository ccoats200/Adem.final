//
//  CircleTransition.swift
//  Adem
//
//  Created by Coleman Coats on 7/27/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//
import UIKit

protocol CircleTransitionable {
    var triggerButton: UICollectionViewCell { get }
    //var triggerButton: UIButton { get }
    var contentTextView: UIScrollView { get }
    var mainView: UIView { get }
}

class CircularTransition: UICollectionViewCell, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)
        -> TimeInterval {
            return 0.5
            
            
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? CircleTransitionable,
            let toVC = transitionContext.viewController(forKey: .to) as? CircleTransitionable,
            let snapshot = fromVC.mainView.snapshotView(afterScreenUpdates: false) else {
                transitionContext.completeTransition(false)
                return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(snapshot)
        fromVC.mainView.removeFromSuperview()
        //toVC.mainView.didMoveToSuperview()
        
        animateOldTextOffscreen(fromView: snapshot as! UICollectionView)
        
    }
    
    func animateOldTextOffscreen(fromView: UICollectionView) {
        // 1
        UICollectionView.animate(withDuration: 0.25,
                                 delay: 0.0,
                                 options: [.curveEaseIn],
                                 animations: {
                                    // 2
                                    fromView.center = CGPoint(x: fromView.center.x - 1300,
                                                              y: fromView.center.y + 1500)
                                    // 3
                                    fromView.transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
        }, completion: nil)
        
    }
}
