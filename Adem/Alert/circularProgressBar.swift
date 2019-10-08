//
//  circularProgressBar.swift
//  Adem
//
//  Created by Coleman Coats on 10/6/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


class circleTest: UIViewController {
    
   
    
    let shapeLayer = CAShapeLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        
        //Create track
        let trackLayer = CAShapeLayer()
        
        
        
        let center = view.center
        
        //http://www.math.com/tables/geometry/circles.htm
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 20,
                                        startAngle: ((3/2) * CGFloat.pi),//(-CGFloat.pi/2),
                                        endAngle: ((5/3) * CGFloat.pi),//(/2 * CGFloat.pi),
                                        clockwise: false)
        
        
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.ademGreen.cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.ademRed.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        

        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    let strokeEnd = "strokeEnd"
    let ur = "urSoBasic"
    
    @objc private func handleTap() {
        print("attempting to animate stroke")
        let basicAnimation = CABasicAnimation(keyPath: strokeEnd)
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: ur)
    }
    
   
}

