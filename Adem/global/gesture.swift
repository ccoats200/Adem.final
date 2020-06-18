//
//  gesture.swift
//  Adem
//
//  Created by Coleman Coats on 6/11/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation

//let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
//self.view.addGestureRecognizer(panGestureRecognizer)

/*
 var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
 @objc func panGestureRecognizerAction(_ gesture: UIPanGestureRecognizer) {
     
     let touchPoint = gesture.location(in: self.view?.window)
     
     if gesture.state == UIGestureRecognizer.State.began {
         initialTouchPoint = touchPoint
     } else if gesture.state == UIGestureRecognizer.State.changed {
         if touchPoint.y - initialTouchPoint.y > 0 {
             self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
         }
     } else if gesture.state == UIGestureRecognizer.State.ended || gesture.state == UIGestureRecognizer.State.cancelled {
         if touchPoint.y - initialTouchPoint.y > 100 {
             self.dismiss(animated: true, completion: nil)
         } else {
             UIView.animate(withDuration: 0.3, animations: {
                 self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
             })
         }
     }
     print(gesture)
     
 }
 */
 
