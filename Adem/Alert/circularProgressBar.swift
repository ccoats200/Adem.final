//
//  circularProgressBar.swift
//  Adem
//
//  Created by Coleman Coats on 10/6/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


class CircularProgressView: UIView {
    
    // First create two layer properties
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    
    func createCircularPath() {
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 80, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        
        //Circle
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 5.0
        circleLayer.strokeColor = UIColor.ademGreen.cgColor
        
        //Progress
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 5.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.ademRed.cgColor
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    
    
    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .backwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        
    }
}


class circleTest: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var circularView: CircularProgressView!
    var duration: TimeInterval!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circularView.center = view.center
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        view.addSubview(circularView)
        
    }

    @objc func handleTap() {
        duration = 5    //Play with whatever value you want :]
        circularView.progressAnimation(duration: duration)
        
    }
}

